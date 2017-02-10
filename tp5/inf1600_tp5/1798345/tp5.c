/**
 * INF1600  TP5 Assembleur en ligne et mémoire
 * auteur: Adam Martin-Cote (1798345)
 * débuté: 21 novembre 2016
 * remis: 27 novembre 2016
 */

#include <stdio.h>

unsigned int Decryption_fct(unsigned int crypted,unsigned int key)
{
	unsigned int decrypted;

	/*
	 * Remplacez le code suivant par de l'assembleur en ligne
	 * en utilisant le moins d'instructions possible

	permutation de décryptage; 4 bit = 1 nibble
	crypted[nib1,nib2,nib3,nib4,nib5,nib6,nib7,nib8] -->
	--> decrypted[nib5,nib4,nib8,nib1,nib6,nib2,nib3,nib7]


	decrypted = ((crypted & 0xf0000000) >> 12 |
		     (crypted & 0xf000000)  >> 16 |
		     (crypted & 0xf00000)   >> 16 |
		     (crypted & 0xf0000)    << 8  |
		     (crypted & 0xf000)     << 16 |
		     (crypted & 0xf00)      << 4  |
		     (crypted & 0xf0)       >> 4  |
		     (crypted & 0xf)        << 20 )  |
		     key;
	*/

	asm volatile (

		// decrypted = ((crypted & 0xf0000000) >> 12 |
		"movl	%1,%%eax;"				// eax <- crypted
		"andl	$0xf0000000, %%eax;"	// & 0xf0000000
		"shrl	$12,%%eax;"				// >> 12
		"movl	%%eax, %0;"				// decrypted <- eax

		// (crypted & 0xf000000)  >> 16 |
		"movl	%1,%%eax;"				// eax <- crypted
		"andl	$0xf000000, %%eax;"		// &
		"shrl	$16,%%eax;"				// << 16
		"orl	%%eax, %0;"				// decrypted <-

		// (crypted & 0xf00000) >> 16 |
		"movl	%1,%%eax;"				// eax <- crypted
		"andl	$0xf00000, %%eax;"		// &
		"shrl	$16,%%eax;"				// << 16
		"orl	%%eax, %0;"				// decrypted <-

		// (crypted & 0xf0000) << 8  |
		"movl	%1,%%eax;"				// eax <- crypted
		"andl	$0xf0000, %%eax;"		// &
		"shl	$8,%%eax;"				// << 8
		"orl	%%eax, %0;"				// decrypted <-

		// (crypted & 0xf000) << 16 |
		"movl	%1,%%eax;"				// eax <- crypted
		"andl	$0xf000, %%eax;"		// &
		"shl	$16,%%eax;"				// 16
		"orl	%%eax, %0;"				// decrypted <-

		// (crypted & 0xf00) << 4  |
		"movl	%1,%%eax;"				// eax <- crypted
		"andl	$0xf00, %%eax;"			// &
		"shl	$4,%%eax;"				// << 4
		"orl	%%eax, %0;"				// decrypted <-
		// (crypted & 0xf0) >> 4  |
		"movl	%1,%%eax;"				// eax <- crypted
		"andl	$0xf0, %%eax;"			// &
		"shr	$4,%%eax;"				// >> 4
		"orl	%%eax, %0;"				// decrypted <-

		// (crypted & 0xf) << 20 )
		"movl	%1,%%eax;"				// eax <- crypted
		"andl	$0xf, %%eax;"			// &
		"shl	$20,%%eax;"				// << 20
		"orl	%%eax, %0;"				// decrypted <-

		// | key;
		"movl	%2, %%eax;"				// eax <- key
		"orl	%%eax, %0;"				// decrypted | key

		: "=b"(decrypted)				// output (in e%bx)
		: "c"(crypted), "d"(key)		// input$ (crypted in ecx, key in edx)
		: "eax"							// cloberred registers
	);

	return decrypted;
}

int main()
{
	unsigned int data = 0x12345678;
	unsigned int key =0x0c0180c;

	printf("Représentation cryptée  :   %08x\n"
	       "Représentation decryptée:   %08x\n",
	       data,
	       Decryption_fct(data,key));

	printf("\nRéponse en c= 54c17a3f\n");

	return 0;
}
