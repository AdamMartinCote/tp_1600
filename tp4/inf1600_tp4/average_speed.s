/**
 * INF1600 - TP4
 * Programmation en assembleur et c++
 * average_speed.s
 * Auteur: Adam Martin-Côté
 * Débuté : 7 novembre 2016
 * Remis : 18 novembre 2016
 */

.data
	zero: .float 0.0

.globl _ZNK4CCar15AverageSpeedAsmEv

_ZNK4CCar15AverageSpeedAsmEv:
	push	%ebp      		/* save old base pointer */
	mov 	%esp,%ebp 		/* set ebp to current esp */

	mov		8(%ebp),%ecx	/* to get attributes as ofsets of ecx */
	fld		52(%ecx)		/* started */
	fld		zero
	fucomi
	je		return_v0

	push	8(%ebp)			/* push 'this' to stack */

	mov		0(%ecx),%edx	/* put vtable to edx */
	call	*36(%edx)		/* call vtable+8 */
	fld		52(%ecx)
	fdivrp					/* tots/started */

	jmp		end

return_v0:
	fld		8(%ecx)			/* return v0 */
end:
	leave
	ret
