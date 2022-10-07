/*
   CONSTFOLDING.C : THIS FILE IMPLEMENTS THE CONSTANT FOLDING OPTIMIZATION
   */

#include "constfolding.h"
/*
 *************************************************************************************
 YOUR CODE IS TO BE FILLED IN THE GIVEN TODO BLANKS. YOU CAN CHOOSE TO USE ALL 
 UTILITY FUNCTIONS OR NONE. YOU CAN ADD NEW FUNCTIONS. BUT DO NOT FORGET TO 
 DECLARE THEM IN THE HEADER FILE.
 **************************************************************************************
 */                                                                                                          
bool madeChange;

/*
 ******************************************************************************************
 FUNCTION TO CALCULATE THE CONSTANT EXPRESSION VALUE 
 OBSERVE THAT THIS IMPLEMENTATION CONSIDERS ADDITIONAL OPTIMIZATIONS SUCH AS:
 1.  IDENTITY MULTIPLY = 1 * ANY_VALUE = ANY_VALUE - AVOID MULTIPLICATION CYCLE IN THIS CASE
 2.  ZERO MULTIPLY = 0 * ANY_VALUE = 0 - AVOID MULTIPLICATION CYCLE
 3.  DIVIDE BY ONE = ORIGINAL_VALUE - AVOID DIVISION CYCLE
 4.  SUBTRACT BY ZERO = ORIGINAL_VALUE - AVOID SUBTRACTION
 5.  MULTIPLICATION BY 2 = ADDITION BY SAME VALUE [STRENGTH REDUCTION]
 ******************************************************************************************
 */
long CalcExprValue(Node* node)
{
	long result;
	Node *leftNode, *rightNode;
	leftNode = node->left;
	rightNode = node->right; 
	switch(node->opCode){
		case MULTIPLY:
			if(leftNode->value == 1) {
				result = rightNode->value;
			} 
			else if(rightNode->value == 1) {
				result = leftNode->value;
			}
			else if(leftNode->value == 0 || rightNode->value == 0) {
				result = 0;
			}
			else if(leftNode->value == 2) {
				result = rightNode->value + rightNode->value;
			}              
			else if(rightNode->value == 2) {
				result = leftNode->value + leftNode->value;
			}
			else {
				result = leftNode->value * rightNode->value;
			}
			break;
		case DIVIDE:
			if(rightNode->value == 1) {
				result = leftNode->value;
			}
			else {
				result = leftNode->value / rightNode->value;
			}
			break;
		case ADD:
			result = leftNode->value + rightNode->value;
			break;
		case SUBTRACT:
			result = leftNode->value - rightNode->value;
			break;
		case NEGATE:
			result = -leftNode->value;
			break;
		default:
			break;
	}
	return result;
}


/*
 **********************************************************************************************************************************
// YOU CAN MAKE CHANGES/ADD AUXILLIARY FUNCTIONS BELOW THIS LINE
 **********************************************************************************************************************************
 */

/*
 *****************************************************************************************************
 THIS FUNCTION IS MEANT TO PROCESS THE CANDIDATE STATEMENTS AND PERFORM CONSTANT FOLDING 
 WHEREVER APPLICABLE.
 ******************************************************************************************************
 */
long ConstFoldPerStatement(Node* stmtNodeRight){
	/*
 	 *************************************************************************************
 	 TODO: YOUR CODE HERE

	 assume: expression with two numbers as input
	 **************************************************************************************
	 */                                                                                                         

	long result;
	Node *leftNode, *rightNode;
	leftNode = stmtNodeRight->left;
	rightNode = stmtNodeRight->right; 
	switch(stmtNodeRight->opCode){
		case MULTIPLY:
			result = leftNode->value * rightNode->value;
			break;
		case DIVIDE:
			result = leftNode->value / rightNode->value;
			break;
		case ADD:
			result = leftNode->value + rightNode->value;
			break;
		case SUBTRACT:
			result = leftNode->value - rightNode->value;
			break;
		case NEGATE:
			result = -leftNode->value;
			break;
		case BOR:
			result = leftNode->value | rightNode->value;
			break;
		case BAND:
			result = leftNode->value & rightNode->value;
			break;
		case BXOR:
			result = leftNode->value ^ rightNode->value;
			break;
		case BSHR:
			result = leftNode->value >> rightNode->value;
			break;
		case BSHL:
			result = leftNode->value << rightNode->value;
		default:
			break;
	}
	return result;
}


/*
 *****************************************************************************************************
 THIS FUNCTION IS MEANT TO IDENTIFY THE STATEMENTS THAT ARE ACTUAL CANDIDATES FOR CONSTANT FOLDING
 AND CALL THE APPROPRIATE FUNCTION FOR THE IDENTIFIED CANDIDATE'S CONSTANT FOLDING
 ******************************************************************************************************
 */
void ConstFoldPerFunction(Node* funcNode) {
	Node *stmtNodeRight;
	NodeList* statements = funcNode->statements;
	while(statements != NULL) {
		stmtNodeRight = statements->node->right;
		/*
 		 *************************************************************************************
 		 TODO: YOUR CODE HERE
 
 		 // assume: everything you check is defined, ie stmtNodeRight isn't null and expr aren't Null 
		 //
		 // check things about the statements:
		 //		if stmtNodeRight != NULL, do somthing		
		 //			check that it's operation and that both of its operands are constant

		 **************************************************************************************
		 */ 

		if (stmtNodeRight == NULL) {// not all statments have a right
			statements = statements->next;
			continue;
		} else if (stmtNodeRight->type != EXPRESSION) {
			statements = statements->next;
			continue;
		} else if (stmtNodeRight->opCode == O_NONE) { // check not const or var
			statements = statements->next;
			continue;
		} else if (stmtNodeRight->opCode == FUNCTIONCALL) { 
			statements = statements->next;
			continue;
		}

		// I'm now going to assume that stmtNodeRight is a correct expression a la 3+4 or -x or 8*r

		Node *exprLeft = stmtNodeRight->left;
		Node *exprRight = stmtNodeRight->right;

		if (exprLeft->exprCode != CONSTANT) {
			statements = statements->next;
			continue;
		} else if (stmtNodeRight->opCode != NEGATE && exprRight->exprCode != CONSTANT) { // change first part to func prob
			statements = statements->next;
			continue;
		}

		long result = ConstFoldPerStatement(stmtNodeRight);
		FreeExpression(stmtNodeRight);
		statements->node->right = CreateNumber(result);
		madeChange = true;

		statements = statements->next;
	}
}



/*
 **********************************************************************************************************************************
// YOU CAN MAKE CHANGES/ADD AUXILLIARY FUNCTIONS ABOVE THIS LINE
 ********************************************************************************************************************************
 */

/*
 *****************************************************************************************************
 THIS FUNCTION ENSURES THAT THE CONSTANT FOLDING OPTIMIZATION IS DONE FOR EVERY FUNCTION IN THE PROGRAM
 ******************************************************************************************************
 */

bool ConstantFolding(NodeList* list) {
	madeChange = false;
	while(list != NULL) {
	/*
	 *************************************************************************************
	 TODO: YOUR CODE HERE
	 i might be missing a check about function declarations
	 **************************************************************************************
	 */
		ConstFoldPerFunction(list->node);
		list = list->next;
	}
	return madeChange;
}

/*
 ****************************************************************************************************************************
 END OF CONSTANT FOLDING
 *****************************************************************************************************************************
 */ 
