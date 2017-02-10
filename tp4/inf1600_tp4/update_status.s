/**
 * INF1600 - TP4
 * Programmation en assembleur et c++
 * update_status.s
 * Auteur: Adam Martin-Côté
 * Débuté : 7 novembre 2016
 * Remis : 18 novembre 2016
 */

.data
        factor: .float 0.5 /* use this to multiply by 0.5 */

.text

.globl _ZN4CCar15UpdateStatusAsmEv

_ZN4CCar15UpdateStatusAsmEv:
    push    %ebp      		/* save old base pointer */
    mov     %esp, %ebp 		/* set ebp to current esp */

    mov 	8(%ebp),%eax	/* put address of 'this' in eax */

	/* st_c = st_c + (vt_c*interv) + (0.5f*at_c*interv*interv); */
	fld		32(%eax)		/* st_asm */

    fld		36(%eax) 		/* vt_asm */
    fld 	48(%eax)		/* interv */
    fmulp

	fld		factor
	fld		40(%eax)		/* at_asm */
	fld 	48(%eax)     	/* interv */
	fld 	48(%eax)		/* interv */
    fmulp
	fmulp
	fmulp

	faddp 						/* add all 3 terms */
	faddp

	fstp	32(%eax)			/* push calculated value to st_asm */

	/* vt_c = vt_c + at_c*interv;*/
	fld		36(%eax)			/* vt_asm */

	fld		40(%eax)			/* at_asm */
	fld		48(%eax)			/* interv */
	fmulp

	faddp

	fstp	36(%eax) 			/* push result to vt_asm */

    leave          /* restore ebp and esp */
    ret            /* return to the caller */
