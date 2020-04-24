	.section	__TEXT,__text,regular,pure_instructions
	.build_version iossimulator, 13, 2	sdk_version 13, 2
	.p2align	4, 0x90         ## -- Begin function -[ViewController viewDidLoad]
"-[ViewController viewDidLoad]":        ## @"\01-[ViewController viewDidLoad]"
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rsi
	movq	%rsi, -32(%rbp)
	movq	L_OBJC_CLASSLIST_SUP_REFS_$_(%rip), %rsi
	movq	%rsi, -24(%rbp)
	movq	L_OBJC_SELECTOR_REFERENCES_(%rip), %rsi
	leaq	-32(%rbp), %rdi
	callq	_objc_msgSendSuper2
	leaq	L__unnamed_cfstring_(%rip), %rsi
	movq	%rsi, %rdi
	leaq	"L___FUNCTION__.-[ViewController viewDidLoad]"(%rip), %rsi
	movb	$0, %al
	callq	_NSLog
	movq	L_OBJC_CLASSLIST_REFERENCES_$_(%rip), %rsi
	movq	%rsi, %rdi
	callq	_objc_opt_class
	movq	%rax, %rdi
	callq	_objc_retainAutoreleasedReturnValue
	leaq	L__unnamed_cfstring_.2(%rip), %rsi
	movq	%rax, -40(%rbp)
	movq	%rsi, %rdi
	leaq	-40(%rbp), %rsi
	movb	$0, %al
	callq	_NSLog
	movq	L_OBJC_CLASSLIST_REFERENCES_$_(%rip), %rsi
	movq	%rsi, %rdi
	callq	_objc_opt_class
	movq	%rax, %rdi
	callq	_objc_retainAutoreleasedReturnValue
	leaq	L__unnamed_cfstring_.4(%rip), %rsi
	movq	%rax, -48(%rbp)
	movq	%rsi, %rdi
	leaq	-48(%rbp), %rsi
	movb	$0, %al
	callq	_NSLog
	leaq	L__unnamed_cfstring_.6(%rip), %rsi
	leaq	-40(%rbp), %rdi
	movq	%rdi, -56(%rbp)
	movq	%rsi, %rdi
	leaq	-56(%rbp), %rsi
	movb	$0, %al
	callq	_NSLog
	movq	-56(%rbp), %rdi
	movq	L_OBJC_SELECTOR_REFERENCES_.8(%rip), %rsi
	callq	*_objc_msgSend@GOTPCREL(%rip)
	xorl	%ecx, %ecx
	movl	%ecx, %esi
	leaq	-48(%rbp), %rdi
	callq	_objc_storeStrong
	xorl	%ecx, %ecx
	movl	%ecx, %esi
	leaq	-40(%rbp), %rdi
	callq	_objc_storeStrong
	addq	$64, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	_functionF              ## -- Begin function functionF
	.p2align	4, 0x90
_functionF:                             ## @functionF
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	$1, %edi
	callq	_functionG
	leaq	L__unnamed_cfstring_.10(%rip), %rcx
	leaq	_functionG(%rip), %rdx
	movl	%eax, -4(%rbp)
	movq	%rcx, %rdi
	movq	%rdx, %rsi
	movb	$0, %al
	callq	_NSLog
	leaq	L__unnamed_cfstring_.10(%rip), %rcx
	leaq	_functionF(%rip), %rdx
	movq	%rcx, %rdi
	movq	%rdx, %rsi
	movb	$0, %al
	callq	_NSLog
	movl	-4(%rbp), %r8d
	addl	$1, %r8d
	movl	%r8d, -4(%rbp)
	addq	$16, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	_functionG              ## -- Begin function functionG
	.p2align	4, 0x90
_functionG:                             ## @functionG
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	%edi, -4(%rbp)
	movl	-4(%rbp), %edi
	addl	$1, %edi
	movl	%edi, %eax
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function -[ViewController setupUI]
"-[ViewController setupUI]":            ## @"\01-[ViewController setupUI]"
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	L_OBJC_CLASSLIST_REFERENCES_$_.11(%rip), %rsi
	movq	L_OBJC_SELECTOR_REFERENCES_.13(%rip), %rdi
	movq	%rdi, -24(%rbp)         ## 8-byte Spill
	movq	%rsi, %rdi
	movq	-24(%rbp), %rsi         ## 8-byte Reload
	callq	*_objc_msgSend@GOTPCREL(%rip)
	movq	%rax, %rdi
	callq	_objc_retainAutoreleasedReturnValue
	movq	-8(%rbp), %rsi
	movq	L_OBJC_SELECTOR_REFERENCES_.15(%rip), %rdi
	movq	%rdi, -32(%rbp)         ## 8-byte Spill
	movq	%rsi, %rdi
	movq	-32(%rbp), %rsi         ## 8-byte Reload
	movq	%rax, -40(%rbp)         ## 8-byte Spill
	callq	*_objc_msgSend@GOTPCREL(%rip)
	movq	%rax, %rdi
	callq	_objc_retainAutoreleasedReturnValue
	movq	L_OBJC_SELECTOR_REFERENCES_.17(%rip), %rsi
	movq	%rax, %rdi
	movq	-40(%rbp), %rdx         ## 8-byte Reload
	movq	%rax, -48(%rbp)         ## 8-byte Spill
	callq	*_objc_msgSend@GOTPCREL(%rip)
	movq	-48(%rbp), %rax         ## 8-byte Reload
	movq	%rax, %rdi
	callq	*_objc_release@GOTPCREL(%rip)
	movq	-40(%rbp), %rax         ## 8-byte Reload
	movq	%rax, %rdi
	callq	*_objc_release@GOTPCREL(%rip)
	leaq	L__unnamed_cfstring_.19(%rip), %rax
	movq	%rax, %rdi
	leaq	"L___FUNCTION__.-[ViewController setupUI]"(%rip), %rsi
	movb	$0, %al
	callq	_NSLog
	addq	$48, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function -[ViewController viewWillAppear:]
"-[ViewController viewWillAppear:]":    ## @"\01-[ViewController viewWillAppear:]"
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$80, %rsp
	movb	%dl, %al
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	andb	$1, %al
	movb	%al, -17(%rbp)
	movq	-8(%rbp), %rsi
	movb	-17(%rbp), %al
	movq	%rsi, -40(%rbp)
	movq	L_OBJC_CLASSLIST_SUP_REFS_$_(%rip), %rsi
	movq	%rsi, -32(%rbp)
	movq	L_OBJC_SELECTOR_REFERENCES_.21(%rip), %rsi
	andb	$1, %al
	leaq	-40(%rbp), %rdi
	movzbl	%al, %edx
	callq	_objc_msgSendSuper2
	leaq	L__unnamed_cfstring_(%rip), %rsi
	movq	%rsi, %rdi
	leaq	"L___FUNCTION__.-[ViewController viewWillAppear:]"(%rip), %rsi
	movb	$0, %al
	callq	_NSLog
	movq	L_OBJC_CLASSLIST_REFERENCES_$_.11(%rip), %rsi
	movq	L_OBJC_SELECTOR_REFERENCES_.23(%rip), %rdi
	movq	%rdi, -48(%rbp)         ## 8-byte Spill
	movq	%rsi, %rdi
	movq	-48(%rbp), %rsi         ## 8-byte Reload
	callq	*_objc_msgSend@GOTPCREL(%rip)
	movq	%rax, %rdi
	callq	_objc_retainAutoreleasedReturnValue
	movq	-8(%rbp), %rsi
	movq	L_OBJC_SELECTOR_REFERENCES_.15(%rip), %rdi
	movq	%rdi, -56(%rbp)         ## 8-byte Spill
	movq	%rsi, %rdi
	movq	-56(%rbp), %rsi         ## 8-byte Reload
	movq	%rax, -64(%rbp)         ## 8-byte Spill
	callq	*_objc_msgSend@GOTPCREL(%rip)
	movq	%rax, %rdi
	callq	_objc_retainAutoreleasedReturnValue
	movq	L_OBJC_SELECTOR_REFERENCES_.17(%rip), %rsi
	movq	%rax, %rdi
	movq	-64(%rbp), %rdx         ## 8-byte Reload
	movq	%rax, -72(%rbp)         ## 8-byte Spill
	callq	*_objc_msgSend@GOTPCREL(%rip)
	movq	-72(%rbp), %rax         ## 8-byte Reload
	movq	%rax, %rdi
	callq	*_objc_release@GOTPCREL(%rip)
	movq	-64(%rbp), %rax         ## 8-byte Reload
	movq	%rax, %rdi
	callq	*_objc_release@GOTPCREL(%rip)
	addq	$80, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function -[ViewController viewDidAppear:]
"-[ViewController viewDidAppear:]":     ## @"\01-[ViewController viewDidAppear:]"
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movb	%dl, %al
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	andb	$1, %al
	movb	%al, -17(%rbp)
	movq	-8(%rbp), %rsi
	movb	-17(%rbp), %al
	movq	%rsi, -40(%rbp)
	movq	L_OBJC_CLASSLIST_SUP_REFS_$_(%rip), %rsi
	movq	%rsi, -32(%rbp)
	movq	L_OBJC_SELECTOR_REFERENCES_.25(%rip), %rsi
	andb	$1, %al
	leaq	-40(%rbp), %rdi
	movzbl	%al, %edx
	callq	_objc_msgSendSuper2
	leaq	L__unnamed_cfstring_(%rip), %rsi
	movq	%rsi, %rdi
	leaq	"L___FUNCTION__.-[ViewController viewDidAppear:]"(%rip), %rsi
	movb	$0, %al
	callq	_NSLog
	callq	_functionF
	addq	$48, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function -[ViewController aTextFiled]
"-[ViewController aTextFiled]":         ## @"\01-[ViewController aTextFiled]"
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rsi
	movq	_OBJC_IVAR_$_ViewController._aTextFiled(%rip), %rdi
	addq	%rdi, %rsi
	movq	%rsi, %rdi
	callq	_objc_loadWeakRetained
	movq	%rax, %rdi
	addq	$16, %rsp
	popq	%rbp
	jmp	_objc_autoreleaseReturnValue ## TAILCALL
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function -[ViewController setATextFiled:]
"-[ViewController setATextFiled:]":     ## @"\01-[ViewController setATextFiled:]"
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-24(%rbp), %rdx
	movq	-8(%rbp), %rsi
	movq	_OBJC_IVAR_$_ViewController._aTextFiled(%rip), %rdi
	addq	%rdi, %rsi
	movq	%rsi, %rdi
	movq	%rdx, %rsi
	callq	_objc_storeWeak
	movq	%rax, -32(%rbp)         ## 8-byte Spill
	addq	$32, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function -[ViewController .cxx_destruct]
"-[ViewController .cxx_destruct]":      ## @"\01-[ViewController .cxx_destruct]"
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rsi
	movq	_OBJC_IVAR_$_ViewController._aTextFiled(%rip), %rdi
	addq	%rdi, %rsi
	movq	%rsi, %rdi
	callq	_objc_destroyWeak
	addq	$16, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function -[AddressInfo logDescription]
"-[AddressInfo logDescription]":        ## @"\01-[AddressInfo logDescription]"
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$80, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rsi
	movq	L_OBJC_SELECTOR_REFERENCES_.97(%rip), %rdi
	movq	%rdi, -24(%rbp)         ## 8-byte Spill
	movq	%rsi, %rdi
	movq	-24(%rbp), %rsi         ## 8-byte Reload
	callq	*_objc_msgSend@GOTPCREL(%rip)
	movq	%rax, %rdi
	callq	_objc_retainAutoreleasedReturnValue
	leaq	L__unnamed_cfstring_.95(%rip), %rsi
	movq	%rsi, %rdi
	movq	%rax, %rsi
	movq	%rax, -32(%rbp)         ## 8-byte Spill
	movb	$0, %al
	callq	_NSLog
	movq	-32(%rbp), %rsi         ## 8-byte Reload
	movq	%rsi, %rdi
	callq	*_objc_release@GOTPCREL(%rip)
	movq	-8(%rbp), %rsi
	movq	L_OBJC_SELECTOR_REFERENCES_.100(%rip), %rdi
	movq	%rdi, -40(%rbp)         ## 8-byte Spill
	movq	%rsi, %rdi
	movq	-40(%rbp), %rsi         ## 8-byte Reload
	callq	*_objc_msgSend@GOTPCREL(%rip)
	movq	%rax, %rdi
	callq	_objc_retainAutoreleasedReturnValue
	leaq	L__unnamed_cfstring_.99(%rip), %rsi
	movq	%rsi, %rdi
	movq	%rax, %rsi
	movq	%rax, -48(%rbp)         ## 8-byte Spill
	movb	$0, %al
	callq	_NSLog
	movq	-48(%rbp), %rsi         ## 8-byte Reload
	movq	%rsi, %rdi
	callq	*_objc_release@GOTPCREL(%rip)
	movq	-8(%rbp), %rsi
	movq	L_OBJC_SELECTOR_REFERENCES_.104(%rip), %rdi
	movq	%rdi, -56(%rbp)         ## 8-byte Spill
	movq	%rsi, %rdi
	movq	-56(%rbp), %rsi         ## 8-byte Reload
	callq	*_objc_msgSend@GOTPCREL(%rip)
	movq	%rax, %rdi
	callq	_objc_retainAutoreleasedReturnValue
	leaq	L__unnamed_cfstring_.102(%rip), %rsi
	movq	%rsi, %rdi
	movq	%rax, %rsi
	movq	%rax, -64(%rbp)         ## 8-byte Spill
	movb	$0, %al
	callq	_NSLog
	movq	-64(%rbp), %rsi         ## 8-byte Reload
	movq	%rsi, %rdi
	callq	*_objc_release@GOTPCREL(%rip)
	movq	-8(%rbp), %rsi
	movq	L_OBJC_SELECTOR_REFERENCES_.108(%rip), %rdi
	movq	%rdi, -72(%rbp)         ## 8-byte Spill
	movq	%rsi, %rdi
	movq	-72(%rbp), %rsi         ## 8-byte Reload
	callq	*_objc_msgSend@GOTPCREL(%rip)
	movq	%rax, %rdi
	callq	_objc_retainAutoreleasedReturnValue
	leaq	L__unnamed_cfstring_.106(%rip), %rsi
	movq	%rsi, %rdi
	movq	%rax, %rsi
	movq	%rax, -80(%rbp)         ## 8-byte Spill
	movb	$0, %al
	callq	_NSLog
	movq	-80(%rbp), %rsi         ## 8-byte Reload
	movq	%rsi, %rdi
	callq	*_objc_release@GOTPCREL(%rip)
	addq	$80, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function -[AddressInfo addressName]
"-[AddressInfo addressName]":           ## @"\01-[AddressInfo addressName]"
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	movl	$8, %edx
	xorl	%ecx, %ecx
	popq	%rbp
	jmp	_objc_getProperty       ## TAILCALL
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function -[AddressInfo setAddressName:]
"-[AddressInfo setAddressName:]":       ## @"\01-[AddressInfo setAddressName:]"
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdx
	movq	-24(%rbp), %rdi
	movq	%rdi, -32(%rbp)         ## 8-byte Spill
	movq	%rdx, %rdi
	movq	-32(%rbp), %rdx         ## 8-byte Reload
	movl	$8, %ecx
	callq	_objc_setProperty_nonatomic_copy
	addq	$32, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function -[AddressInfo addressNumber]
"-[AddressInfo addressNumber]":         ## @"\01-[AddressInfo addressNumber]"
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	movl	$16, %edx
	xorl	%ecx, %ecx
	popq	%rbp
	jmp	_objc_getProperty       ## TAILCALL
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function -[AddressInfo setAddressNumber:]
"-[AddressInfo setAddressNumber:]":     ## @"\01-[AddressInfo setAddressNumber:]"
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdx
	movq	-24(%rbp), %rdi
	movq	%rdi, -32(%rbp)         ## 8-byte Spill
	movq	%rdx, %rdi
	movq	-32(%rbp), %rdx         ## 8-byte Reload
	movl	$16, %ecx
	callq	_objc_setProperty_nonatomic_copy
	addq	$32, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function -[AddressInfo addressId]
"-[AddressInfo addressId]":             ## @"\01-[AddressInfo addressId]"
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	movl	$24, %edx
	xorl	%ecx, %ecx
	popq	%rbp
	jmp	_objc_getProperty       ## TAILCALL
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function -[AddressInfo setAddressId:]
"-[AddressInfo setAddressId:]":         ## @"\01-[AddressInfo setAddressId:]"
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdx
	movq	-24(%rbp), %rdi
	movq	%rdi, -32(%rbp)         ## 8-byte Spill
	movq	%rdx, %rdi
	movq	-32(%rbp), %rdx         ## 8-byte Reload
	movl	$24, %ecx
	callq	_objc_setProperty_nonatomic_copy
	addq	$32, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function -[AddressInfo addressDesc]
"-[AddressInfo addressDesc]":           ## @"\01-[AddressInfo addressDesc]"
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	movl	$32, %edx
	xorl	%ecx, %ecx
	popq	%rbp
	jmp	_objc_getProperty       ## TAILCALL
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function -[AddressInfo setAddressDesc:]
"-[AddressInfo setAddressDesc:]":       ## @"\01-[AddressInfo setAddressDesc:]"
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdx
	movq	-24(%rbp), %rdi
	movq	%rdi, -32(%rbp)         ## 8-byte Spill
	movq	%rdx, %rdi
	movq	-32(%rbp), %rdx         ## 8-byte Reload
	movl	$32, %ecx
	callq	_objc_setProperty_nonatomic_copy
	addq	$32, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function -[AddressInfo .cxx_destruct]
"-[AddressInfo .cxx_destruct]":         ## @"\01-[AddressInfo .cxx_destruct]"
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	xorl	%eax, %eax
	movl	%eax, %ecx
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rsi
	movq	%rsi, %rdi
	addq	$32, %rdi
	movq	%rsi, -24(%rbp)         ## 8-byte Spill
	movq	%rcx, %rsi
	callq	_objc_storeStrong
	xorl	%eax, %eax
	movl	%eax, %esi
	movq	-24(%rbp), %rcx         ## 8-byte Reload
	addq	$24, %rcx
	movq	%rcx, %rdi
	callq	_objc_storeStrong
	xorl	%eax, %eax
	movl	%eax, %esi
	movq	-24(%rbp), %rcx         ## 8-byte Reload
	addq	$16, %rcx
	movq	%rcx, %rdi
	callq	_objc_storeStrong
	xorl	%eax, %eax
	movl	%eax, %esi
	movq	-24(%rbp), %rcx         ## 8-byte Reload
	addq	$8, %rcx
	movq	%rcx, %rdi
	callq	_objc_storeStrong
	addq	$32, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__DATA,__objc_data
	.globl	_OBJC_CLASS_$_ViewController ## @"OBJC_CLASS_$_ViewController"
	.p2align	3
_OBJC_CLASS_$_ViewController:
	.quad	_OBJC_METACLASS_$_ViewController
	.quad	_OBJC_CLASS_$_UIViewController
	.quad	__objc_empty_cache
	.quad	0
	.quad	l_OBJC_CLASS_RO_$_ViewController

	.section	__DATA,__objc_superrefs,regular,no_dead_strip
	.p2align	3               ## @"OBJC_CLASSLIST_SUP_REFS_$_"
L_OBJC_CLASSLIST_SUP_REFS_$_:
	.quad	_OBJC_CLASS_$_ViewController

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_:                  ## @OBJC_METH_VAR_NAME_
	.asciz	"viewDidLoad"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.p2align	3               ## @OBJC_SELECTOR_REFERENCES_
L_OBJC_SELECTOR_REFERENCES_:
	.quad	L_OBJC_METH_VAR_NAME_

	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"%s"

	.section	__DATA,__cfstring
	.p2align	3               ## @_unnamed_cfstring_
L__unnamed_cfstring_:
	.quad	___CFConstantStringClassReference
	.long	1992                    ## 0x7c8
	.space	4
	.quad	L_.str
	.quad	2                       ## 0x2

	.section	__TEXT,__cstring,cstring_literals
"L___FUNCTION__.-[ViewController viewDidLoad]": ## @"__FUNCTION__.-[ViewController viewDidLoad]"
	.asciz	"-[ViewController viewDidLoad]"

	.section	__DATA,__objc_data
	.globl	_OBJC_CLASS_$_AddressInfo ## @"OBJC_CLASS_$_AddressInfo"
	.p2align	3
_OBJC_CLASS_$_AddressInfo:
	.quad	_OBJC_METACLASS_$_AddressInfo
	.quad	_OBJC_CLASS_$_NSObject
	.quad	__objc_empty_cache
	.quad	0
	.quad	l_OBJC_CLASS_RO_$_AddressInfo

	.section	__DATA,__objc_classrefs,regular,no_dead_strip
	.p2align	3               ## @"OBJC_CLASSLIST_REFERENCES_$_"
L_OBJC_CLASSLIST_REFERENCES_$_:
	.quad	_OBJC_CLASS_$_AddressInfo

	.section	__TEXT,__cstring,cstring_literals
L_.str.1:                               ## @.str.1
	.asciz	"&cls = %p"

	.section	__DATA,__cfstring
	.p2align	3               ## @_unnamed_cfstring_.2
L__unnamed_cfstring_.2:
	.quad	___CFConstantStringClassReference
	.long	1992                    ## 0x7c8
	.space	4
	.quad	L_.str.1
	.quad	9                       ## 0x9

	.section	__TEXT,__cstring,cstring_literals
L_.str.3:                               ## @.str.3
	.asciz	"&cls1 = %p"

	.section	__DATA,__cfstring
	.p2align	3               ## @_unnamed_cfstring_.4
L__unnamed_cfstring_.4:
	.quad	___CFConstantStringClassReference
	.long	1992                    ## 0x7c8
	.space	4
	.quad	L_.str.3
	.quad	10                      ## 0xa

	.section	__TEXT,__cstring,cstring_literals
L_.str.5:                               ## @.str.5
	.asciz	"&obj = %p"

	.section	__DATA,__cfstring
	.p2align	3               ## @_unnamed_cfstring_.6
L__unnamed_cfstring_.6:
	.quad	___CFConstantStringClassReference
	.long	1992                    ## 0x7c8
	.space	4
	.quad	L_.str.5
	.quad	9                       ## 0x9

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.7:                ## @OBJC_METH_VAR_NAME_.7
	.asciz	"logDescription"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.p2align	3               ## @OBJC_SELECTOR_REFERENCES_.8
L_OBJC_SELECTOR_REFERENCES_.8:
	.quad	L_OBJC_METH_VAR_NAME_.7

	.section	__TEXT,__cstring,cstring_literals
L_.str.9:                               ## @.str.9
	.asciz	"%p"

	.section	__DATA,__cfstring
	.p2align	3               ## @_unnamed_cfstring_.10
L__unnamed_cfstring_.10:
	.quad	___CFConstantStringClassReference
	.long	1992                    ## 0x7c8
	.space	4
	.quad	L_.str.9
	.quad	2                       ## 0x2

	.section	__DATA,__objc_classrefs,regular,no_dead_strip
	.p2align	3               ## @"OBJC_CLASSLIST_REFERENCES_$_.11"
L_OBJC_CLASSLIST_REFERENCES_$_.11:
	.quad	_OBJC_CLASS_$_UIColor

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.12:               ## @OBJC_METH_VAR_NAME_.12
	.asciz	"purpleColor"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.p2align	3               ## @OBJC_SELECTOR_REFERENCES_.13
L_OBJC_SELECTOR_REFERENCES_.13:
	.quad	L_OBJC_METH_VAR_NAME_.12

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.14:               ## @OBJC_METH_VAR_NAME_.14
	.asciz	"view"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.p2align	3               ## @OBJC_SELECTOR_REFERENCES_.15
L_OBJC_SELECTOR_REFERENCES_.15:
	.quad	L_OBJC_METH_VAR_NAME_.14

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.16:               ## @OBJC_METH_VAR_NAME_.16
	.asciz	"setBackgroundColor:"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.p2align	3               ## @OBJC_SELECTOR_REFERENCES_.17
L_OBJC_SELECTOR_REFERENCES_.17:
	.quad	L_OBJC_METH_VAR_NAME_.16

	.section	__TEXT,__cstring,cstring_literals
L_.str.18:                              ## @.str.18
	.asciz	"Injected %s"

	.section	__DATA,__cfstring
	.p2align	3               ## @_unnamed_cfstring_.19
L__unnamed_cfstring_.19:
	.quad	___CFConstantStringClassReference
	.long	1992                    ## 0x7c8
	.space	4
	.quad	L_.str.18
	.quad	11                      ## 0xb

	.section	__TEXT,__cstring,cstring_literals
"L___FUNCTION__.-[ViewController setupUI]": ## @"__FUNCTION__.-[ViewController setupUI]"
	.asciz	"-[ViewController setupUI]"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.20:               ## @OBJC_METH_VAR_NAME_.20
	.asciz	"viewWillAppear:"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.p2align	3               ## @OBJC_SELECTOR_REFERENCES_.21
L_OBJC_SELECTOR_REFERENCES_.21:
	.quad	L_OBJC_METH_VAR_NAME_.20

	.section	__TEXT,__cstring,cstring_literals
"L___FUNCTION__.-[ViewController viewWillAppear:]": ## @"__FUNCTION__.-[ViewController viewWillAppear:]"
	.asciz	"-[ViewController viewWillAppear:]"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.22:               ## @OBJC_METH_VAR_NAME_.22
	.asciz	"lightGrayColor"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.p2align	3               ## @OBJC_SELECTOR_REFERENCES_.23
L_OBJC_SELECTOR_REFERENCES_.23:
	.quad	L_OBJC_METH_VAR_NAME_.22

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.24:               ## @OBJC_METH_VAR_NAME_.24
	.asciz	"viewDidAppear:"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.p2align	3               ## @OBJC_SELECTOR_REFERENCES_.25
L_OBJC_SELECTOR_REFERENCES_.25:
	.quad	L_OBJC_METH_VAR_NAME_.24

	.section	__TEXT,__cstring,cstring_literals
"L___FUNCTION__.-[ViewController viewDidAppear:]": ## @"__FUNCTION__.-[ViewController viewDidAppear:]"
	.asciz	"-[ViewController viewDidAppear:]"

	.private_extern	_OBJC_IVAR_$_ViewController._aTextFiled ## @"OBJC_IVAR_$_ViewController._aTextFiled"
	.section	__DATA,__objc_ivar
	.globl	_OBJC_IVAR_$_ViewController._aTextFiled
	.p2align	3
_OBJC_IVAR_$_ViewController._aTextFiled:
	.quad	8                       ## 0x8

	.section	__TEXT,__objc_classname,cstring_literals
L_OBJC_CLASS_NAME_:                     ## @OBJC_CLASS_NAME_
	.asciz	"ViewController"

L_OBJC_CLASS_NAME_.26:                  ## @OBJC_CLASS_NAME_.26
	.asciz	"UITextFieldDelegate"

L_OBJC_CLASS_NAME_.27:                  ## @OBJC_CLASS_NAME_.27
	.asciz	"NSObject"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.28:               ## @OBJC_METH_VAR_NAME_.28
	.asciz	"isEqual:"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_:                  ## @OBJC_METH_VAR_TYPE_
	.asciz	"B24@0:8@16"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.29:               ## @OBJC_METH_VAR_NAME_.29
	.asciz	"class"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_.30:               ## @OBJC_METH_VAR_TYPE_.30
	.asciz	"#16@0:8"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.31:               ## @OBJC_METH_VAR_NAME_.31
	.asciz	"self"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_.32:               ## @OBJC_METH_VAR_TYPE_.32
	.asciz	"@16@0:8"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.33:               ## @OBJC_METH_VAR_NAME_.33
	.asciz	"performSelector:"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_.34:               ## @OBJC_METH_VAR_TYPE_.34
	.asciz	"@24@0:8:16"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.35:               ## @OBJC_METH_VAR_NAME_.35
	.asciz	"performSelector:withObject:"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_.36:               ## @OBJC_METH_VAR_TYPE_.36
	.asciz	"@32@0:8:16@24"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.37:               ## @OBJC_METH_VAR_NAME_.37
	.asciz	"performSelector:withObject:withObject:"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_.38:               ## @OBJC_METH_VAR_TYPE_.38
	.asciz	"@40@0:8:16@24@32"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.39:               ## @OBJC_METH_VAR_NAME_.39
	.asciz	"isProxy"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_.40:               ## @OBJC_METH_VAR_TYPE_.40
	.asciz	"B16@0:8"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.41:               ## @OBJC_METH_VAR_NAME_.41
	.asciz	"isKindOfClass:"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_.42:               ## @OBJC_METH_VAR_TYPE_.42
	.asciz	"B24@0:8#16"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.43:               ## @OBJC_METH_VAR_NAME_.43
	.asciz	"isMemberOfClass:"

L_OBJC_METH_VAR_NAME_.44:               ## @OBJC_METH_VAR_NAME_.44
	.asciz	"conformsToProtocol:"

L_OBJC_METH_VAR_NAME_.45:               ## @OBJC_METH_VAR_NAME_.45
	.asciz	"respondsToSelector:"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_.46:               ## @OBJC_METH_VAR_TYPE_.46
	.asciz	"B24@0:8:16"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.47:               ## @OBJC_METH_VAR_NAME_.47
	.asciz	"retain"

L_OBJC_METH_VAR_NAME_.48:               ## @OBJC_METH_VAR_NAME_.48
	.asciz	"release"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_.49:               ## @OBJC_METH_VAR_TYPE_.49
	.asciz	"Vv16@0:8"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.50:               ## @OBJC_METH_VAR_NAME_.50
	.asciz	"autorelease"

L_OBJC_METH_VAR_NAME_.51:               ## @OBJC_METH_VAR_NAME_.51
	.asciz	"retainCount"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_.52:               ## @OBJC_METH_VAR_TYPE_.52
	.asciz	"Q16@0:8"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.53:               ## @OBJC_METH_VAR_NAME_.53
	.asciz	"zone"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_.54:               ## @OBJC_METH_VAR_TYPE_.54
	.asciz	"^{_NSZone=}16@0:8"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.55:               ## @OBJC_METH_VAR_NAME_.55
	.asciz	"hash"

L_OBJC_METH_VAR_NAME_.56:               ## @OBJC_METH_VAR_NAME_.56
	.asciz	"superclass"

L_OBJC_METH_VAR_NAME_.57:               ## @OBJC_METH_VAR_NAME_.57
	.asciz	"description"

	.section	__DATA,__objc_const
	.p2align	3               ## @"\01l_OBJC_$_PROTOCOL_INSTANCE_METHODS_NSObject"
l_OBJC_$_PROTOCOL_INSTANCE_METHODS_NSObject:
	.long	24                      ## 0x18
	.long	19                      ## 0x13
	.quad	L_OBJC_METH_VAR_NAME_.28
	.quad	L_OBJC_METH_VAR_TYPE_
	.quad	0
	.quad	L_OBJC_METH_VAR_NAME_.29
	.quad	L_OBJC_METH_VAR_TYPE_.30
	.quad	0
	.quad	L_OBJC_METH_VAR_NAME_.31
	.quad	L_OBJC_METH_VAR_TYPE_.32
	.quad	0
	.quad	L_OBJC_METH_VAR_NAME_.33
	.quad	L_OBJC_METH_VAR_TYPE_.34
	.quad	0
	.quad	L_OBJC_METH_VAR_NAME_.35
	.quad	L_OBJC_METH_VAR_TYPE_.36
	.quad	0
	.quad	L_OBJC_METH_VAR_NAME_.37
	.quad	L_OBJC_METH_VAR_TYPE_.38
	.quad	0
	.quad	L_OBJC_METH_VAR_NAME_.39
	.quad	L_OBJC_METH_VAR_TYPE_.40
	.quad	0
	.quad	L_OBJC_METH_VAR_NAME_.41
	.quad	L_OBJC_METH_VAR_TYPE_.42
	.quad	0
	.quad	L_OBJC_METH_VAR_NAME_.43
	.quad	L_OBJC_METH_VAR_TYPE_.42
	.quad	0
	.quad	L_OBJC_METH_VAR_NAME_.44
	.quad	L_OBJC_METH_VAR_TYPE_
	.quad	0
	.quad	L_OBJC_METH_VAR_NAME_.45
	.quad	L_OBJC_METH_VAR_TYPE_.46
	.quad	0
	.quad	L_OBJC_METH_VAR_NAME_.47
	.quad	L_OBJC_METH_VAR_TYPE_.32
	.quad	0
	.quad	L_OBJC_METH_VAR_NAME_.48
	.quad	L_OBJC_METH_VAR_TYPE_.49
	.quad	0
	.quad	L_OBJC_METH_VAR_NAME_.50
	.quad	L_OBJC_METH_VAR_TYPE_.32
	.quad	0
	.quad	L_OBJC_METH_VAR_NAME_.51
	.quad	L_OBJC_METH_VAR_TYPE_.52
	.quad	0
	.quad	L_OBJC_METH_VAR_NAME_.53
	.quad	L_OBJC_METH_VAR_TYPE_.54
	.quad	0
	.quad	L_OBJC_METH_VAR_NAME_.55
	.quad	L_OBJC_METH_VAR_TYPE_.52
	.quad	0
	.quad	L_OBJC_METH_VAR_NAME_.56
	.quad	L_OBJC_METH_VAR_TYPE_.30
	.quad	0
	.quad	L_OBJC_METH_VAR_NAME_.57
	.quad	L_OBJC_METH_VAR_TYPE_.32
	.quad	0

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.58:               ## @OBJC_METH_VAR_NAME_.58
	.asciz	"debugDescription"

	.section	__DATA,__objc_const
	.p2align	3               ## @"\01l_OBJC_$_PROTOCOL_INSTANCE_METHODS_OPT_NSObject"
l_OBJC_$_PROTOCOL_INSTANCE_METHODS_OPT_NSObject:
	.long	24                      ## 0x18
	.long	1                       ## 0x1
	.quad	L_OBJC_METH_VAR_NAME_.58
	.quad	L_OBJC_METH_VAR_TYPE_.32
	.quad	0

	.section	__TEXT,__cstring,cstring_literals
L_OBJC_PROP_NAME_ATTR_:                 ## @OBJC_PROP_NAME_ATTR_
	.asciz	"hash"

L_OBJC_PROP_NAME_ATTR_.59:              ## @OBJC_PROP_NAME_ATTR_.59
	.asciz	"TQ,R"

L_OBJC_PROP_NAME_ATTR_.60:              ## @OBJC_PROP_NAME_ATTR_.60
	.asciz	"superclass"

L_OBJC_PROP_NAME_ATTR_.61:              ## @OBJC_PROP_NAME_ATTR_.61
	.asciz	"T#,R"

L_OBJC_PROP_NAME_ATTR_.62:              ## @OBJC_PROP_NAME_ATTR_.62
	.asciz	"description"

L_OBJC_PROP_NAME_ATTR_.63:              ## @OBJC_PROP_NAME_ATTR_.63
	.asciz	"T@\"NSString\",R,C"

L_OBJC_PROP_NAME_ATTR_.64:              ## @OBJC_PROP_NAME_ATTR_.64
	.asciz	"debugDescription"

	.section	__DATA,__objc_const
	.p2align	3               ## @"\01l_OBJC_$_PROP_LIST_NSObject"
l_OBJC_$_PROP_LIST_NSObject:
	.long	16                      ## 0x10
	.long	4                       ## 0x4
	.quad	L_OBJC_PROP_NAME_ATTR_
	.quad	L_OBJC_PROP_NAME_ATTR_.59
	.quad	L_OBJC_PROP_NAME_ATTR_.60
	.quad	L_OBJC_PROP_NAME_ATTR_.61
	.quad	L_OBJC_PROP_NAME_ATTR_.62
	.quad	L_OBJC_PROP_NAME_ATTR_.63
	.quad	L_OBJC_PROP_NAME_ATTR_.64
	.quad	L_OBJC_PROP_NAME_ATTR_.63

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_.65:               ## @OBJC_METH_VAR_TYPE_.65
	.asciz	"B24@0:8@\"Protocol\"16"

L_OBJC_METH_VAR_TYPE_.66:               ## @OBJC_METH_VAR_TYPE_.66
	.asciz	"@\"NSString\"16@0:8"

	.section	__DATA,__objc_const
	.p2align	3               ## @"\01l_OBJC_$_PROTOCOL_METHOD_TYPES_NSObject"
l_OBJC_$_PROTOCOL_METHOD_TYPES_NSObject:
	.quad	L_OBJC_METH_VAR_TYPE_
	.quad	L_OBJC_METH_VAR_TYPE_.30
	.quad	L_OBJC_METH_VAR_TYPE_.32
	.quad	L_OBJC_METH_VAR_TYPE_.34
	.quad	L_OBJC_METH_VAR_TYPE_.36
	.quad	L_OBJC_METH_VAR_TYPE_.38
	.quad	L_OBJC_METH_VAR_TYPE_.40
	.quad	L_OBJC_METH_VAR_TYPE_.42
	.quad	L_OBJC_METH_VAR_TYPE_.42
	.quad	L_OBJC_METH_VAR_TYPE_.65
	.quad	L_OBJC_METH_VAR_TYPE_.46
	.quad	L_OBJC_METH_VAR_TYPE_.32
	.quad	L_OBJC_METH_VAR_TYPE_.49
	.quad	L_OBJC_METH_VAR_TYPE_.32
	.quad	L_OBJC_METH_VAR_TYPE_.52
	.quad	L_OBJC_METH_VAR_TYPE_.54
	.quad	L_OBJC_METH_VAR_TYPE_.52
	.quad	L_OBJC_METH_VAR_TYPE_.30
	.quad	L_OBJC_METH_VAR_TYPE_.66
	.quad	L_OBJC_METH_VAR_TYPE_.66

	.private_extern	__OBJC_PROTOCOL_$_NSObject ## @"_OBJC_PROTOCOL_$_NSObject"
	.section	__DATA,__data
	.globl	__OBJC_PROTOCOL_$_NSObject
	.weak_definition	__OBJC_PROTOCOL_$_NSObject
	.p2align	3
__OBJC_PROTOCOL_$_NSObject:
	.quad	0
	.quad	L_OBJC_CLASS_NAME_.27
	.quad	0
	.quad	l_OBJC_$_PROTOCOL_INSTANCE_METHODS_NSObject
	.quad	0
	.quad	l_OBJC_$_PROTOCOL_INSTANCE_METHODS_OPT_NSObject
	.quad	0
	.quad	l_OBJC_$_PROP_LIST_NSObject
	.long	96                      ## 0x60
	.long	0                       ## 0x0
	.quad	l_OBJC_$_PROTOCOL_METHOD_TYPES_NSObject
	.quad	0
	.quad	0

	.private_extern	__OBJC_LABEL_PROTOCOL_$_NSObject ## @"_OBJC_LABEL_PROTOCOL_$_NSObject"
	.section	__DATA,__objc_protolist,coalesced,no_dead_strip
	.globl	__OBJC_LABEL_PROTOCOL_$_NSObject
	.weak_definition	__OBJC_LABEL_PROTOCOL_$_NSObject
	.p2align	3
__OBJC_LABEL_PROTOCOL_$_NSObject:
	.quad	__OBJC_PROTOCOL_$_NSObject

	.section	__DATA,__objc_const
	.p2align	3               ## @"\01l_OBJC_$_PROTOCOL_REFS_UITextFieldDelegate"
l_OBJC_$_PROTOCOL_REFS_UITextFieldDelegate:
	.quad	1                       ## 0x1
	.quad	__OBJC_PROTOCOL_$_NSObject
	.quad	0

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.67:               ## @OBJC_METH_VAR_NAME_.67
	.asciz	"textFieldShouldBeginEditing:"

L_OBJC_METH_VAR_NAME_.68:               ## @OBJC_METH_VAR_NAME_.68
	.asciz	"textFieldDidBeginEditing:"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_.69:               ## @OBJC_METH_VAR_TYPE_.69
	.asciz	"v24@0:8@16"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.70:               ## @OBJC_METH_VAR_NAME_.70
	.asciz	"textFieldShouldEndEditing:"

L_OBJC_METH_VAR_NAME_.71:               ## @OBJC_METH_VAR_NAME_.71
	.asciz	"textFieldDidEndEditing:"

L_OBJC_METH_VAR_NAME_.72:               ## @OBJC_METH_VAR_NAME_.72
	.asciz	"textFieldDidEndEditing:reason:"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_.73:               ## @OBJC_METH_VAR_TYPE_.73
	.asciz	"v32@0:8@16q24"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.74:               ## @OBJC_METH_VAR_NAME_.74
	.asciz	"textField:shouldChangeCharactersInRange:replacementString:"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_.75:               ## @OBJC_METH_VAR_TYPE_.75
	.asciz	"B48@0:8@16{_NSRange=QQ}24@40"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.76:               ## @OBJC_METH_VAR_NAME_.76
	.asciz	"textFieldDidChangeSelection:"

L_OBJC_METH_VAR_NAME_.77:               ## @OBJC_METH_VAR_NAME_.77
	.asciz	"textFieldShouldClear:"

L_OBJC_METH_VAR_NAME_.78:               ## @OBJC_METH_VAR_NAME_.78
	.asciz	"textFieldShouldReturn:"

	.section	__DATA,__objc_const
	.p2align	3               ## @"\01l_OBJC_$_PROTOCOL_INSTANCE_METHODS_OPT_UITextFieldDelegate"
l_OBJC_$_PROTOCOL_INSTANCE_METHODS_OPT_UITextFieldDelegate:
	.long	24                      ## 0x18
	.long	9                       ## 0x9
	.quad	L_OBJC_METH_VAR_NAME_.67
	.quad	L_OBJC_METH_VAR_TYPE_
	.quad	0
	.quad	L_OBJC_METH_VAR_NAME_.68
	.quad	L_OBJC_METH_VAR_TYPE_.69
	.quad	0
	.quad	L_OBJC_METH_VAR_NAME_.70
	.quad	L_OBJC_METH_VAR_TYPE_
	.quad	0
	.quad	L_OBJC_METH_VAR_NAME_.71
	.quad	L_OBJC_METH_VAR_TYPE_.69
	.quad	0
	.quad	L_OBJC_METH_VAR_NAME_.72
	.quad	L_OBJC_METH_VAR_TYPE_.73
	.quad	0
	.quad	L_OBJC_METH_VAR_NAME_.74
	.quad	L_OBJC_METH_VAR_TYPE_.75
	.quad	0
	.quad	L_OBJC_METH_VAR_NAME_.76
	.quad	L_OBJC_METH_VAR_TYPE_.69
	.quad	0
	.quad	L_OBJC_METH_VAR_NAME_.77
	.quad	L_OBJC_METH_VAR_TYPE_
	.quad	0
	.quad	L_OBJC_METH_VAR_NAME_.78
	.quad	L_OBJC_METH_VAR_TYPE_
	.quad	0

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_.79:               ## @OBJC_METH_VAR_TYPE_.79
	.asciz	"B24@0:8@\"UITextField\"16"

L_OBJC_METH_VAR_TYPE_.80:               ## @OBJC_METH_VAR_TYPE_.80
	.asciz	"v24@0:8@\"UITextField\"16"

L_OBJC_METH_VAR_TYPE_.81:               ## @OBJC_METH_VAR_TYPE_.81
	.asciz	"v32@0:8@\"UITextField\"16q24"

L_OBJC_METH_VAR_TYPE_.82:               ## @OBJC_METH_VAR_TYPE_.82
	.asciz	"B48@0:8@\"UITextField\"16{_NSRange=QQ}24@\"NSString\"40"

	.section	__DATA,__objc_const
	.p2align	3               ## @"\01l_OBJC_$_PROTOCOL_METHOD_TYPES_UITextFieldDelegate"
l_OBJC_$_PROTOCOL_METHOD_TYPES_UITextFieldDelegate:
	.quad	L_OBJC_METH_VAR_TYPE_.79
	.quad	L_OBJC_METH_VAR_TYPE_.80
	.quad	L_OBJC_METH_VAR_TYPE_.79
	.quad	L_OBJC_METH_VAR_TYPE_.80
	.quad	L_OBJC_METH_VAR_TYPE_.81
	.quad	L_OBJC_METH_VAR_TYPE_.82
	.quad	L_OBJC_METH_VAR_TYPE_.80
	.quad	L_OBJC_METH_VAR_TYPE_.79
	.quad	L_OBJC_METH_VAR_TYPE_.79

	.private_extern	__OBJC_PROTOCOL_$_UITextFieldDelegate ## @"_OBJC_PROTOCOL_$_UITextFieldDelegate"
	.section	__DATA,__data
	.globl	__OBJC_PROTOCOL_$_UITextFieldDelegate
	.weak_definition	__OBJC_PROTOCOL_$_UITextFieldDelegate
	.p2align	3
__OBJC_PROTOCOL_$_UITextFieldDelegate:
	.quad	0
	.quad	L_OBJC_CLASS_NAME_.26
	.quad	l_OBJC_$_PROTOCOL_REFS_UITextFieldDelegate
	.quad	0
	.quad	0
	.quad	l_OBJC_$_PROTOCOL_INSTANCE_METHODS_OPT_UITextFieldDelegate
	.quad	0
	.quad	0
	.long	96                      ## 0x60
	.long	0                       ## 0x0
	.quad	l_OBJC_$_PROTOCOL_METHOD_TYPES_UITextFieldDelegate
	.quad	0
	.quad	0

	.private_extern	__OBJC_LABEL_PROTOCOL_$_UITextFieldDelegate ## @"_OBJC_LABEL_PROTOCOL_$_UITextFieldDelegate"
	.section	__DATA,__objc_protolist,coalesced,no_dead_strip
	.globl	__OBJC_LABEL_PROTOCOL_$_UITextFieldDelegate
	.weak_definition	__OBJC_LABEL_PROTOCOL_$_UITextFieldDelegate
	.p2align	3
__OBJC_LABEL_PROTOCOL_$_UITextFieldDelegate:
	.quad	__OBJC_PROTOCOL_$_UITextFieldDelegate

	.section	__DATA,__objc_const
	.p2align	3               ## @"\01l_OBJC_CLASS_PROTOCOLS_$_ViewController"
l_OBJC_CLASS_PROTOCOLS_$_ViewController:
	.quad	1                       ## 0x1
	.quad	__OBJC_PROTOCOL_$_UITextFieldDelegate
	.quad	0

	.p2align	3               ## @"\01l_OBJC_METACLASS_RO_$_ViewController"
l_OBJC_METACLASS_RO_$_ViewController:
	.long	389                     ## 0x185
	.long	40                      ## 0x28
	.long	40                      ## 0x28
	.space	4
	.quad	0
	.quad	L_OBJC_CLASS_NAME_
	.quad	0
	.quad	l_OBJC_CLASS_PROTOCOLS_$_ViewController
	.quad	0
	.quad	0
	.quad	0

	.section	__DATA,__objc_data
	.globl	_OBJC_METACLASS_$_ViewController ## @"OBJC_METACLASS_$_ViewController"
	.p2align	3
_OBJC_METACLASS_$_ViewController:
	.quad	_OBJC_METACLASS_$_NSObject
	.quad	_OBJC_METACLASS_$_UIViewController
	.quad	__objc_empty_cache
	.quad	0
	.quad	l_OBJC_METACLASS_RO_$_ViewController

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_.83:               ## @OBJC_METH_VAR_TYPE_.83
	.asciz	"v16@0:8"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.84:               ## @OBJC_METH_VAR_NAME_.84
	.asciz	"setupUI"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_.85:               ## @OBJC_METH_VAR_TYPE_.85
	.asciz	"v20@0:8B16"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.86:               ## @OBJC_METH_VAR_NAME_.86
	.asciz	".cxx_destruct"

L_OBJC_METH_VAR_NAME_.87:               ## @OBJC_METH_VAR_NAME_.87
	.asciz	"aTextFiled"

L_OBJC_METH_VAR_NAME_.88:               ## @OBJC_METH_VAR_NAME_.88
	.asciz	"setATextFiled:"

	.section	__DATA,__objc_const
	.p2align	3               ## @"\01l_OBJC_$_INSTANCE_METHODS_ViewController"
l_OBJC_$_INSTANCE_METHODS_ViewController:
	.long	24                      ## 0x18
	.long	7                       ## 0x7
	.quad	L_OBJC_METH_VAR_NAME_
	.quad	L_OBJC_METH_VAR_TYPE_.83
	.quad	"-[ViewController viewDidLoad]"
	.quad	L_OBJC_METH_VAR_NAME_.84
	.quad	L_OBJC_METH_VAR_TYPE_.83
	.quad	"-[ViewController setupUI]"
	.quad	L_OBJC_METH_VAR_NAME_.20
	.quad	L_OBJC_METH_VAR_TYPE_.85
	.quad	"-[ViewController viewWillAppear:]"
	.quad	L_OBJC_METH_VAR_NAME_.24
	.quad	L_OBJC_METH_VAR_TYPE_.85
	.quad	"-[ViewController viewDidAppear:]"
	.quad	L_OBJC_METH_VAR_NAME_.86
	.quad	L_OBJC_METH_VAR_TYPE_.83
	.quad	"-[ViewController .cxx_destruct]"
	.quad	L_OBJC_METH_VAR_NAME_.87
	.quad	L_OBJC_METH_VAR_TYPE_.32
	.quad	"-[ViewController aTextFiled]"
	.quad	L_OBJC_METH_VAR_NAME_.88
	.quad	L_OBJC_METH_VAR_TYPE_.69
	.quad	"-[ViewController setATextFiled:]"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.89:               ## @OBJC_METH_VAR_NAME_.89
	.asciz	"_aTextFiled"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_.90:               ## @OBJC_METH_VAR_TYPE_.90
	.asciz	"@\"UITextField\""

	.section	__DATA,__objc_const
	.p2align	3               ## @"\01l_OBJC_$_INSTANCE_VARIABLES_ViewController"
l_OBJC_$_INSTANCE_VARIABLES_ViewController:
	.long	32                      ## 0x20
	.long	1                       ## 0x1
	.quad	_OBJC_IVAR_$_ViewController._aTextFiled
	.quad	L_OBJC_METH_VAR_NAME_.89
	.quad	L_OBJC_METH_VAR_TYPE_.90
	.long	3                       ## 0x3
	.long	8                       ## 0x8

	.section	__TEXT,__objc_classname,cstring_literals
L_OBJC_CLASS_NAME_.91:                  ## @OBJC_CLASS_NAME_.91
	.asciz	"\001"

	.section	__TEXT,__cstring,cstring_literals
L_OBJC_PROP_NAME_ATTR_.92:              ## @OBJC_PROP_NAME_ATTR_.92
	.asciz	"aTextFiled"

L_OBJC_PROP_NAME_ATTR_.93:              ## @OBJC_PROP_NAME_ATTR_.93
	.asciz	"T@\"UITextField\",W,N,V_aTextFiled"

	.section	__DATA,__objc_const
	.p2align	3               ## @"\01l_OBJC_$_PROP_LIST_ViewController"
l_OBJC_$_PROP_LIST_ViewController:
	.long	16                      ## 0x10
	.long	5                       ## 0x5
	.quad	L_OBJC_PROP_NAME_ATTR_.92
	.quad	L_OBJC_PROP_NAME_ATTR_.93
	.quad	L_OBJC_PROP_NAME_ATTR_
	.quad	L_OBJC_PROP_NAME_ATTR_.59
	.quad	L_OBJC_PROP_NAME_ATTR_.60
	.quad	L_OBJC_PROP_NAME_ATTR_.61
	.quad	L_OBJC_PROP_NAME_ATTR_.62
	.quad	L_OBJC_PROP_NAME_ATTR_.63
	.quad	L_OBJC_PROP_NAME_ATTR_.64
	.quad	L_OBJC_PROP_NAME_ATTR_.63

	.p2align	3               ## @"\01l_OBJC_CLASS_RO_$_ViewController"
l_OBJC_CLASS_RO_$_ViewController:
	.long	388                     ## 0x184
	.long	8                       ## 0x8
	.long	16                      ## 0x10
	.space	4
	.quad	0
	.quad	L_OBJC_CLASS_NAME_
	.quad	l_OBJC_$_INSTANCE_METHODS_ViewController
	.quad	l_OBJC_CLASS_PROTOCOLS_$_ViewController
	.quad	l_OBJC_$_INSTANCE_VARIABLES_ViewController
	.quad	L_OBJC_CLASS_NAME_.91
	.quad	l_OBJC_$_PROP_LIST_ViewController

	.section	__TEXT,__cstring,cstring_literals
L_.str.94:                              ## @.str.94
	.asciz	"self.name = %@"

	.section	__DATA,__cfstring
	.p2align	3               ## @_unnamed_cfstring_.95
L__unnamed_cfstring_.95:
	.quad	___CFConstantStringClassReference
	.long	1992                    ## 0x7c8
	.space	4
	.quad	L_.str.94
	.quad	14                      ## 0xe

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.96:               ## @OBJC_METH_VAR_NAME_.96
	.asciz	"addressName"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.p2align	3               ## @OBJC_SELECTOR_REFERENCES_.97
L_OBJC_SELECTOR_REFERENCES_.97:
	.quad	L_OBJC_METH_VAR_NAME_.96

	.section	__TEXT,__cstring,cstring_literals
L_.str.98:                              ## @.str.98
	.asciz	"self.description = %@"

	.section	__DATA,__cfstring
	.p2align	3               ## @_unnamed_cfstring_.99
L__unnamed_cfstring_.99:
	.quad	___CFConstantStringClassReference
	.long	1992                    ## 0x7c8
	.space	4
	.quad	L_.str.98
	.quad	21                      ## 0x15

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.p2align	3               ## @OBJC_SELECTOR_REFERENCES_.100
L_OBJC_SELECTOR_REFERENCES_.100:
	.quad	L_OBJC_METH_VAR_NAME_.57

	.section	__TEXT,__cstring,cstring_literals
L_.str.101:                             ## @.str.101
	.asciz	"self.addressNumber = %@"

	.section	__DATA,__cfstring
	.p2align	3               ## @_unnamed_cfstring_.102
L__unnamed_cfstring_.102:
	.quad	___CFConstantStringClassReference
	.long	1992                    ## 0x7c8
	.space	4
	.quad	L_.str.101
	.quad	23                      ## 0x17

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.103:              ## @OBJC_METH_VAR_NAME_.103
	.asciz	"addressNumber"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.p2align	3               ## @OBJC_SELECTOR_REFERENCES_.104
L_OBJC_SELECTOR_REFERENCES_.104:
	.quad	L_OBJC_METH_VAR_NAME_.103

	.section	__TEXT,__cstring,cstring_literals
L_.str.105:                             ## @.str.105
	.asciz	"self.addressDesc = %@"

	.section	__DATA,__cfstring
	.p2align	3               ## @_unnamed_cfstring_.106
L__unnamed_cfstring_.106:
	.quad	___CFConstantStringClassReference
	.long	1992                    ## 0x7c8
	.space	4
	.quad	L_.str.105
	.quad	21                      ## 0x15

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.107:              ## @OBJC_METH_VAR_NAME_.107
	.asciz	"addressDesc"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.p2align	3               ## @OBJC_SELECTOR_REFERENCES_.108
L_OBJC_SELECTOR_REFERENCES_.108:
	.quad	L_OBJC_METH_VAR_NAME_.107

	.section	__TEXT,__objc_classname,cstring_literals
L_OBJC_CLASS_NAME_.109:                 ## @OBJC_CLASS_NAME_.109
	.asciz	"AddressInfo"

	.section	__DATA,__objc_const
	.p2align	3               ## @"\01l_OBJC_METACLASS_RO_$_AddressInfo"
l_OBJC_METACLASS_RO_$_AddressInfo:
	.long	389                     ## 0x185
	.long	40                      ## 0x28
	.long	40                      ## 0x28
	.space	4
	.quad	0
	.quad	L_OBJC_CLASS_NAME_.109
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0

	.section	__DATA,__objc_data
	.globl	_OBJC_METACLASS_$_AddressInfo ## @"OBJC_METACLASS_$_AddressInfo"
	.p2align	3
_OBJC_METACLASS_$_AddressInfo:
	.quad	_OBJC_METACLASS_$_NSObject
	.quad	_OBJC_METACLASS_$_NSObject
	.quad	__objc_empty_cache
	.quad	0
	.quad	l_OBJC_METACLASS_RO_$_AddressInfo

	.section	__TEXT,__objc_classname,cstring_literals
L_OBJC_CLASS_NAME_.110:                 ## @OBJC_CLASS_NAME_.110
	.asciz	"\004"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.111:              ## @OBJC_METH_VAR_NAME_.111
	.asciz	"setAddressName:"

L_OBJC_METH_VAR_NAME_.112:              ## @OBJC_METH_VAR_NAME_.112
	.asciz	"setAddressNumber:"

L_OBJC_METH_VAR_NAME_.113:              ## @OBJC_METH_VAR_NAME_.113
	.asciz	"addressId"

L_OBJC_METH_VAR_NAME_.114:              ## @OBJC_METH_VAR_NAME_.114
	.asciz	"setAddressId:"

L_OBJC_METH_VAR_NAME_.115:              ## @OBJC_METH_VAR_NAME_.115
	.asciz	"setAddressDesc:"

	.section	__DATA,__objc_const
	.p2align	3               ## @"\01l_OBJC_$_INSTANCE_METHODS_AddressInfo"
l_OBJC_$_INSTANCE_METHODS_AddressInfo:
	.long	24                      ## 0x18
	.long	10                      ## 0xa
	.quad	L_OBJC_METH_VAR_NAME_.7
	.quad	L_OBJC_METH_VAR_TYPE_.83
	.quad	"-[AddressInfo logDescription]"
	.quad	L_OBJC_METH_VAR_NAME_.86
	.quad	L_OBJC_METH_VAR_TYPE_.83
	.quad	"-[AddressInfo .cxx_destruct]"
	.quad	L_OBJC_METH_VAR_NAME_.96
	.quad	L_OBJC_METH_VAR_TYPE_.32
	.quad	"-[AddressInfo addressName]"
	.quad	L_OBJC_METH_VAR_NAME_.111
	.quad	L_OBJC_METH_VAR_TYPE_.69
	.quad	"-[AddressInfo setAddressName:]"
	.quad	L_OBJC_METH_VAR_NAME_.103
	.quad	L_OBJC_METH_VAR_TYPE_.32
	.quad	"-[AddressInfo addressNumber]"
	.quad	L_OBJC_METH_VAR_NAME_.112
	.quad	L_OBJC_METH_VAR_TYPE_.69
	.quad	"-[AddressInfo setAddressNumber:]"
	.quad	L_OBJC_METH_VAR_NAME_.113
	.quad	L_OBJC_METH_VAR_TYPE_.32
	.quad	"-[AddressInfo addressId]"
	.quad	L_OBJC_METH_VAR_NAME_.114
	.quad	L_OBJC_METH_VAR_TYPE_.69
	.quad	"-[AddressInfo setAddressId:]"
	.quad	L_OBJC_METH_VAR_NAME_.107
	.quad	L_OBJC_METH_VAR_TYPE_.32
	.quad	"-[AddressInfo addressDesc]"
	.quad	L_OBJC_METH_VAR_NAME_.115
	.quad	L_OBJC_METH_VAR_TYPE_.69
	.quad	"-[AddressInfo setAddressDesc:]"

	.private_extern	_OBJC_IVAR_$_AddressInfo._addressName ## @"OBJC_IVAR_$_AddressInfo._addressName"
	.section	__DATA,__objc_ivar
	.globl	_OBJC_IVAR_$_AddressInfo._addressName
	.p2align	3
_OBJC_IVAR_$_AddressInfo._addressName:
	.quad	8                       ## 0x8

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.116:              ## @OBJC_METH_VAR_NAME_.116
	.asciz	"_addressName"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_.117:              ## @OBJC_METH_VAR_TYPE_.117
	.asciz	"@\"NSString\""

	.private_extern	_OBJC_IVAR_$_AddressInfo._addressNumber ## @"OBJC_IVAR_$_AddressInfo._addressNumber"
	.section	__DATA,__objc_ivar
	.globl	_OBJC_IVAR_$_AddressInfo._addressNumber
	.p2align	3
_OBJC_IVAR_$_AddressInfo._addressNumber:
	.quad	16                      ## 0x10

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.118:              ## @OBJC_METH_VAR_NAME_.118
	.asciz	"_addressNumber"

	.private_extern	_OBJC_IVAR_$_AddressInfo._addressId ## @"OBJC_IVAR_$_AddressInfo._addressId"
	.section	__DATA,__objc_ivar
	.globl	_OBJC_IVAR_$_AddressInfo._addressId
	.p2align	3
_OBJC_IVAR_$_AddressInfo._addressId:
	.quad	24                      ## 0x18

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.119:              ## @OBJC_METH_VAR_NAME_.119
	.asciz	"_addressId"

	.private_extern	_OBJC_IVAR_$_AddressInfo._addressDesc ## @"OBJC_IVAR_$_AddressInfo._addressDesc"
	.section	__DATA,__objc_ivar
	.globl	_OBJC_IVAR_$_AddressInfo._addressDesc
	.p2align	3
_OBJC_IVAR_$_AddressInfo._addressDesc:
	.quad	32                      ## 0x20

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.120:              ## @OBJC_METH_VAR_NAME_.120
	.asciz	"_addressDesc"

	.section	__DATA,__objc_const
	.p2align	3               ## @"\01l_OBJC_$_INSTANCE_VARIABLES_AddressInfo"
l_OBJC_$_INSTANCE_VARIABLES_AddressInfo:
	.long	32                      ## 0x20
	.long	4                       ## 0x4
	.quad	_OBJC_IVAR_$_AddressInfo._addressName
	.quad	L_OBJC_METH_VAR_NAME_.116
	.quad	L_OBJC_METH_VAR_TYPE_.117
	.long	3                       ## 0x3
	.long	8                       ## 0x8
	.quad	_OBJC_IVAR_$_AddressInfo._addressNumber
	.quad	L_OBJC_METH_VAR_NAME_.118
	.quad	L_OBJC_METH_VAR_TYPE_.117
	.long	3                       ## 0x3
	.long	8                       ## 0x8
	.quad	_OBJC_IVAR_$_AddressInfo._addressId
	.quad	L_OBJC_METH_VAR_NAME_.119
	.quad	L_OBJC_METH_VAR_TYPE_.117
	.long	3                       ## 0x3
	.long	8                       ## 0x8
	.quad	_OBJC_IVAR_$_AddressInfo._addressDesc
	.quad	L_OBJC_METH_VAR_NAME_.120
	.quad	L_OBJC_METH_VAR_TYPE_.117
	.long	3                       ## 0x3
	.long	8                       ## 0x8

	.section	__TEXT,__cstring,cstring_literals
L_OBJC_PROP_NAME_ATTR_.121:             ## @OBJC_PROP_NAME_ATTR_.121
	.asciz	"addressName"

L_OBJC_PROP_NAME_ATTR_.122:             ## @OBJC_PROP_NAME_ATTR_.122
	.asciz	"T@\"NSString\",C,N,V_addressName"

L_OBJC_PROP_NAME_ATTR_.123:             ## @OBJC_PROP_NAME_ATTR_.123
	.asciz	"addressNumber"

L_OBJC_PROP_NAME_ATTR_.124:             ## @OBJC_PROP_NAME_ATTR_.124
	.asciz	"T@\"NSString\",C,N,V_addressNumber"

L_OBJC_PROP_NAME_ATTR_.125:             ## @OBJC_PROP_NAME_ATTR_.125
	.asciz	"addressId"

L_OBJC_PROP_NAME_ATTR_.126:             ## @OBJC_PROP_NAME_ATTR_.126
	.asciz	"T@\"NSString\",C,N,V_addressId"

L_OBJC_PROP_NAME_ATTR_.127:             ## @OBJC_PROP_NAME_ATTR_.127
	.asciz	"addressDesc"

L_OBJC_PROP_NAME_ATTR_.128:             ## @OBJC_PROP_NAME_ATTR_.128
	.asciz	"T@\"NSString\",C,N,V_addressDesc"

	.section	__DATA,__objc_const
	.p2align	3               ## @"\01l_OBJC_$_PROP_LIST_AddressInfo"
l_OBJC_$_PROP_LIST_AddressInfo:
	.long	16                      ## 0x10
	.long	4                       ## 0x4
	.quad	L_OBJC_PROP_NAME_ATTR_.121
	.quad	L_OBJC_PROP_NAME_ATTR_.122
	.quad	L_OBJC_PROP_NAME_ATTR_.123
	.quad	L_OBJC_PROP_NAME_ATTR_.124
	.quad	L_OBJC_PROP_NAME_ATTR_.125
	.quad	L_OBJC_PROP_NAME_ATTR_.126
	.quad	L_OBJC_PROP_NAME_ATTR_.127
	.quad	L_OBJC_PROP_NAME_ATTR_.128

	.p2align	3               ## @"\01l_OBJC_CLASS_RO_$_AddressInfo"
l_OBJC_CLASS_RO_$_AddressInfo:
	.long	388                     ## 0x184
	.long	8                       ## 0x8
	.long	40                      ## 0x28
	.space	4
	.quad	L_OBJC_CLASS_NAME_.110
	.quad	L_OBJC_CLASS_NAME_.109
	.quad	l_OBJC_$_INSTANCE_METHODS_AddressInfo
	.quad	0
	.quad	l_OBJC_$_INSTANCE_VARIABLES_AddressInfo
	.quad	0
	.quad	l_OBJC_$_PROP_LIST_AddressInfo

	.section	__DATA,__objc_classlist,regular,no_dead_strip
	.p2align	3               ## @"OBJC_LABEL_CLASS_$"
L_OBJC_LABEL_CLASS_$:
	.quad	_OBJC_CLASS_$_ViewController
	.quad	_OBJC_CLASS_$_AddressInfo

	.no_dead_strip	__OBJC_PROTOCOL_$_NSObject
	.no_dead_strip	__OBJC_LABEL_PROTOCOL_$_NSObject
	.no_dead_strip	__OBJC_PROTOCOL_$_UITextFieldDelegate
	.no_dead_strip	__OBJC_LABEL_PROTOCOL_$_UITextFieldDelegate
	.section	__DATA,__objc_imageinfo,regular,no_dead_strip
L_OBJC_IMAGE_INFO:
	.long	0
	.long	96


.subsections_via_symbols
