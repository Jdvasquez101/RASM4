// Programmer: Cynthia Martinez
//
// Subroutine delete_string: Provided a head pointer to a linked list and an index,
//      delete_string will delete an entire string and de-allocate memory (including the
//      node) by traversing through the linked list until it reaches the given index.
// X0: Must point to headPtr
// X1: Must contain an int value representing the index
// LR: Must contain the return address
// All AAPCS required registers are preserved,  r19-r29 and SP.

	.global	delete_string // Allows other files to call this function

	.text
delete_string:
	// The first eight registers, r0-r7, are used to pass argument values into a subroutine
	// and to return result values from a function
	
	// A subroutine invocation must preserve the contents of the registers r19-r29 and SP.
	// In all variants, registers r16, r17, r29 and r30 have special roles.
	// In these roles they are labeled IP0, IP1, FP and LR.
	
	// PRESERVE REGISTERS AS PER AAPCS
	STR   X19, [SP, #-16]!     // PUSH
	STR   X20, [SP, #-16]!     // PUSH
	STR   X21, [SP, #-16]!     // PUSH
	STR   X22, [SP, #-16]!     // PUSH
	STR   X23, [SP, #-16]!     // PUSH
	STR   X24, [SP, #-16]!     // PUSH
	STR   X25, [SP, #-16]!     // PUSH
	STR   X26, [SP, #-16]!     // PUSH
	STR   X27, [SP, #-16]!     // PUSH
	STR   X28, [SP, #-16]!     // PUSH
	STR   X29, [SP, #-16]!     // PUSH
        // END OF PRESERVING AAPCS REGISTERS

	STR   X30, [SP, #-16]!  // PUSH LR

	MOV X19, X0	       // copy headPtr from X0 to X19
	LDR X19, [X19]	       // load headPtr's address into X19
    
	MOV X20, X1            // copy given index from X1 to X20
	LDR X21, #0            // "initialize" X21 with 0 for traversal (int i = 0;)

	CMP X20, #0            // Compare given index with 0 (checking if it's the 1st index)
	BNE checkLast          // Jump to checkLast label if given index is not the 1st
// If (given index == first index) {
    // code for deleting head and pointing to new head
// }
checkLast:
	BL data_count          // Branch to data_count to check number of nodes
	SUB X1, X1, #1         // X1 (has num of nodes) - 1 == last index in linked list

	CMP X20, X1            // Compare given index with last index
	BNE traverse           // Jump to traverse label if given index is not the last index
// If (given index == last index) {
    // code for deleting tail and pointing to new tail
// }
traverse:
    	LDR X22, [X19, #8]     // X22 (temp) = next node
    	MOV X19, X22           // X19 = temp

    	ADD X21, X21, #1       // i++

    	CMP X19, #0	       // Compare X19 with 0 (which is ascii for null)
    	BNE traverse	       // Branch back to traverse label if not null
    	B   endTravrs          // Jump to endTravrs label

endTravrs:
	
	// POPPED IN REVERSE ORDER (LIFO)
	LDR   X30, [SP], #16       // POP
	LDR   X29, [SP], #16       // POP
	LDR   X28, [SP], #16       // POP
	LDR   X27, [SP], #16       // POP
	LDR   X26, [SP], #16       // POP
	LDR   X25, [SP], #16       // POP
	LDR   X24, [SP], #16       // POP
	LDR   X23, [SP], #16       // POP
	LDR   X22, [SP], #16       // POP
	LDR   X21, [SP], #16       // POP
	LDR   X20, [SP], #16       // POP
	LDR   X19, [SP], #16       // POP
	
	RET LR             // Return to calling function
	.end
