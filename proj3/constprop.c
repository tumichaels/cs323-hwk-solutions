/*
 ********************************************************************************
 CONSTPROP.C : IMPLEMENT THE DOWNSTREAM CONSTANT PROPOGATION OPTIMIZATION HERE
 *********************************************************************************
 */

#include "constprop.h"

refConst *lastNode, *headNode;
/*
 *************************************************************************************
 YOUR CODE IS TO BE FILLED IN THE GIVEN TODO BLANKS. YOU CAN CHOOSE TO USE ALL
 UTILITY FUNCTIONS OR NONE. YOU CAN ADD NEW FUNCTIONS. BUT DO NOT FORGET TO
 DECLARE THEM IN THE HEADER FILE.
 **************************************************************************************
 */

/*
 ***********************************************************************
 FUNCTION TO FREE THE CONSTANTS-ASSOCIATED VARIABLES LIST
 ************************************************************************
 */
void FreeConstList()
{
	refConst* tmp;
	while (headNode != NULL)
	{
		tmp = headNode;
		headNode = headNode->next;
		free(tmp);
	}

}

/*
 *************************************************************************
 FUNCTION TO ADD A CONSTANT VALUE AND THE ASSOCIATED VARIABLE TO THE LIST
 **************************************************************************
 */
void UpdateConstList(char* name, long val) {
	refConst* node = malloc(sizeof(refConst));
	if (node == NULL) return;
	node->name = name;
	node->val = val;
	node->next = NULL;
	if(headNode == NULL) {
		lastNode = node;
		headNode = node;
	}
	else {
		lastNode->next = node;
		lastNode = node;
	}
}

/*
 *****************************************************************************
 FUNCTION TO LOOKUP IF A CONSTANT ASSOCIATED VARIABLE IS ALREADY IN THE LIST
 ******************************************************************************
 */
refConst* LookupConstList(char* name) {
	refConst *node;
	node = headNode; 
	while(node!=NULL){
		if(!strcmp(name, node->name))
			return node;
		node = node->next;
	}
	return NULL;
}

/*
 **********************************************************************************************************************************
 YOU CAN MAKE CHANGES/ADD AUXILLIARY FUNCTIONS BELOW THIS LINE
 **********************************************************************************************************************************
 */


/*
 ************************************************************************************
 THIS FUNCTION IS MEANT TO UPDATE THE CONSTANT LIST WITH THE ASSOCIATED VARIABLE
 AND CONSTANT VALUE WHEN ONE IS SEEN. IT SHOULD ALSO PROPOGATE THE CONSTANTS WHEN 
 WHEN APPLICABLE. YOU CAN ADD A NEW FUNCTION IF YOU WISH TO MODULARIZE BETTER.
 *************************************************************************************
 */
void TrackConst(NodeList* statements) {
	Node* node;
	while(statements != NULL) {
		node = statements->node;
		/*
		 ****************************************
		 TODO : YOUR CODE HERE
		 
		 goes through the list of statments,
		 first tries to replace, then tries to add
		 to the const list

		 ****************************************
		 */

		// i'm assuming everything is of form long x = [expr]	
		// the one exception is a return


		// I don't need the case where node->stmtCode == FUNCTIONDECL
		if (node->stmtCode == RETURN) {
			Node *outNode = node->left;
			if (outNode->exprCode == VARIABLE) {
				refConst *ref = LookupConstList(outNode->name);
				if (ref != NULL) {
					FreeExpression(outNode);
					node->left = CreateNumber(ref->val);
					madeChange = true;
				}
			}
		} else if (node->stmtCode == ASSIGN){ //make it easier to read

			Node *rAssign = node->right;
			if (rAssign->opCode == FUNCTIONCALL) {
				funcCallProp(rAssign);
			} else if (rAssign->exprCode == OPERATION) {
				numOpProp(rAssign);
			} else if (rAssign->exprCode == VARIABLE) {
				refConst *ref = LookupConstList(node->name);
				if (ref != NULL) {
					FreeExpression(rAssign);
					node->right = CreateNumber(ref->val);
					madeChange = true;
				}
			}

			// update the list
			if (node->right->exprCode == CONSTANT && LookupConstList(node->name) == NULL) {
				UpdateConstList(node->name, node->right->value);	
			}
		}

		statements = statements->next;
	}
}

// this is a helper function that propagates to the arguments of a
// function call

void funcCallProp(Node *funcCall) {
	// assumes that the input is a function call
	Node *argNode;
	NodeList *arguments = funcCall->arguments;
	while (arguments != NULL) {
		argNode = arguments->node;
		if (argNode->exprCode == VARIABLE) {
			refConst *ref = LookupConstList(argNode->name);
			if (ref != NULL) {
				FreeExpression(argNode);
				arguments->node = CreateNumber(ref->val);
				madeChange = true;
			}
		}

		arguments = arguments->next;
	}

}

// this is for all operations that aren't function calls

void numOpProp(Node *expr){
	// assumes input is an operation

	// will always need to check left input
	Node *lInput = expr->left;
	if (lInput->exprCode == VARIABLE) {
		refConst *ref = LookupConstList(lInput->name);
		if (ref != NULL) {
			FreeExpression(lInput);
			expr->left = CreateNumber(ref->val);
			madeChange = true;
		}
	}

	if(expr->opCode == NEGATE) {
		return;
	}

	Node *rInput = expr->right;
	if (rInput->exprCode == VARIABLE) {
		refConst *ref = LookupConstList(rInput->name);
		if (ref != NULL) {
			FreeExpression(rInput);
			expr->right = CreateNumber(ref->val);
			madeChange = true;
		}
	}
}


bool ConstProp(NodeList* worklist) {
	while(worklist!=NULL){
		/*
		 ****************************************
		 TODO : 
		 
		 I'm assuming this is a list of functions 
		 ****************************************
		 */

		TrackConst(worklist->node->statements);	

		worklist = worklist->next;
		FreeConstList();
	}
	return madeChange;
}

/*
 **********************************************************************************************************************************
 YOU CAN MAKE CHANGES/ADD AUXILLIARY FUNCTIONS ABOVE THIS LINE
 **********************************************************************************************************************************
 */
