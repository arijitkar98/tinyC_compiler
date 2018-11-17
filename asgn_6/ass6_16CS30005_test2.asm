	.file	"output.s"

.STR0:	.string "This Program implements insertion sort\n"
.STR1:	.string "Enter the size of an array: \n"
.STR2:	.string "Enter the elements of the array to be sorted: \n"
.STR3:	.string "The sorted array is: \n"
.STR4:	.string ", "
.STR5:	.string "\n"
	.text
	.globl	insertion_sort
	.type	insertion_sort, @function
insertion_sort:
.LFB0:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$168, %rsp
	movl	%edi, -4(%rbp)
	movq	%rsi, -12(%rbp)
# 0:res = t000 
	movl	$1, -28(%rbp)
# 1:res = i arg1 = t000 
	movl	-28(%rbp), %eax
	movl	%eax, -16(%rbp)
# 2:res = t001 arg1 = t000 
	movl	-28(%rbp), %eax
	movl	%eax, -32(%rbp)
# 3:arg1 = i arg2 = n 
.L3:
	movl	-16(%rbp), %eax
	movl	-4(%rbp), %edx
	cmpl	%edx, %eax
	jl .L1
# 4:
	jmp .L2
# 5:
	jmp .L2
# 6:res = t002 arg1 = i 
.L8:
	movl	-16(%rbp), %eax
	movl	%eax, -36(%rbp)
# 7:res = i arg1 = i 
	movl	-16(%rbp), %eax
	movl	$1, %edx
	addl	%edx, %eax
	movl	%eax, -16(%rbp)
# 8:
	jmp .L3
# 9:res = t003 
.L1:
	movl	$0, -40(%rbp)
# 10:res = t005 arg1 = i 
	movl	-16(%rbp), %eax
	movl	$4, %ecx
	imull	%ecx, %eax
	movl	%eax, -48(%rbp)
# 11:res = t004 arg1 = t003 arg2 = t005 
	movl	-40(%rbp), %eax
	movl	-48(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -44(%rbp)
# 12:res = t006 arg1 = arr arg2 = t004 
	movq	-12(%rbp), %rdx
	movslq	-44(%rbp), %rax
	addq	%rax, %rdx
	movl	(%rdx), %eax
	movl	%eax, -52(%rbp)
# 13:res = key arg1 = t006 
	movl	-52(%rbp), %eax
	movl	%eax, -20(%rbp)
# 14:res = t007 arg1 = t006 
	movl	-52(%rbp), %eax
	movl	%eax, -56(%rbp)
# 15:res = t008 
	movl	$1, -60(%rbp)
# 16:res = t009 arg1 = i arg2 = t008 
	movl	-16(%rbp), %eax
	movl	-60(%rbp), %edx
	subl	%edx, %eax
	movl	%eax, -64(%rbp)
# 17:res = j arg1 = t009 
	movl	-64(%rbp), %eax
	movl	%eax, -24(%rbp)
# 18:res = t010 arg1 = t009 
	movl	-64(%rbp), %eax
	movl	%eax, -68(%rbp)
# 19:res = t011 
.L7:
	movl	$0, -72(%rbp)
# 20:arg1 = j arg2 = t011 
	movl	-24(%rbp), %eax
	movl	-72(%rbp), %edx
	cmpl	%edx, %eax
	jge .L4
# 21:
	jmp .L5
# 22:res = t012 
.L4:
	movl	$0, -76(%rbp)
# 23:res = t014 arg1 = j 
	movl	-24(%rbp), %eax
	movl	$4, %ecx
	imull	%ecx, %eax
	movl	%eax, -84(%rbp)
# 24:res = t013 arg1 = t012 arg2 = t014 
	movl	-76(%rbp), %eax
	movl	-84(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -80(%rbp)
# 25:res = t015 arg1 = arr arg2 = t013 
	movq	-12(%rbp), %rdx
	movslq	-80(%rbp), %rax
	addq	%rax, %rdx
	movl	(%rdx), %eax
	movl	%eax, -88(%rbp)
# 26:arg1 = t015 arg2 = key 
	movl	-88(%rbp), %eax
	movl	-20(%rbp), %edx
	cmpl	%edx, %eax
	jg .L6
# 27:
	jmp .L5
# 28:
	jmp .L5
# 29:res = t016 
.L6:
	movl	$0, -92(%rbp)
# 30:res = t017 
	movl	$1, -96(%rbp)
# 31:res = t018 arg1 = j arg2 = t017 
	movl	-24(%rbp), %eax
	movl	-96(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -100(%rbp)
# 32:res = t020 arg1 = t018 
	movl	-100(%rbp), %eax
	movl	$4, %ecx
	imull	%ecx, %eax
	movl	%eax, -108(%rbp)
# 33:res = t019 arg1 = t016 arg2 = t020 
	movl	-92(%rbp), %eax
	movl	-108(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -104(%rbp)
# 34:res = t021 
	movl	$0, -112(%rbp)
# 35:res = t023 arg1 = j 
	movl	-24(%rbp), %eax
	movl	$4, %ecx
	imull	%ecx, %eax
	movl	%eax, -120(%rbp)
# 36:res = t022 arg1 = t021 arg2 = t023 
	movl	-112(%rbp), %eax
	movl	-120(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -116(%rbp)
# 37:res = t024 arg1 = arr arg2 = t022 
	movq	-12(%rbp), %rdx
	movslq	-116(%rbp), %rax
	addq	%rax, %rdx
	movl	(%rdx), %eax
	movl	%eax, -124(%rbp)
# 38:res = arr arg1 = t019 arg2 = t024 
	movq	-12(%rbp), %rdx
	movslq	-104(%rbp), %rax
	addq	%rax, %rdx
	movl	-124(%rbp), %eax
	movl	%eax, (%rdx)
# 39:res = t025 arg1 = t024 
	movl	-124(%rbp), %eax
	movl	%eax, -128(%rbp)
# 40:res = t026 
	movl	$1, -132(%rbp)
# 41:res = t027 arg1 = j arg2 = t026 
	movl	-24(%rbp), %eax
	movl	-132(%rbp), %edx
	subl	%edx, %eax
	movl	%eax, -136(%rbp)
# 42:res = j arg1 = t027 
	movl	-136(%rbp), %eax
	movl	%eax, -24(%rbp)
# 43:res = t028 arg1 = t027 
	movl	-136(%rbp), %eax
	movl	%eax, -140(%rbp)
# 44:
	jmp .L7
# 45:res = t029 
.L5:
	movl	$0, -144(%rbp)
# 46:res = t030 
	movl	$1, -148(%rbp)
# 47:res = t031 arg1 = j arg2 = t030 
	movl	-24(%rbp), %eax
	movl	-148(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -152(%rbp)
# 48:res = t033 arg1 = t031 
	movl	-152(%rbp), %eax
	movl	$4, %ecx
	imull	%ecx, %eax
	movl	%eax, -160(%rbp)
# 49:res = t032 arg1 = t029 arg2 = t033 
	movl	-144(%rbp), %eax
	movl	-160(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -156(%rbp)
# 50:res = arr arg1 = t032 arg2 = key 
	movq	-12(%rbp), %rdx
	movslq	-156(%rbp), %rax
	addq	%rax, %rdx
	movl	-20(%rbp), %eax
	movl	%eax, (%rdx)
# 51:res = t034 arg1 = key 
	movl	-20(%rbp), %eax
	movl	%eax, -164(%rbp)
# 52:
	jmp .L8
# 53:res = t035 
.L2:
	movl	$0, -168(%rbp)
# 54:res = t035 
	movl	-168(%rbp), %eax
	jmp	.LRT0
.LRT0:
	addq	$-168, %rsp
	movq	%rbp, %rsp
	popq	%rbp
	ret
.LFE0:
	.size	insertion_sort, .-insertion_sort
	.globl	main
	.type	main, @function
main:
.LFB1:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$568, %rsp
# 55:
	movq	$.STR0,	%rdi
# 56:res = t036 
	pushq %rbp
	call	printStr
	movl	%eax, -4(%rbp)
	addq $8 , %rsp
# 57:res = t037 
	movl	$100, -408(%rbp)
# 58:res = t038 
	movl	$1, -420(%rbp)
# 59:res = err arg1 = t038 
	movl	-420(%rbp), %eax
	movl	%eax, -416(%rbp)
# 60:
	movq	$.STR1,	%rdi
# 61:res = t039 
	pushq %rbp
	call	printStr
	movl	%eax, -424(%rbp)
	addq $8 , %rsp
# 62:res = t040 arg1 = err 
	leaq	-416(%rbp), %rax
	movq	%rax, -432(%rbp)
# 63:res = t040 
# 64:res = t041 
	pushq %rbp
	movq	-432(%rbp), %rdi
	call	readInt
	movl	%eax, -436(%rbp)
	addq $0 , %rsp
# 65:res = n arg1 = t041 
	movl	-436(%rbp), %eax
	movl	%eax, -412(%rbp)
# 66:res = t042 arg1 = t041 
	movl	-436(%rbp), %eax
	movl	%eax, -440(%rbp)
# 67:
	movq	$.STR2,	%rdi
# 68:res = t043 
	pushq %rbp
	call	printStr
	movl	%eax, -444(%rbp)
	addq $8 , %rsp
# 69:res = t044 
	movl	$0, -448(%rbp)
# 70:res = i arg1 = t044 
	movl	-448(%rbp), %eax
	movl	%eax, -444(%rbp)
# 71:res = t045 arg1 = t044 
	movl	-448(%rbp), %eax
	movl	%eax, -452(%rbp)
# 72:arg1 = i arg2 = n 
.L11:
	movl	-444(%rbp), %eax
	movl	-412(%rbp), %edx
	cmpl	%edx, %eax
	jl .L9
# 73:
	jmp .L10
# 74:
	jmp .L10
# 75:res = t046 arg1 = i 
.L12:
	movl	-444(%rbp), %eax
	movl	%eax, -452(%rbp)
# 76:res = i arg1 = i 
	movl	-444(%rbp), %eax
	movl	$1, %edx
	addl	%edx, %eax
	movl	%eax, -444(%rbp)
# 77:
	jmp .L11
# 78:res = t047 
.L9:
	movl	$0, -456(%rbp)
# 79:res = t049 arg1 = i 
	movl	-444(%rbp), %eax
	movl	$4, %ecx
	imull	%ecx, %eax
	movl	%eax, -464(%rbp)
# 80:res = t048 arg1 = t047 arg2 = t049 
	movl	-456(%rbp), %eax
	movl	-464(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -460(%rbp)
# 81:res = t050 arg1 = err 
	leaq	-416(%rbp), %rax
	movq	%rax, -472(%rbp)
# 82:res = t050 
# 83:res = t051 
	pushq %rbp
	movq	-472(%rbp), %rdi
	call	readInt
	movl	%eax, -476(%rbp)
	addq $0 , %rsp
# 84:res = arr arg1 = t048 arg2 = t051 
	leaq	-404(%rbp), %rdx
	movslq	-460(%rbp), %rax
	addq	%rax, %rdx
	movl	-476(%rbp), %eax
	movl	%eax, (%rdx)
# 85:res = t052 arg1 = t051 
	movl	-476(%rbp), %eax
	movl	%eax, -480(%rbp)
# 86:
	jmp .L12
# 87:res = t053 
.L10:
	movl	$0, -484(%rbp)
# 88:res = arr 
# 89:res = n 
# 90:res = t054 
	pushq %rbp
	movl	-412(%rbp) , %edi
	leaq	-404(%rbp), %rsi
	call	insertion_sort
	movl	%eax, -488(%rbp)
	addq $0 , %rsp
# 91:
	movq	$.STR3,	%rdi
# 92:res = t055 
	pushq %rbp
	call	printStr
	movl	%eax, -492(%rbp)
	addq $8 , %rsp
# 93:res = t056 
	movl	$0, -496(%rbp)
# 94:res = i arg1 = t056 
	movl	-496(%rbp), %eax
	movl	%eax, -444(%rbp)
# 95:res = t057 arg1 = t056 
	movl	-496(%rbp), %eax
	movl	%eax, -500(%rbp)
# 96:res = t058 
.L15:
	movl	$1, -504(%rbp)
# 97:res = t059 arg1 = n arg2 = t058 
	movl	-412(%rbp), %eax
	movl	-504(%rbp), %edx
	subl	%edx, %eax
	movl	%eax, -508(%rbp)
# 98:arg1 = i arg2 = t059 
	movl	-444(%rbp), %eax
	movl	-508(%rbp), %edx
	cmpl	%edx, %eax
	jl .L13
# 99:
	jmp .L14
# 100:
	jmp .L14
# 101:res = t060 arg1 = i 
.L16:
	movl	-444(%rbp), %eax
	movl	%eax, -508(%rbp)
# 102:res = i arg1 = i 
	movl	-444(%rbp), %eax
	movl	$1, %edx
	addl	%edx, %eax
	movl	%eax, -444(%rbp)
# 103:
	jmp .L15
# 104:res = t061 
.L13:
	movl	$0, -512(%rbp)
# 105:res = t063 arg1 = i 
	movl	-444(%rbp), %eax
	movl	$4, %ecx
	imull	%ecx, %eax
	movl	%eax, -520(%rbp)
# 106:res = t062 arg1 = t061 arg2 = t063 
	movl	-512(%rbp), %eax
	movl	-520(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -516(%rbp)
# 107:res = t064 arg1 = arr arg2 = t062 
	leaq	-404(%rbp), %rdx
	movslq	-516(%rbp), %rax
	addq	%rax, %rdx
	movl	(%rdx), %eax
	movl	%eax, -524(%rbp)
# 108:res = t064 
# 109:res = t065 
	pushq %rbp
	movl	-524(%rbp) , %edi
	call	printInt
	movl	%eax, -528(%rbp)
	addq $0 , %rsp
# 110:
	movq	$.STR4,	%rdi
# 111:res = t066 
	pushq %rbp
	call	printStr
	movl	%eax, -532(%rbp)
	addq $8 , %rsp
# 112:
	jmp .L16
# 113:res = t067 
.L14:
	movl	$0, -536(%rbp)
# 114:res = t068 
	movl	$1, -540(%rbp)
# 115:res = t069 arg1 = n arg2 = t068 
	movl	-412(%rbp), %eax
	movl	-540(%rbp), %edx
	subl	%edx, %eax
	movl	%eax, -544(%rbp)
# 116:res = t071 arg1 = t069 
	movl	-544(%rbp), %eax
	movl	$4, %ecx
	imull	%ecx, %eax
	movl	%eax, -552(%rbp)
# 117:res = t070 arg1 = t067 arg2 = t071 
	movl	-536(%rbp), %eax
	movl	-552(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -548(%rbp)
# 118:res = t072 arg1 = arr arg2 = t070 
	leaq	-404(%rbp), %rdx
	movslq	-548(%rbp), %rax
	addq	%rax, %rdx
	movl	(%rdx), %eax
	movl	%eax, -556(%rbp)
# 119:res = t072 
# 120:res = t073 
	pushq %rbp
	movl	-556(%rbp) , %edi
	call	printInt
	movl	%eax, -560(%rbp)
	addq $0 , %rsp
# 121:
	movq	$.STR5,	%rdi
# 122:res = t074 
	pushq %rbp
	call	printStr
	movl	%eax, -564(%rbp)
	addq $8 , %rsp
# 123:res = t075 
	movl	$0, -568(%rbp)
# 124:res = t075 
	movl	-568(%rbp), %eax
	jmp	.LRT1
.LRT1:
	addq	$-568, %rsp
	movq	%rbp, %rsp
	popq	%rbp
	ret
.LFE1:
	.size	main, .-main
