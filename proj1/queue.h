// this is creating a processing queue for the input
struct elt {
	int *text;
	int plaintext;
	struct elt *prev;
	struct elt *next;
};

struct queue {
	struct elt *head;
	struct elt *tail;
};

// ask about typedef vs define here
typedef struct queue *Queue;

struct elt *
elt_create(int *t, int pt) {
	// https://stackoverflow.com/questions/14768230/malloc-for-struct-and-pointer-in-c for reason
	struct elt *e = malloc(sizeof(*e));
	e->text = t;
	e->plaintext = pt;
	e->prev = NULL;
	e->next = NULL;
	return e;
}

void
enq(Queue q, struct elt *x) {
	q->tail->next = x;
	x->prev = q->tail;
	q->tail = x;
}

struct elt *
deq(Queue q) {
	struct elt* out = q->head;
	q->head = q->head->next;
	q->head->next->prev = NULL;
	return out;
}

Queue
q_create(void){
	Queue q = malloc(sizeof(struct queue));
	q->head = NULL;
	q->tail = NULL;

    return q;
}

void
destroy(Queue q) {
	while(q->head != NULL) {
		struct elt *temp = q->head->next;
		free(q->head);
		q->head = temp;
	}
	free(q);
}
