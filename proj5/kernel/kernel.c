#include "kernel.h"
#include "lib.h"

// kernel.c
//
//    This is the kernel.


// INITIAL PHYSICAL MEMORY LAYOUT
//
//  +-------------- Base Memory --------------+
//  v                                         v
// +-----+--------------------+----------------+--------------------+---------/
// |     | Kernel      Kernel |       :    I/O | App 1        App 1 | App 2
// |     | Code + Data  Stack |  ...  : Memory | Code + Data  Stack | Code ...
// +-----+--------------------+----------------+--------------------+---------/
// 0  0x040000            0x080000 0x0A0000 0x100000             0x140000
//                                             ^
//                                             | \___ PROC_SIZE ___/
//                                      PROC_START_ADDR

#define PROC_SIZE 0x40000       // initial state only

static proc processes[NPROC];   // array of process descriptors
                                // Note that `processes[0]` is never used.
proc* current;                  // pointer to currently executing proc

#define HZ 100                  // timer interrupt frequency (interrupts/sec)
static unsigned ticks;          // # timer interrupts so far

void schedule(void);
void run(proc* p) __attribute__((noreturn));

static uint8_t disp_global = 1;         // global flag to display memviewer

// PAGEINFO
//
//    The pageinfo[] array keeps track of information about each physical page.
//    There is one entry per physical page.
//    `pageinfo[pn]` holds the information for physical page number `pn`.
//    You can get a physical page number from a physical address `pa` using
//    `PAGENUMBER(pa)`. (This also works for page table entries.)
//    To change a physical page number `pn` into a physical address, use
//    `PAGEADDRESS(pn)`.
//
//    pageinfo[pn].refcount is the number of times physical page `pn` is
//      currently referenced. 0 means it's free.
//    pageinfo[pn].owner is a constant indicating who owns the page.
//      PO_KERNEL means the kernel, PO_RESERVED means reserved memory (such
//      as the console), and a number >=0 means that process ID.
//
//    pageinfo_init() sets up the initial pageinfo[] state.

typedef struct physical_pageinfo {
    int8_t owner;
    int8_t refcount;
} physical_pageinfo;

static physical_pageinfo pageinfo[PAGENUMBER(MEMSIZE_PHYSICAL)];

typedef enum pageowner {
    PO_FREE = 0,                // this page is free
    PO_RESERVED = -1,           // this page is reserved memory
    PO_KERNEL = -2              // this page is used by the kernel
} pageowner_t;

static void pageinfo_init(void);


// Memory functions

void check_virtual_memory(void);
void memshow_physical(void);
void memshow_virtual(x86_64_pagetable* pagetable, const char* name);
void memshow_virtual_animate(void);


// ============================== mine ============================== 
int forked;
int freed;



// kernel(command)
//    Initialize the hardware and processes and start running. The `command`
//    string is an optional string passed from the boot loader.

static void process_setup(pid_t pid, int program_number);

void kernel(const char* command) {
    hardware_init();
    pageinfo_init();
    console_clear();
    timer_init(HZ);

    // use virtual_memory_map to remove user permissions for kernel memory
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
					   PROC_START_ADDR, PTE_P | PTE_W);
   
    // return user permissions to console
    virtual_memory_map(kernel_pagetable, (uintptr_t) CONSOLE_ADDR, (uintptr_t) CONSOLE_ADDR,
					   PAGESIZE, PTE_P | PTE_W | PTE_U);

	// I believe my code is safe because I use v_m_m to assign permissions
	// to all memory before the start of ANY processes. This means that 
	// the assign_page function is never capable of assigning this memory
	// to a process.

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
    for (pid_t i = 0; i < NPROC; i++) {
        processes[i].p_pid = i;
        processes[i].p_state = P_FREE;
    }

    if (command && strcmp(command, "fork") == 0) {
        process_setup(1, 4);
    } else if (command && strcmp(command, "forkexit") == 0) {
        process_setup(1, 5);
    } else if (command && strcmp(command, "test") == 0) {
        process_setup(1, 6);
    } else if (command && strcmp(command, "test2") == 0) {
        for (pid_t i = 1; i <= 2; ++i) {
            process_setup(i, 6);
        }
    } else {
        for (pid_t i = 1; i <= 4; ++i) {
            process_setup(i, i - 1);
        }
    }


    // Switch to the first process using run()
    run(&processes[1]);
}

// next_free_pages(uintptr_t *, int)
//    loads uintptr_t * with the address of the next n free pages in the kernel
//    returns 0 on success, -1 on failure

int next_free_pages(uintptr_t *fill, int n) {
	int c = 0;
	for (uintptr_t pa = 0; pa < MEMSIZE_PHYSICAL; pa += PAGESIZE) {
		if (pageinfo[PAGENUMBER(pa)].owner == PO_FREE 
			&& pageinfo[PAGENUMBER(pa)].refcount == 0) {
			fill[c] = pa;
			c++;
		}

		if (c == n)
			return 0;
	}
	return -1;
}

// next_free_page(uintptr_t *)
//    loads uintptr_t * with the address of the next free page in the kernel
//    returns 0 on success, -1 on failure

int next_free_page(uintptr_t *fill) {
	return next_free_pages(fill, 1);
}

// pagetable_setup(pid)
//    given a process, sets up pagetable in the kernel space
//
//    returns 0 on success, -1 on failure

int pagetable_setup(pid_t pid) {
    uintptr_t pagetable_pages[5];

    if (next_free_pages(pagetable_pages, 5))
	    return -1;

    for (int i = 0; i< 5; i++) {
	assign_physical_page(pagetable_pages[i], pid);
	memset((void *) pagetable_pages[i], 0, PAGESIZE);
    }

    ((x86_64_pagetable *) pagetable_pages[0])->entry[0] =
        (x86_64_pageentry_t) pagetable_pages[1] | PTE_P | PTE_W | PTE_U;
    
    ((x86_64_pagetable *) pagetable_pages[1])->entry[0] =
        (x86_64_pageentry_t) pagetable_pages[2] | PTE_P | PTE_W | PTE_U;

    ((x86_64_pagetable *) pagetable_pages[2])->entry[0] =
        (x86_64_pageentry_t) pagetable_pages[3] | PTE_P | PTE_W | PTE_U;

    ((x86_64_pagetable *) pagetable_pages[2])->entry[1] =
        (x86_64_pageentry_t) pagetable_pages[4] | PTE_P | PTE_W | PTE_U;

   
    memcpy((void *)pagetable_pages[3], &kernel_pagetable[3], 
	   sizeof(x86_64_pageentry_t) * PAGENUMBER(PROC_START_ADDR));

    processes[pid].p_pagetable = (x86_64_pagetable *) pagetable_pages[0];

    return 0;
}


// process_setup(pid, program_number)
//    Load application program `program_number` as process number `pid`.
//    This loads the application's code and data into memory, sets its
//    %rip and %rsp, gives it a stack page, and marks it as runnable.

void process_setup(pid_t pid, int program_number) {
    process_init(&processes[pid], 0);
    //processes[pid].p_pagetable = kernel_pagetable;
    //++pageinfo[PAGENUMBER(kernel_pagetable)].refcount; //increase refcount since kernel_pagetable was used

    pagetable_setup(pid);

    int r = program_load(&processes[pid], program_number, NULL);
    assert(r >= 0);

    processes[pid].p_registers.reg_rsp = MEMSIZE_VIRTUAL; 
    uintptr_t stack_page_va = processes[pid].p_registers.reg_rsp - PAGESIZE;
    uintptr_t stack_page_pa;
    next_free_page(&stack_page_pa);
    assign_physical_page(stack_page_pa, pid);
    virtual_memory_map(processes[pid].p_pagetable, stack_page_va, stack_page_pa,
                       PAGESIZE, PTE_P | PTE_W | PTE_U);
    processes[pid].p_state = P_RUNNABLE;
}


// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
    if ((addr & 0xFFF) != 0								 // this check is that the permission bits are 0
        || addr >= MEMSIZE_PHYSICAL
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
        return -1;
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
        pageinfo[PAGENUMBER(addr)].owner = owner;
        return 0;
    }
}

void syscall_mapping(proc* p){

    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
    uintptr_t ptr = p->p_registers.reg_rsi;

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
	return;
    uintptr_t endaddr = map.pa + sizeof(vamapping) - 1;
    // check for write access for end address
    vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
    if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
	return;
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
}

void syscall_mem_tog(proc* process){

    pid_t p = process->p_registers.reg_rdi;
    if(p == 0) {
        disp_global = !disp_global;
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
            return;
        process->display_status = !(process->display_status);
    }
}

// ---------- FORK HELPERS ----------

// next_free_process(void)
//    returns the next free pid, -1 if there aren't any

pid_t next_free_pid(void) {
	for (pid_t pid = 1; pid < NPROC; pid++)
		if (processes[pid].p_state == P_FREE)
			return pid;
	return -1;
}


// copy_pagetable(proc *dest, proc *src)
//		maps used virtual addresses in src. if the 
//		address is readonly, updates page ref
//		otherwise, copies contents to a new physical page
//
//		returns 0 on success, -1 on failure

int copy_pagetable(proc *dest, proc *src) {
	for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
		vamapping map = virtual_memory_lookup(src->p_pagetable, va); // examining addr page by page
		
		if (map.pn == -1) { // unused va
			continue;
		}
		else if ((map.perm & PTE_P) && !(map.perm & PTE_W) && (map.perm & PTE_U)) { // how to detect readonly memory?
			pageinfo[map.pn].refcount++;	
			virtual_memory_map(dest->p_pagetable, va, map.pa, PAGESIZE, map.perm);
			//if (map.pa == 0x7000) {
			//	log_printf("refed by proc: %d, refcount: %d\n", dest->p_pid, pageinfo[PAGENUMBER(0x7000)].refcount);
			//	console_printf(CPOS(23, 0), 0x0, 0);	
			//	console_printf(CPOS(23, 0), 0x1100, "proc 1 code page owner: %d, proc 1 code page refcount: %d\n", pageinfo[PAGENUMBER(0x7000)].owner, pageinfo[PAGENUMBER(0x7000)].refcount); 
			//}
		}
		else {
			uintptr_t free_page;
			if (next_free_page(&free_page)
				|| assign_physical_page(free_page, dest->p_pid)
				|| virtual_memory_map(dest->p_pagetable, va, free_page, PAGESIZE, map.perm)) {

				// failure conditions are 
				//  no free page, 
				//  no allocated l1 pagetable <-- i don't think we'll ever actually run into this 

				return -1;
			}
			else {
				memcpy((void *) free_page, (void *) map.pa, PAGESIZE);
			}
		}
	}

	return 0;
}

// free_pages_pa(proc *)
//		frees physical pages that belong to process pid
//		this is used when you don't have a pagetable to 
//		perform address translation with
//
//		in particular, note that it only frees pages that
//		it owns. this must be called after freeing virtual
//		pages!
//
//		in practice, this function frees pagetable pages


void free_pagetable_pages(proc *p) {
	x86_64_pagetable *page = p->p_pagetable;

	// l4 pagetable	
	pageinfo[PAGENUMBER(page)].owner = PO_FREE;
	--pageinfo[PAGENUMBER(page)].refcount;

	// l3 pagetable
	page = (x86_64_pagetable *) PTE_ADDR(page->entry[0]);
	pageinfo[PAGENUMBER(page)].owner = PO_FREE;
	--pageinfo[PAGENUMBER(page)].refcount;

	// l2 pagetable
	page = (x86_64_pagetable *) PTE_ADDR(page->entry[0]); 
	pageinfo[PAGENUMBER(page)].owner = PO_FREE;
	--pageinfo[PAGENUMBER(page)].refcount;

	// l1 pagetables
	x86_64_pagetable *l1 = (x86_64_pagetable *) PTE_ADDR(page->entry[0]);
	pageinfo[PAGENUMBER(l1)].owner = PO_FREE;
	--pageinfo[PAGENUMBER(l1)].refcount;
	
	l1 = (x86_64_pagetable *) PTE_ADDR(page->entry[1]);
	pageinfo[PAGENUMBER(l1)].owner = PO_FREE;
	--pageinfo[PAGENUMBER(l1)].refcount;
}

// free_process_pages(pid_t pid)
//		frees physical pages allocated to the process with pid

void free_pages_va(proc *p) {
	for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
		vamapping map = virtual_memory_lookup(p->p_pagetable, va); // examining addr page by page
		
		if (map.pn == -1) { // unused va
			continue;
		}
		else if ((map.perm & PTE_P) && (map.perm & PTE_U)) {
			if (pageinfo[map.pn].owner == p->p_pid)
				pageinfo[map.pn].owner = PO_FREE;
			--pageinfo[map.pn].refcount;	
			//if (map.pa == 0x7000) {
			//	log_printf("freed by: %d, refcount: %d\n", p->p_pid, pageinfo[PAGENUMBER(0x7000)].refcount);
			//	console_printf(CPOS(23, 0), 0x0, 0);	
			//	console_printf(CPOS(23, 0), 0x1100, "proc 1 code page owner: %d, proc 1 code page refcount: %d\n", pageinfo[PAGENUMBER(0x7000)].owner, pageinfo[PAGENUMBER(0x7000)].refcount); 
			//}
		}
	}
}

// ----------     END      ----------

// exception(reg)
//    Exception handler (for interrupts, traps, and faults).
//
//    The register values from exception time are stored in `reg`.
//    The processor responds to an exception by saving application state on
//    the kernel's stack, then jumping to kernel assembly code (in
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
    set_pagetable(kernel_pagetable);

    // It can be useful to log events using `log_printf`.
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
    if ((reg->reg_intno != INT_PAGEFAULT && reg->reg_intno != INT_GPF) // no error due to pagefault or general fault
            || (reg->reg_err & PFERR_USER)) // pagefault error in user mode 
    {
        check_virtual_memory();
        if(disp_global){
            memshow_physical();
            memshow_virtual_animate();
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();


    // Actually handle the exception.
    switch (reg->reg_intno) {

    case INT_SYS_PANIC:
	    // rdi stores pointer for msg string
	    {
		char msg[160];
		uintptr_t addr = current->p_registers.reg_rdi;
		if((void *)addr == NULL)
		    panic(NULL);
		vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
		memcpy(msg, (void *)map.pa, 160);
		panic(msg);

	    }
	    panic(NULL);
	    break;                  // will not be reached

    case INT_SYS_GETPID:
        current->p_registers.reg_rax = current->p_pid;
        break;

    case INT_SYS_YIELD:
        schedule();
        break;                  /* will not be reached */

    case INT_SYS_PAGE_ALLOC: 
	{
        uintptr_t va = current->p_registers.reg_rdi; 
		uintptr_t pa;
		int r = 0;
		if (va % PAGESIZE != 0) {
			r = -1;
		}
		else if (va >= MEMSIZE_VIRTUAL + PAGESIZE) {
			r = -1;
		}
		else if (virtual_memory_lookup(current->p_pagetable, va).pn != -1) {
			r = -1;
		}
		else if (next_free_page(&pa) || assign_physical_page(pa, current->p_pid)) {
			console_printf(CPOS(23, 0), 0x0400, "Out of physical memory!\n");	
			r = -1;
		}
		else if (virtual_memory_map(current->p_pagetable, va, pa, PAGESIZE, PTE_P | PTE_W | PTE_U)) {
			r = -1;
		}

        current->p_registers.reg_rax = r;
        break;
    }

    case INT_SYS_MAPPING:
    {
	    syscall_mapping(current);
            break;
    }

    case INT_SYS_MEM_TOG:
	{
	    syscall_mem_tog(current);
	    break;
	}

    case INT_TIMER:
        ++ticks;
        schedule();
        break;                  /* will not be reached */

    case INT_PAGEFAULT: {
        // Analyze faulting address and access type.
        uintptr_t addr = rcr2();
        const char* operation = reg->reg_err & PFERR_WRITE
                ? "write" : "read";
        const char* problem = reg->reg_err & PFERR_PRESENT
                ? "protection problem" : "missing page";

        if (!(reg->reg_err & PFERR_USER)) {
            panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
                  addr, operation, problem, reg->reg_rip);
        }
        console_printf(CPOS(24, 0), 0x0C00,
                       "Process %d page fault for %p (%s %s, rip=%p)!\n",
                       current->p_pid, addr, operation, problem, reg->reg_rip);
        current->p_state = P_BROKEN;
        break;
    }

	case INT_SYS_FORK:
		// find free pid
		pid_t child_pid;
		if ((child_pid = next_free_pid()) == -1) {
			console_printf(CPOS(23, 0), 0x0400, "Max processes (%d) reached!\n", NPROC);	
			current->p_registers.reg_rax = -1;
			break;
		}

		proc *child_proc = &processes[child_pid];

		// copy the state of parent into child
		*child_proc = processes[current->p_pid];
		child_proc->p_pid = child_pid;

		
		// setup and copy the pagetable
		if (pagetable_setup(child_proc->p_pid)) {
			memset(child_proc, 0, sizeof(*child_proc));
			current->p_registers.reg_rax = -1;
			break;
		}
		else if (copy_pagetable(child_proc, current)) {
			free_pages_va(child_proc);		    // goes through all va and frees corresponding physical page
			free_pagetable_pages(child_proc);	    // goes through all pa and frees ones that belong to child_proc

			memset(child_proc, 0, sizeof(*child_proc));
			current->p_registers.reg_rax = -1;
			break;
		}


		// successful fork! set return registers
                console_printf(CPOS(24, 0), 0, "\n");

		child_proc->p_registers.reg_rax = 0;
		current->p_registers.reg_rax = child_pid;
		break;

	case INT_SYS_EXIT:
		free_pages_va(current);			// goes through all va and frees corresponding physical page
		free_pagetable_pages(current);	// goes through all pa and frees ones that belong to child_proc
		memset(&processes[current->p_pid], 0, sizeof(*current));
		break;

    default:
        default_exception(current);
        break;                  /* will not be reached */

    }


    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
        run(current);
    } else {
        schedule();
    }
}


// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
    pid_t pid = current->p_pid;
    while (1) {
        pid = (pid + 1) % NPROC;
        if (processes[pid].p_state == P_RUNNABLE) {
            run(&processes[pid]);
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
    }
}


// run(p)
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
    assert(p->p_state == P_RUNNABLE);
    current = p;

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);

 spinloop: goto spinloop;       // should never get here
}


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
        int owner;
        if (physical_memory_isreserved(addr)) {
            owner = PO_RESERVED;
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
            owner = PO_KERNEL;
        } else {
            owner = PO_FREE;
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
    }
}


// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
        if (vam.pa != va) {
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
        }
        assert(vam.pa == va);
        if (va >= (uintptr_t) start_data) {
            assert(vam.perm & PTE_W);
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
    vamapping vam = virtual_memory_lookup(pt, kstack);
    assert(vam.pa == kstack);
    assert(vam.perm & PTE_W);
}


// check_page_table_ownership
//    Check operating system invariants about ownership and reference
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
    // calculate expected reference count for page tables
    int owner = pid;
    int expected_refcount = 1;
    if (pt == kernel_pagetable) {
        owner = PO_KERNEL;
        for (int xpid = 0; xpid < NPROC; ++xpid) {
            if (processes[xpid].p_state != P_FREE
                && processes[xpid].p_pagetable == kernel_pagetable) {
                ++expected_refcount;
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
}

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
    assert(PAGENUMBER(pt) < NPAGES);
    if (pageinfo[PAGENUMBER(pt)].owner != owner) {
	panic("pt addr: %p, supposed owner of pt: %d, actual owner of pt: %d, refcount: %d", pt, owner, pageinfo[PAGENUMBER(pt)].owner,
			refcount);
    }
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
    if (level < 3) {
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
            if (pt->entry[index]) {
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
            }
        }
    }
}


// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);

    // The kernel page table should be owned by the kernel;
    // its reference count should equal 1, plus the number of processes
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
    check_page_table_ownership(kernel_pagetable, -1);

    for (int pid = 0; pid < NPROC; ++pid) {
        if (processes[pid].p_state != P_FREE
            && processes[pid].p_pagetable != kernel_pagetable) {
            check_page_table_mappings(processes[pid].p_pagetable);
            check_page_table_ownership(processes[pid].p_pagetable, pid);
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
        }
    }
}

// memshow_physical
//    Draw a picture of physical memory on the CGA console.

static const uint16_t memstate_colors[] = {
    'K' | 0x0D00, 'R' | 0x0700, '.' | 0x0700, '1' | 0x0C00,
    '2' | 0x0A00, '3' | 0x0900, '4' | 0x0E00, '5' | 0x0F00,
    '6' | 0x0C00, '7' | 0x0A00, '8' | 0x0900, '9' | 0x0E00,
    'A' | 0x0F00, 'B' | 0x0C00, 'C' | 0x0A00, 'D' | 0x0900,
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
        if (pn % 64 == 0) {
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
        }

        int owner = pageinfo[pn].owner;
        if (pageinfo[pn].refcount == 0) {
            owner = PO_FREE;
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
    }
}


// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pagetable, va);
        uint16_t color;
        if (vam.pn < 0) {
            color = ' ';
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
            int owner = pageinfo[vam.pn].owner;
            if (pageinfo[vam.pn].refcount == 0) {
                owner = PO_FREE;
            }
            color = memstate_colors[owner - PO_KERNEL];
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
                    | (color & 0x00FF);
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
                if(! (vam.perm & PTE_U))
                    color = color | 0x0F00;

#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
        if (pn % 64 == 0) {
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
    }
}


// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
        last_ticks = ticks;
        ++showing;
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
        ++showing;
    }
    showing = showing % NPROC;

    if (processes[showing].p_state != P_FREE) {
        char s[4];
        snprintf(s, 4, "%d ", showing);
        memshow_virtual(processes[showing].p_pagetable, s);
    }
}
