	.file	"output.s"

.STR0:	.string "This Program handles global variables\n"
.STR1:	.string "i = "
.STR2:	.string "\n"
.STR3:	.string "i = "
.STR4:	.string "\n"
	.globl	dog
	.data
	.align 4
	.type	dog, @object
	.size	dog ,4
dog:
	.long 6
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$60, %rsp
# 2:
	movq	$.STR0,	%rdi
# 3:res = t001 
	pushq %rbp
	call	printStr
	movl	%eax, -4(%rbp)
	addq $8 , %rsp
# 4:res = t002 
	movl	$2, -12(%rbp)
# 5:res = t003 arg2 = t002 
	movl	dog(%rip), %eax
	movl	-12(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -16(%rbp)
# 6:res = i arg1 = t003 
	movl	-16(%rbp), %eax
	movl	%eax, -8(%rbp)
# 7:res = t004 arg1 = t003 
	movl	-16(%rbp), %eax
	movl	%eax, -20(%rbp)
# 8:
	movq	$.STR1,	%rdi
# 9:res = t005 
	pushq %rbp
	call	printStr
	movl	%eax, -24(%rbp)
	addq $8 , %rsp
# 10:res = i 
# 11:res = t006 
	pushq %rbp
	movl	-8(%rbp) , %edi
	call	printInt
	movl	%eax, -28(%rbp)
	addq $0 , %rsp
# 12:
	movq	$.STR2,	%rdi
# 13:res = t007 
	pushq %rbp
	call	printStr
	movl	%eax, -32(%rbp)
	addq $8 , %rsp
# 14:res = t008 
	movl	$5, -36(%rbp)
# 15:arg1 = t008 
	movl	%eax, dog(%rip)
# 16:res = t009 arg1 = t008 
	movl	-36(%rbp), %eax
	movl	%eax, -40(%rbp)
# 17:res = i 
	movl	dog(%rip), %eax
	movq	-36(%rbp), %rax
	movq	%rax, -8(%rbp)
# 18:res = t010 
	movl	dog(%rip), %eax
	movq	-36(%rbp), %rax
	movq	%rax, -44(%rbp)
# 19:
	movq	$.STR3,	%rdi
# 20:res = t011 
	pushq %rbp
	call	printStr
	movl	%eax, -48(%rbp)
	addq $8 , %rsp
# 21:res = i 
# 22:res = t012 
	pushq %rbp
	movl	-8(%rbp) , %edi
	call	printInt
	movl	%eax, -52(%rbp)
	addq $0 , %rsp
# 23:
	movq	$.STR4,	%rdi
# 24:res = t013 
	pushq %rbp
	call	printStr
	movl	%eax, -56(%rbp)
	addq $8 , %rsp
# 25:res = t014 
	movl	$0, -60(%rbp)
# 26:res = t014 
	movl	-60(%rbp), %eax
	jmp	.LRT0
.LRT0:
	addq	$-60, %rsp
	movq	%rbp, %rsp
	popq	%rbp
	ret
.LFE0:
	.size	main, .-main
