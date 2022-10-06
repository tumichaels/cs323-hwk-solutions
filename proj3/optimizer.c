#include "optimizer.h"


void Optimizer(NodeList *funcdecls) {
	/*
	 *************************************
		TODO: YOUR CODE HERE
	 *************************************
	 */
	bool canChange = true;
	while(canChange){
		canChange = false;
		canChange = ConstantFolding(funcdecls) || canChange;
		canChange = ConstProp(funcdecls) || canChange;
		canChange = DeadAssign(funcdecls) || canChange;
	}
}
