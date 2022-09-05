#include "proj1.h"

#define MACRO (0)
#define PLAINTEXT (1)



// this is creating a processing queue for the input
struct ll {
	char *text;
	int plaintext;
	struct ll *prev;
	struct ll *next;
};

struct queue {
	struct ll *head;
	struct ll *tail;
};

// ask about typedef vs define here
typedef struct queue *Queue;

void
enq(Queue q, struct ll *x) {
	q->tail->next = x;
	q->tail = x;
}

void
deq(Queue q) {
	struct ll *temp = q->tail;
	q->tail = temp->prev;
	free(temp);
}




// for now we pretend all input comes from stdin
Queue
input_to_queue(void) {
	}
