/*
***********************************************************************
  CODEGEN.C : IMPLEMENT CODE GENERATION HERE
************************************************************************
*/
#include "codegen.h"

int argCounter;
int lastUsedOffset;
char lastOffsetUsed[100];
FILE *fptr;
regInfo *regList, *regHead, *regLast;
varStoreInfo *varList, *varHead, *varLast;

/*
*************************************************************************************
   YOUR CODE IS TO BE FILLED IN THE GIVEN TODO BLANKS. YOU CAN CHOOSE TO USE ALL
   UTILITY FUNCTIONS OR NONE. YOU CAN ADD NEW FUNCTIONS. BUT DO NOT FORGET TO
   DECLARE THEM IN THE HEADER FILE.
**************************************************************************************
*/

/*
***********************************************************************
  FUNCTION TO INITIALIZE THE ASSEMBLY FILE WITH FUNCTION DETAILS
************************************************************************
*/
void InitAsm(char* funcName) {
    fprintf(fptr, "\n.globl %s", funcName);
    fprintf(fptr, "\n%s:", funcName); 

    // Init stack and base ptr
    fprintf(fptr, "\npushq %%rbp");  
    fprintf(fptr, "\nmovq %%rsp, %%rbp"); 
}

/*
***************************************************************************
   FUNCTION TO WRITE THE RETURNING CODE OF A FUNCTION IN THE ASSEMBLY FILE
****************************************************************************
*/
void RetAsm() {
    fprintf(fptr,"\npopq  %%rbp");
    fprintf(fptr, "\nretq\n");
} 

/*
***************************************************************************
  FUNCTION TO CONVERT OFFSET FROM LONG TO CHAR STRING 
****************************************************************************
*/
void LongToCharOffset() {
     lastUsedOffset = lastUsedOffset - 8;
     snprintf(lastOffsetUsed, 100,"%d", lastUsedOffset);
     strcat(lastOffsetUsed,"(%rbp)");
}

// this function is not very helpful
/*
***************************************************************************
  FUNCTION TO CONVERT CONSTANT VALUE TO CHAR STRING
****************************************************************************
*/
void ProcessConstant(Node* opNode) {
     char value[10];
     LongToCharOffset();
     snprintf(value, 10,"%ld", opNode->value);
     char str[100];
     snprintf(str, 100,"%d", lastUsedOffset);
     strcat(str,"(%rbp)");
     AddVarInfo("", str, opNode->value, true);
     fprintf(fptr, "\nmovq  $%s, %s", value, str);
}

/*
***************************************************************************
  FUNCTION TO SAVE VALUE IN ACCUMULATOR (RAX)
****************************************************************************
*/
void SaveValInRax(char* name) {
    char *tempReg;
    tempReg = GetNextAvailReg(true);
    if(!(strcmp(tempReg, "NoReg"))) {
        LongToCharOffset();
        fprintf(fptr, "\n movq %%rax, %s", lastOffsetUsed);
        UpdateVarInfo(name, lastOffsetUsed, INVAL, false);
        UpdateRegInfo("%rax", 1);
    }
    else {
        fprintf(fptr, "\nmovq %%rax, %s", tempReg);
        UpdateRegInfo(tempReg, 0);
        UpdateVarInfo(name, tempReg, INVAL, false);
        UpdateRegInfo("%rax", 1);
    }
}

/*
***********************************************************************
  FUNCTION TO ADD VARIABLE INFORMATION TO THE VARIABLE INFO LIST
************************************************************************
*/
void AddVarInfo(char* varName, char* location, long val, bool isConst) {
   varStoreInfo* node = malloc(sizeof(varStoreInfo));
   node->varName = varName;
   node->value = val;
   strcpy(node->location,location);
   node->isConst = isConst;
   node->next = NULL;
   node->prev = varLast;
   if(varHead==NULL) {
       varHead = node;
       varLast = node;;
       varList = node;
   } else {
       //node->prev = varLast;
       varLast->next = node;
       varLast = varLast->next;
   }
   varList = varHead;
}

/*
***********************************************************************
  FUNCTION TO FREE THE VARIABLE INFORMATION LIST
************************************************************************
*/
void FreeVarList() {  
   varStoreInfo* tmp;
   while (varHead != NULL)
    {  
       tmp = varHead;
       varHead = varHead->next;
       free(tmp);
    }

}

/*
***********************************************************************
  FUNCTION TO LOOKUP VARIABLE INFORMATION FROM THE VARINFO LIST
************************************************************************
*/
char* LookUpVarInfo(char* name, long val) {
    varList = varLast;
    if(varList == NULL) printf("NULL varlist");
    while(varList!=NULL) {
        if(varList->isConst == true) {
            if(varList->value == val) return varList->location;
        }
        else {
            if(!strcmp(name,varList->varName)) return varList->location;
        }
        varList = varList->prev;
    }
    varList = varHead;
    return "";
}

/*
***********************************************************************
  FUNCTION TO UPDATE VARIABLE INFORMATION 
************************************************************************
*/
void UpdateVarInfo(char* varName, char* location, long val, bool isConst) {
  
   if(!(strcmp(LookUpVarInfo(varName, val), ""))) {
       AddVarInfo(varName, location, val, isConst);
   }
   else {
       varList = varHead;
       if(varList == NULL) printf("NULL varlist");
       while(varList!=NULL) {
           if(!strcmp(varList->varName,varName)) {
               varList->value = val;
               strcpy(varList->location,location);
               varList->isConst = isConst;
               break;
        }
        varList = varList->next;
       }
    }
    varList = varHead;
}

/*
***********************************************************************
  FUNCTION TO PRINT THE VARIABLE INFORMATION LIST
************************************************************************
*/
void PrintVarListInfo() {
    varList = varHead;
    if(varList == NULL) printf("NULL varlist");
    while(varList!=NULL) {
        if(!varList->isConst) {
            printf("\t %s : %s", varList->varName, varList->location);
        }
        else {
            printf("\t %ld : %s", varList->value, varList->location);
        }
        varList = varList->next;
    }
    varList = varHead;
}

/*
***********************************************************************
  FUNCTION TO ADD NEW REGISTER INFORMATION TO THE REGISTER INFO LIST
************************************************************************
*/
void AddRegInfo(char* name, int avail) {

   regInfo* node = malloc(sizeof(regInfo));
   node->regName = name;
   node->avail = avail;
   node->next = NULL; 

   if(regHead==NULL) {
       regHead = node;
       regList = node;
       regLast = node;
   } else {
       regLast->next = node;
       regLast = node;
   }
   regList = regHead;
}

/*
***********************************************************************
  FUNCTION TO FREE REGISTER INFORMATION LIST
************************************************************************
*/
void FreeRegList() {  
   regInfo* tmp;
   while (regHead != NULL)
    {  
       tmp = regHead;
       regHead = regHead->next;
       free(tmp);
    }

}

/*
***********************************************************************
  FUNCTION TO UPDATE THE AVAILIBILITY OF REGISTERS IN THE REG INFO LIST
************************************************************************
*/
void UpdateRegInfo(char* regName, int avail) {
    while(regList!=NULL) {
        if(regName == regList->regName) {
            regList->avail = avail;
        }
        regList = regList->next;
    }
    regList = regHead;
}

/*
***********************************************************************
  FUNCTION TO RETURN THE NEXT AVAILABLE REGISTER
************************************************************************
*/
char* GetNextAvailReg(bool noAcc) {
    regList = regHead;
    if(regList == NULL) printf("NULL reglist");
    while(regList!=NULL) {
        if(regList->avail == 1) {
            if(!noAcc) return regList->regName;
            // if not rax and dont return accumulator set to true, return the other reg
            // if rax and noAcc == true, skip to next avail
            if(noAcc && strcmp(regList->regName, "%rax")) { 
                return regList->regName;
            }
        }
        regList = regList->next;
    }
    regList = regHead;
    return "NoReg";
}

/*
***********************************************************************
  FUNCTION TO DETERMINE IF ANY REGISTER APART FROM OR INCLUDING 
  THE ACCUMULATOR(RAX) IS AVAILABLE
************************************************************************
*/
int IfAvailReg(bool noAcc) {
    regList = regHead;
    if(regList == NULL) printf("NULL reglist");
    while(regList!=NULL) {
        if(regList->avail == 1) {
            // registers available
            if(!noAcc) return 1;
            if(noAcc && strcmp(regList->regName, "%rax")) {
                return 1;
            }
        }
        regList = regList->next;
    }
    regList = regHead;
    return 0;
}

/*
***********************************************************************
  FUNCTION TO DETERMINE IF A SPECIFIC REGISTER IS AVAILABLE
************************************************************************
*/
bool IsAvailReg(char* name) {
    regList = regHead;
    if(regList == NULL) printf("NULL reglist");
    while(regList!=NULL) {
        if(!strcmp(regList->regName, name)) {
           if(regList->avail == 1) {
               return true;
           } 
        }
        regList = regList->next;
    }
    regList = regHead;
    return false;
}

/*
***********************************************************************
  FUNCTION TO PRINT THE REGISTER INFORMATION
************************************************************************
*/
void PrintRegListInfo() {
    regList = regHead;
    if(regList == NULL) printf("NULL reglist");
    while(regList!=NULL) {
        printf("\t %s : %d", regList->regName, regList->avail);
        regList = regList->next;
    }
    regList = regHead;
}



/*
***********************************************************************
  FUNCTION TO CREATE THE REGISTER LIST
************************************************************************
*/
void CreateRegList() {
    // Create the initial reglist which can be used to store variables.
    // 4 general purpose registers : AX, BX, CX, DX
    // 4 special purpose : SP, BP, SI , DI. 
    // Other registers: r8 -> r15
    // You need to decide which registers you will add in the register list 
    // use. Can you use all of the above registers?
    /*
     ****************************************
              TODO : YOUR CODE HERE
	 
	 I think we can actually use rbp but i'm
	 not sure so i'm just going to ignore it 
	 for now
     ***************************************
    */
	
	AddRegInfo("%rax", true);
	AddRegInfo("%rbx", true);
	AddRegInfo("%rcx", true);
	AddRegInfo("%rdx", true);
	AddRegInfo("%rsi", true);
	AddRegInfo("%rdi", true);
	AddRegInfo("%r8", true);
	AddRegInfo("%r9", true);
	AddRegInfo("%r10", true);
	AddRegInfo("%r11", true);
	AddRegInfo("%r12", true);
	AddRegInfo("%r13", true);
	AddRegInfo("%r14", true);
	AddRegInfo("%r15", true);

}

/*
***********************************************************************
  THIS FUNCTION IS MEANT TO PUT THE FUNCTION ARGUMENTS ON STACK
************************************************************************
*/
int PushArgOnStack(NodeList* arguments) {
    /*
     ****************************************
              TODO : YOUR CODE HERE
     ****************************************
    */
	char *argRegs[6] = {"%%rdi", "%%rsi", "%%rdx", "%%rcx", "%%r8", "%%r9"};

	argCounter = 0;
	int numArgs = -1;
    while(arguments!=NULL) {
    /*
     ***********************************************************************
              TODO : YOUR CODE HERE
      THINK ABOUT WHERE EACH ARGUMENT COMES FROM. EXAMPLE WHERE IS THE 
      FIRST ARGUMENT OF A FUNCTION STORED.

	  this is for when you want to call a function inside another function,
	  you first the values of these registers

	  talked to Alex Yuan, i'm just going to push all six register values to
	  the stack, they're filled in order: %rdi, %rsi, %rdx, %rcx, %r8, %r9

	  so you should push them in order: %r9, %r8, %rcx, %rdx, %rsi, %rdi
     ************************************************************************
     */
		numArgs++;
		argCounter++;
    }

	while (numArgs >= 0) {
		fprintf(fptr, "\npush %s", argRegs[numArgs]);
		numArgs--;
	}
	
    return argCounter;
}

/*
*************************************************************************
  THIS FUNCTION IS MEANT TO GET THE FUNCTION ARGUMENTS FROM THE  STACK
**************************************************************************
*/
void PopArgFromStack(NodeList* arguments) {
    /*
     ****************************************
              TODO : YOUR CODE HERE
     ****************************************
    */
    while(arguments!=NULL) {
    /*
     ***********************************************************************
              TODO : YOUR CODE HERE
      THINK ABOUT WHERE EACH ARGUMENT COMES FROM. EXAMPLE WHERE IS THE
      FIRST ARGUMENT OF A FUNCTION STORED AND WHERE SHOULD IT BE EXTRACTED
      FROM AND STORED TO.

	  where should they be stored too?
     ************************************************************************
     */
        arguments = arguments->next;
    }
}

/*
 ***********************************************************************
  THIS FUNCTION IS MEANT TO PROCESS EACH CODE STATEMENT AND GENERATE 
  ASSEMBLY FOR IT. 
  TIP: YOU CAN MODULARIZE BETTER AND ADD NEW SMALLER FUNCTIONS IF YOU 
  WANT THAT CAN BE CALLED FROM HERE.
 ************************************************************************
 */  
void ProcessStatements(NodeList* statements) {
    /*
     ****************************************
              TODO : YOUR CODE HERE
     ****************************************
    */    
    while(statements != NULL) {
    /*
     ****************************************
              TODO : YOUR CODE HERE
     ****************************************
    */          
        statements = statements->next;
    }
}

/*
 ***********************************************************************
  THIS FUNCTION IS MEANT TO DO CODEGEN FOR ALL THE FUNCTIONS IN THE FILE
 ************************************************************************
*/
void Codegen(NodeList* worklist) {
    fptr = fopen("assembly.s", "w+");
    /*
     ****************************************
              TODO : YOUR CODE HERE
     ****************************************
    */
    if(fptr == NULL) {
        printf("\n Could not create assembly file");
        return; 
    }
    while(worklist != NULL) {
      /*
       ****************************************
              TODO : YOUR CODE HERE

	   relevant questions: where are variables
	   stored? inside or outside of the func?
	   
	   variables are stored inside the function
	   
	   how much space must be added to the 
	   stack? (Activation Record)
	   
	   not how this works, you just track
	   stuff in rbp
	   
	   for now we're not going to consider 
	   using the registers, everything
	   will be accessed from the stack
	   
	   okay, so how do we figure out how to 
	   get stuff back? suppose have three 
	   variables, which we'll deal with later
       ****************************************
      */
		Node *funcDecl = worklist->node;
		lastUsedOffset = 0;
		CreateRegList();
		long maxOffset = 8*InitializeRegVarList(funcDecl);

		// initialize %rbp, so vars are stored relative to rbp 
		InitAsm(funcDecl->name);

		// push callee saved registers to stack (if necessary)
		// we exlucde rbp from callee saved bc we did that already in initAsm
		//
		// do you just always push these all?
		char *calleeSaved[5] = {"%rbx", "%r12", "%r13", "%r14", "%r15"};
		for (int i = 0; i<5; i++) {
			fprintf(fptr, "\npush %s", calleeSaved[i]);
			UpdateRegInfo(calleeSaved[i], true);

		}

		// decrement rsp
		fprintf(fptr, "\nsubq $%ld, %%rsp", maxOffset);

		// deal with assign statements
		NodeList *statements = funcDecl->statements;
		Node *stmtNode = statements->node;
		while (stmtNode->stmtCode != RETURN) {
			
			// note that everything is some kind of assign
			WriteAssign(stmtNode);

			statements = statements->next;
			stmtNode = statements->node;
		}

		// place return value in rax
		if (stmtNode->left->exprCode == CONSTANT) {
			fprintf(fptr, "\nmovq $%ld, %%rax", stmtNode->left->value);
		}
		else {
			char *src = LookUpVarInfo(stmtNode->left->name, INVAL);
			fprintf(fptr, "\nmovq %s, %%rax", src);
		}
		
		// restore rsp
		fprintf(fptr, "\naddq $%ld, %%rsp", maxOffset);

		// restore callee-saved values
		for (int i = 4; i >= 0; i--) {
			fprintf(fptr, "\npop %s", calleeSaved[i]);
		}

		fprintf(fptr, "\nmovq %%rbp, %%rsp");
		RetAsm(); 
		FreeRegList();
        worklist = worklist->next; 
    }
    fclose(fptr);
}

/*
**********************************************************************************************************************************
 YOU CAN MAKE ADD AUXILLIARY FUNCTIONS BELOW THIS LINE. DO NOT FORGET TO DECLARE THEM IN THE HEADER
**********************************************************************************************************************************
*/

/*
 * NOTE TO SELF: I will never use the isConst parameter in add / update var, which means
 * i will never use the val field in lookup
 */

long InitializeRegVarList(Node *funcNode) {
	// Set reg status to unavailable and add to varlist
	char *argRegs[6] = {"%rdi", "%rsi", "%rdx", "%rcx", "%r8", "%r9"};
	NodeList *arguments = funcNode->arguments;
	long numVars = 0;
	while (arguments != NULL) {
		AddVarInfo(arguments->node->name, argRegs[numVars], INVAL, false);	
		UpdateRegInfo(argRegs[numVars], false);
		numVars++;
		arguments = arguments->next;
	}

	NodeList *statements = funcNode->statements;
	while (statements != NULL) {
		if (statements->node->stmtCode == ASSIGN) {
			numVars++;
		}
		statements = statements->next;
	}

	return numVars;
}

void WriteFunctionCallAssign(Node *assignNode) {
	// save caller saved, 
	char *callerSaved[9] = {"%rax", "%rcx", "%rdx", "%rsi", "%rdi", "%r8", "%r9", "%r10", "%r11"};
	bool restoreReg[9] = {false, false, false, false, false, false, false, false, false};
	for (int i = 0; i < 9; i++) {
		if (!IsAvailReg(callerSaved[i])) {
			fprintf(fptr, "\npush %s", callerSaved[i]);
			UpdateRegInfo(callerSaved[i], true);
			restoreReg[i] = true;
		}
	}
	
	// load args in regs
	char *argRegs[6] = {"%rdi", "%rsi", "%rdx", "%rcx", "%r8", "%r9"};
	NodeList *arguments = assignNode->right->arguments;
	int i = 0;
	while (arguments != NULL) {
		if (arguments->node->exprCode == VARIABLE) {	
			char *src = LookUpVarInfo(arguments->node->name, INVAL);
			fprintf(fptr, "\nmovq %s, %s", src, argRegs[i]);
		}
		else if (arguments->node->exprCode == CONSTANT) {
			fprintf(fptr, "\nmovq $%ld, %s", arguments->node->value, argRegs[i]);
		}

		UpdateRegInfo(argRegs[i], false);
		i++;
		arguments = arguments->next;
	}

	// call to function
	fprintf(fptr, "\ncall %s", assignNode->right->left->name);

	// ensure caller-saved regs aren't available
	for (int i = 0; i < 9; i++) {
		UpdateRegInfo(callerSaved[i], false);
	}

	SaveValInRax(assignNode->name);

	// replace caller saved registers
	for (int i = 8; i >= 0; i--) {
		if (restoreReg[i]) {
			fprintf(fptr, "\npop %s", callerSaved[i]);
		}
	}
}

void NegateAssign(Node *exprLeft){
	char *src = LookUpVarInfo(exprLeft->name, INVAL);
	fprintf(fptr, "\nmovq %s, %%rax", src);
	fprintf(fptr, "\nnegq %%rax");
}

void CommBinaryOpAssign(Node *exprLeft, Node *exprRight, char *asmCmd) {
	if (exprLeft->exprCode == CONSTANT) {
		char *rsrc = LookUpVarInfo(exprRight->name, INVAL);
		fprintf(fptr, "\nmovq %s, %%rax", rsrc);
		fprintf(fptr, "\n%s $%ld, %%rax", asmCmd, exprLeft->value);
	}
	else if (exprRight->exprCode == CONSTANT) {
		char *lsrc = LookUpVarInfo(exprLeft->name, INVAL);
		fprintf(fptr, "\nmovq %s, %%rax", lsrc);
		fprintf(fptr, "\n%s $%ld, %%rax", asmCmd, exprRight->value);
	}
	else {
		char *lsrc = LookUpVarInfo(exprLeft->name, INVAL);
		char *rsrc = LookUpVarInfo(exprRight->name, INVAL);
		fprintf(fptr, "\nmovq %s, %%rax", lsrc);
		fprintf(fptr, "\n%s %s, %%rax", asmCmd, rsrc);
	}
}

void MultOpAssign(Node *exprLeft, Node *exprRight) {
	if (exprLeft->exprCode == CONSTANT) {
		char *rsrc = LookUpVarInfo(exprRight->name, INVAL);
		fprintf(fptr, "\nimulq $%ld, %s, %%rax", exprLeft->value, rsrc);
	}
	else if (exprRight->exprCode == CONSTANT) {
		char *lsrc = LookUpVarInfo(exprLeft->name, INVAL);
		fprintf(fptr, "\nimulq $%ld, %s, %%rax", exprRight->value, lsrc);
	}
	else {
		char *lsrc = LookUpVarInfo(exprLeft->name, INVAL);
		char *rsrc = LookUpVarInfo(exprRight->name, INVAL);
		fprintf(fptr, "\nmovq %s, %%rax", lsrc);
		fprintf(fptr, "\nimulq %s, %%rax", rsrc);
	}
}

void NonCommBinaryOpAssign(Node *exprLeft, Node *exprRight, char *asmCmd) {
	if (exprLeft->exprCode == CONSTANT) {
		char *rsrc = LookUpVarInfo(exprRight->name, INVAL);
		fprintf(fptr, "\nmovq $%ld, %%rax", exprLeft->value);
		fprintf(fptr, "\n%s %s, %%rax", asmCmd, rsrc);
	}
	else if (exprRight->exprCode == CONSTANT) {
		char *lsrc = LookUpVarInfo(exprLeft->name, INVAL);
		fprintf(fptr, "\nmovq %s, %%rax", lsrc);
		fprintf(fptr, "\n%s $%ld, %%rax", asmCmd, exprRight->value);
	}
	else {
		char *lsrc = LookUpVarInfo(exprLeft->name, INVAL);
		char *rsrc = LookUpVarInfo(exprRight->name, INVAL);
		fprintf(fptr, "\nmovq %s, %%rax", lsrc);
		fprintf(fptr, "\n%s %s, %%rax", asmCmd, rsrc);
	}
}

void DivOpAssign(Node *exprLeft, Node *exprRight) {
	bool pushRdx = !IsAvailReg("%rdx");
	if (pushRdx) {
		fprintf(fptr, "\npush %%rdx");
	}
	
	if (exprLeft->exprCode == CONSTANT) {
		char *rsrc = LookUpVarInfo(exprRight->name, INVAL);
		fprintf(fptr, "\nmovq $%ld, %%rax", exprLeft->value);
		fprintf(fptr, "\ncqto");
		if (!strcmp(rsrc, "%rdx")) {
			// if dividing by %rdx, we pushed val to stack
			// before it got clobbered by cqto
			fprintf(fptr, "\nidivq (%%rsp)");
		}
		else {
			// else we can just divide
			fprintf(fptr, "\nidivq %s", rsrc);
		}
	}
	else if (exprRight->exprCode == CONSTANT) {
		char *lsrc = LookUpVarInfo(exprLeft->name, INVAL);
		// idivq only takes reg or mem, so push divisor to mem
		fprintf(fptr, "\npush $%ld", exprRight->value);
		// move dividend to %rax	
		fprintf(fptr, "\nmovq %s, %%rax", lsrc);
		fprintf(fptr, "\ncqto");
		// divide using %rsp to access pushed divisor
		fprintf(fptr, "\nidivq (%%rsp)");
		fprintf(fptr, "\naddq $8, %%rsp");
	}
	else {
		char *lsrc = LookUpVarInfo(exprLeft->name, INVAL);
		char *rsrc = LookUpVarInfo(exprRight->name, INVAL);
		fprintf(fptr, "\nmovq %s, %%rax", lsrc);
		fprintf(fptr, "\ncqto");
		if (!strcmp(rsrc, "%rdx")) {
			fprintf(fptr, "\nidivq (%%rsp)");
		}
		else {
			fprintf(fptr, "\nidivq %s", rsrc);
		}
	}
	
	if (pushRdx) {
		fprintf(fptr, "\npop %%rdx");
	}
}

/*
 *  We always write the output of the expression into rax
 */
void WriteArithmeticAssign(Node *assignNode) {
	Node *stmtNodeRight = assignNode->right;
	Node *exprLeft = stmtNodeRight->left;
	Node *exprRight = stmtNodeRight->right;
	switch (stmtNodeRight->opCode) {
		case MULTIPLY:
			MultOpAssign(exprLeft, exprRight);
			break;
		
		case DIVIDE:
			DivOpAssign(exprLeft, exprRight);
			break;

		case ADD:
			CommBinaryOpAssign(exprLeft, exprRight, "addq");
			break;

		case SUBTRACT:
			NonCommBinaryOpAssign(exprLeft, exprRight, "subq");
			break;

		case NEGATE:
			NegateAssign(exprLeft);
			break;
		
		case BOR:
			CommBinaryOpAssign(exprLeft, exprRight, "orq");
			break;

		case BAND:
			CommBinaryOpAssign(exprLeft, exprRight, "andq");
			break;

		case BXOR:
			CommBinaryOpAssign(exprLeft, exprRight, "xorq");
			break;

		case BSHR:
			NonCommBinaryOpAssign(exprLeft, exprRight, "shrq");
			break;

		case BSHL:
			NonCommBinaryOpAssign(exprLeft, exprRight, "shlq");
			break;
	}
	SaveValInRax(assignNode->name);	
}

/*
 * assume that every input to writeAssign is an assign node
 */
void WriteAssign(Node *node) {
	// only these cases bc of const prop	
	if (node->right->exprCode == VARIABLE) {
		char *src = LookUpVarInfo(node->right->name, INVAL);
		fprintf(fptr, "\nmovq %s, %%rax", src);
		SaveValInRax(node->name);
	}
	else if (node->right->exprCode == OPERATION) {
		if (node->right->opCode == FUNCTIONCALL) {
			// assign var to func call
			WriteFunctionCallAssign(node);
		}
		else {
			// assign var to arithmetic operation
			WriteArithmeticAssign(node);
		}
	}
}

/*
**********************************************************************************************************************************
 YOU CAN MAKE ADD AUXILLIARY FUNCTIONS ABOVE THIS LINE. DO NOT FORGET TO DECLARE THEM IN THE HEADER
**********************************************************************************************************************************
*/


