/**
 * INF1600 - TP4
 * Programmation en assembleur et c++
 * total_distance.s
 * Auteur: Adam Martin-Côté
 * Débuté : 7 novembre 2016
 * Remis : 18 novembre 2016
 */

.globl _ZNK4CCar12TotalDistAsmEv

_ZNK4CCar12TotalDistAsmEv:
	push	%ebp      /* save old base pointer */
	mov		%esp,%ebp /* set ebp to current esp */

	mov		8(%ebp),%ecx
	fld		4(%ecx)		/* s0 */
	fld		32(%ecx)	/* st_asm */
	fsubp

	leave          		/* restore ebp and esp */
	ret            		/* return to the caller */
