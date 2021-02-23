	.section	__TEXT,__text,regular,pure_instructions
	.ios_version_min 9, 0	sdk_version 14, 2
	.p2align	4, 0x90         ## -- Begin function -[TestViewDidLoadCallStackViewController viewDidLoad]
"-[TestViewDidLoadCallStackViewController viewDidLoad]": ## @"\01-[TestViewDidLoadCallStackViewController viewDidLoad]"
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$160, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, -32(%rbp)
	movq	L_OBJC_CLASSLIST_SUP_REFS_$_(%rip), %rax
	movq	%rax, -24(%rbp)
	movq	_OBJC_SELECTOR_REFERENCES_(%rip), %rsi
	leaq	-32(%rbp), %rdi
	callq	_objc_msgSendSuper2
	movq	_OBJC_CLASSLIST_REFERENCES_$_(%rip), %rax
	movq	_OBJC_SELECTOR_REFERENCES_.2(%rip), %rsi
	movq	%rax, %rdi
	callq	*_objc_msgSend@GOTPCREL(%rip)
	movq	%rax, %rdi
	callq	_objc_retainAutoreleasedReturnValue
	movq	-8(%rbp), %rcx
	movq	_OBJC_SELECTOR_REFERENCES_.4(%rip), %rsi
	movq	%rcx, %rdi
	movq	%rax, -128(%rbp)        ## 8-byte Spill
	callq	*_objc_msgSend@GOTPCREL(%rip)
	movq	%rax, %rdi
	callq	_objc_retainAutoreleasedReturnValue
	movq	_OBJC_SELECTOR_REFERENCES_.6(%rip), %rsi
	movq	%rax, %rcx
	movq	%rcx, %rdi
	movq	-128(%rbp), %rdx        ## 8-byte Reload
	movq	%rax, -136(%rbp)        ## 8-byte Spill
	callq	*_objc_msgSend@GOTPCREL(%rip)
	movq	-136(%rbp), %rax        ## 8-byte Reload
	movq	%rax, %rdi
	callq	*_objc_release@GOTPCREL(%rip)
	movq	-128(%rbp), %rax        ## 8-byte Reload
	movq	%rax, %rdi
	callq	*_objc_release@GOTPCREL(%rip)
	movq	_OBJC_CLASSLIST_REFERENCES_$_.7(%rip), %rax
	movq	_OBJC_SELECTOR_REFERENCES_.9(%rip), %rsi
	movq	%rax, %rdi
	callq	*_objc_msgSend@GOTPCREL(%rip)
	movq	%rax, %rdi
	callq	_objc_retainAutoreleasedReturnValue
	leaq	L__unnamed_cfstring_(%rip), %rcx
	movq	%rax, -40(%rbp)
	movq	%rcx, %rdi
	leaq	-40(%rbp), %rsi
	movb	$0, %al
	callq	_NSLog
	movq	_OBJC_CLASSLIST_REFERENCES_$_.7(%rip), %rcx
	movq	_OBJC_SELECTOR_REFERENCES_.9(%rip), %rsi
	movq	%rcx, %rdi
	callq	*_objc_msgSend@GOTPCREL(%rip)
	movq	%rax, %rdi
	callq	_objc_retainAutoreleasedReturnValue
	leaq	L__unnamed_cfstring_.11(%rip), %rcx
	movq	%rax, -48(%rbp)
	movq	%rcx, %rdi
	leaq	-48(%rbp), %rsi
	movb	$0, %al
	callq	_NSLog
	leaq	L__unnamed_cfstring_.13(%rip), %rcx
	leaq	-40(%rbp), %rdx
	movq	%rdx, -56(%rbp)
	movq	%rcx, %rdi
	leaq	-56(%rbp), %rsi
	movb	$0, %al
	callq	_NSLog
	movq	-56(%rbp), %rdi
	movq	_OBJC_SELECTOR_REFERENCES_.15(%rip), %rsi
	callq	*_objc_msgSend@GOTPCREL(%rip)
	leaq	"___block_descriptor_36_e5_v8?0l"(%rip), %rcx
	leaq	"___53-[TestViewDidLoadCallStackViewController viewDidLoad]_block_invoke"(%rip), %rdx
	movq	__NSConcreteStackBlock@GOTPCREL(%rip), %rsi
	movl	$10, -60(%rbp)
	movq	%rsi, -112(%rbp)
	movl	$-1073741824, -104(%rbp) ## imm = 0xC0000000
	movl	$0, -100(%rbp)
	movq	%rdx, -96(%rbp)
	movq	%rcx, -88(%rbp)
	movl	-60(%rbp), %r8d
	movl	%r8d, -80(%rbp)
	leaq	-112(%rbp), %rcx
	movq	%rcx, %rdi
	callq	_objc_retainBlock
	leaq	___block_literal_global(%rip), %rcx
	movq	%rax, -72(%rbp)
	movq	%rcx, %rdi
	callq	_objc_retainBlock
	movq	%rax, -120(%rbp)
	movq	-72(%rbp), %rax
	movq	%rax, %rdi
	callq	_objc_retainBlock
	leaq	L__unnamed_cfstring_.22(%rip), %rcx
	movq	%rcx, %rdi
	movq	%rax, %rsi
	movq	%rax, -144(%rbp)        ## 8-byte Spill
	movb	$0, %al
	callq	_NSLog
	movq	-144(%rbp), %rcx        ## 8-byte Reload
	movq	%rcx, %rdi
	callq	*_objc_release@GOTPCREL(%rip)
	movq	-120(%rbp), %rcx
	movq	%rcx, %rdi
	callq	_objc_retainBlock
	leaq	L__unnamed_cfstring_.22(%rip), %rcx
	movq	%rcx, %rdi
	movq	%rax, %rsi
	movq	%rax, -152(%rbp)        ## 8-byte Spill
	movb	$0, %al
	callq	_NSLog
	movq	-152(%rbp), %rcx        ## 8-byte Reload
	movq	%rcx, %rdi
	callq	*_objc_release@GOTPCREL(%rip)
	movq	-72(%rbp), %rcx
	movq	%rcx, %rdx
	movq	%rdx, %rdi
	callq	*16(%rcx)
	movq	-120(%rbp), %rcx
	movq	%rcx, %rdx
	movq	%rdx, %rdi
	callq	*16(%rcx)
	leaq	L__unnamed_cfstring_.24(%rip), %rcx
	movq	%rcx, %rdi
	movb	$0, %al
	callq	_NSLog
	xorl	%r8d, %r8d
	movl	%r8d, %esi
	leaq	-120(%rbp), %rcx
	movq	%rcx, %rdi
	callq	_objc_storeStrong
	xorl	%r8d, %r8d
	movl	%r8d, %esi
	leaq	-72(%rbp), %rcx
	movq	%rcx, %rdi
	callq	_objc_storeStrong
	xorl	%r8d, %r8d
	movl	%r8d, %esi
	leaq	-48(%rbp), %rdi
	callq	_objc_storeStrong
	xorl	%r8d, %r8d
	movl	%r8d, %esi
	leaq	-40(%rbp), %rdi
	callq	_objc_storeStrong
	addq	$160, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function __53-[TestViewDidLoadCallStackViewController viewDidLoad]_block_invoke
"___53-[TestViewDidLoadCallStackViewController viewDidLoad]_block_invoke": ## @"__53-[TestViewDidLoadCallStackViewController viewDidLoad]_block_invoke"
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	leaq	L__unnamed_cfstring_.17(%rip), %rax
	movq	%rdi, -8(%rbp)
	movq	%rdi, %rcx
	movq	%rcx, -16(%rbp)
	movl	32(%rdi), %esi
	movq	%rax, %rdi
	movb	$0, %al
	callq	_NSLog
	addq	$16, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function __53-[TestViewDidLoadCallStackViewController viewDidLoad]_block_invoke_2
"___53-[TestViewDidLoadCallStackViewController viewDidLoad]_block_invoke_2": ## @"__53-[TestViewDidLoadCallStackViewController viewDidLoad]_block_invoke_2"
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	leaq	L__unnamed_cfstring_.20(%rip), %rax
	movq	%rdi, -8(%rbp)
	movq	%rdi, -16(%rbp)
	movq	%rax, %rdi
	movb	$0, %al
	callq	_NSLog
	addq	$16, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function -[TestViewDidLoadCallStackViewController dealloc]
"-[TestViewDidLoadCallStackViewController dealloc]": ## @"\01-[TestViewDidLoadCallStackViewController dealloc]"
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	leaq	L__unnamed_cfstring_.26(%rip), %rax
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rax, %rdi
	leaq	"L___FUNCTION__.-[TestViewDidLoadCallStackViewController dealloc]"(%rip), %rsi
	movb	$0, %al
	callq	_NSLog
	movq	-8(%rbp), %rcx
	movq	%rcx, -32(%rbp)
	movq	L_OBJC_CLASSLIST_SUP_REFS_$_(%rip), %rcx
	movq	%rcx, -24(%rbp)
	movq	_OBJC_SELECTOR_REFERENCES_.28(%rip), %rsi
	leaq	-32(%rbp), %rdi
	callq	_objc_msgSendSuper2
	addq	$32, %rsp
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
	subq	$48, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rax
	movq	_OBJC_SELECTOR_REFERENCES_.33(%rip), %rsi
	movq	%rax, %rdi
	callq	*_objc_msgSend@GOTPCREL(%rip)
	movq	%rax, %rdi
	callq	_objc_retainAutoreleasedReturnValue
	leaq	L__unnamed_cfstring_.31(%rip), %rcx
	movq	%rcx, %rdi
	movq	%rax, %rsi
	movq	%rax, -24(%rbp)         ## 8-byte Spill
	movb	$0, %al
	callq	_NSLog
	movq	-24(%rbp), %rcx         ## 8-byte Reload
	movq	%rcx, %rdi
	callq	*_objc_release@GOTPCREL(%rip)
	movq	-8(%rbp), %rcx
	movq	_OBJC_SELECTOR_REFERENCES_.37(%rip), %rsi
	movq	%rcx, %rdi
	callq	*_objc_msgSend@GOTPCREL(%rip)
	movq	%rax, %rdi
	callq	_objc_retainAutoreleasedReturnValue
	leaq	L__unnamed_cfstring_.35(%rip), %rcx
	movq	%rcx, %rdi
	movq	%rax, %rsi
	movq	%rax, -32(%rbp)         ## 8-byte Spill
	movb	$0, %al
	callq	_NSLog
	movq	-32(%rbp), %rcx         ## 8-byte Reload
	movq	%rcx, %rdi
	callq	*_objc_release@GOTPCREL(%rip)
	movq	-8(%rbp), %rcx
	movq	_OBJC_SELECTOR_REFERENCES_.41(%rip), %rsi
	movq	%rcx, %rdi
	callq	*_objc_msgSend@GOTPCREL(%rip)
	movq	%rax, %rdi
	callq	_objc_retainAutoreleasedReturnValue
	leaq	L__unnamed_cfstring_.39(%rip), %rcx
	movq	%rcx, %rdi
	movq	%rax, %rsi
	movq	%rax, -40(%rbp)         ## 8-byte Spill
	movb	$0, %al
	callq	_NSLog
	movq	-40(%rbp), %rcx         ## 8-byte Reload
	movq	%rcx, %rdi
	callq	*_objc_release@GOTPCREL(%rip)
	movq	-8(%rbp), %rcx
	movq	_OBJC_SELECTOR_REFERENCES_.45(%rip), %rsi
	movq	%rcx, %rdi
	callq	*_objc_msgSend@GOTPCREL(%rip)
	movq	%rax, %rdi
	callq	_objc_retainAutoreleasedReturnValue
	leaq	L__unnamed_cfstring_.43(%rip), %rcx
	movq	%rcx, %rdi
	movq	%rax, %rsi
	movq	%rax, -48(%rbp)         ## 8-byte Spill
	movb	$0, %al
	callq	_NSLog
	movq	-48(%rbp), %rcx         ## 8-byte Reload
	movq	%rcx, %rdi
	callq	*_objc_release@GOTPCREL(%rip)
	addq	$48, %rsp
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
	movq	-8(%rbp), %rax
	movq	-24(%rbp), %rcx
	movq	%rax, %rdi
	movq	%rcx, %rdx
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
	movq	-8(%rbp), %rax
	movq	-24(%rbp), %rcx
	movq	%rax, %rdi
	movq	%rcx, %rdx
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
	movq	-8(%rbp), %rax
	movq	-24(%rbp), %rcx
	movq	%rax, %rdi
	movq	%rcx, %rdx
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
	movq	-8(%rbp), %rax
	movq	-24(%rbp), %rcx
	movq	%rax, %rdi
	movq	%rcx, %rdx
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
	movq	-8(%rbp), %rdx
	movq	%rdx, %rsi
	addq	$32, %rsi
	movq	%rsi, %rdi
	movq	%rcx, %rsi
	movq	%rdx, -24(%rbp)         ## 8-byte Spill
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
	.p2align	4, 0x90         ## -- Begin function -[AddressInfo1 logDescription]
"-[AddressInfo1 logDescription]":       ## @"\01-[AddressInfo1 logDescription]"
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
	movq	-8(%rbp), %rax
	movq	_OBJC_SELECTOR_REFERENCES_.33(%rip), %rsi
	movq	%rax, %rdi
	callq	*_objc_msgSend@GOTPCREL(%rip)
	movq	%rax, %rdi
	callq	_objc_retainAutoreleasedReturnValue
	leaq	L__unnamed_cfstring_.31(%rip), %rcx
	movq	%rcx, %rdi
	movq	%rax, %rsi
	movq	%rax, -24(%rbp)         ## 8-byte Spill
	movb	$0, %al
	callq	_NSLog
	movq	-24(%rbp), %rcx         ## 8-byte Reload
	movq	%rcx, %rdi
	callq	*_objc_release@GOTPCREL(%rip)
	addq	$32, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function -[AddressInfo1 addressName]
"-[AddressInfo1 addressName]":          ## @"\01-[AddressInfo1 addressName]"
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	leaq	L__unnamed_cfstring_.69(%rip), %rdi
	popq	%rbp
	jmp	_objc_retainAutoreleaseReturnValue ## TAILCALL
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function -[AddressInfo1 setAddressName:]
"-[AddressInfo1 setAddressName:]":      ## @"\01-[AddressInfo1 setAddressName:]"
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
	movq	-8(%rbp), %rax
	movq	-24(%rbp), %rcx
	movq	%rax, %rdi
	movq	%rcx, %rdx
	movl	$16, %ecx
	callq	_objc_setProperty_nonatomic_copy
	addq	$32, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function -[AddressInfo1 countryCode]
"-[AddressInfo1 countryCode]":          ## @"\01-[AddressInfo1 countryCode]"
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rax
	movl	8(%rax), %eax
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function -[AddressInfo1 setCountryCode:]
"-[AddressInfo1 setCountryCode:]":      ## @"\01-[AddressInfo1 setCountryCode:]"
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	movl	-20(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 8(%rcx)
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function -[AddressInfo1 cityCode]
"-[AddressInfo1 cityCode]":             ## @"\01-[AddressInfo1 cityCode]"
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function -[AddressInfo1 setCityCode:]
"-[AddressInfo1 setCityCode:]":         ## @"\01-[AddressInfo1 setCityCode:]"
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%edx, -20(%rbp)
	movl	-20(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 12(%rcx)
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function -[AddressInfo1 .cxx_destruct]
"-[AddressInfo1 .cxx_destruct]":        ## @"\01-[AddressInfo1 .cxx_destruct]"
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	xorl	%eax, %eax
	movl	%eax, %ecx
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rdx
	addq	$16, %rdx
	movq	%rdx, %rdi
	movq	%rcx, %rsi
	callq	_objc_storeStrong
	addq	$16, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__DATA,__objc_data
	.globl	_OBJC_CLASS_$_TestViewDidLoadCallStackViewController ## @"OBJC_CLASS_$_TestViewDidLoadCallStackViewController"
	.p2align	3
_OBJC_CLASS_$_TestViewDidLoadCallStackViewController:
	.quad	_OBJC_METACLASS_$_TestViewDidLoadCallStackViewController
	.quad	_OBJC_CLASS_$_UIViewController
	.quad	__objc_empty_cache
	.quad	0
	.quad	__OBJC_CLASS_RO_$_TestViewDidLoadCallStackViewController

	.section	__DATA,__objc_superrefs,regular,no_dead_strip
	.p2align	3               ## @"OBJC_CLASSLIST_SUP_REFS_$_"
L_OBJC_CLASSLIST_SUP_REFS_$_:
	.quad	_OBJC_CLASS_$_TestViewDidLoadCallStackViewController

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_:                  ## @OBJC_METH_VAR_NAME_
	.asciz	"viewDidLoad"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.p2align	3               ## @OBJC_SELECTOR_REFERENCES_
_OBJC_SELECTOR_REFERENCES_:
	.quad	L_OBJC_METH_VAR_NAME_

	.section	__DATA,__objc_classrefs,regular,no_dead_strip
	.p2align	3               ## @"OBJC_CLASSLIST_REFERENCES_$_"
_OBJC_CLASSLIST_REFERENCES_$_:
	.quad	_OBJC_CLASS_$_UIColor

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.1:                ## @OBJC_METH_VAR_NAME_.1
	.asciz	"whiteColor"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.p2align	3               ## @OBJC_SELECTOR_REFERENCES_.2
_OBJC_SELECTOR_REFERENCES_.2:
	.quad	L_OBJC_METH_VAR_NAME_.1

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.3:                ## @OBJC_METH_VAR_NAME_.3
	.asciz	"view"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.p2align	3               ## @OBJC_SELECTOR_REFERENCES_.4
_OBJC_SELECTOR_REFERENCES_.4:
	.quad	L_OBJC_METH_VAR_NAME_.3

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.5:                ## @OBJC_METH_VAR_NAME_.5
	.asciz	"setBackgroundColor:"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.p2align	3               ## @OBJC_SELECTOR_REFERENCES_.6
_OBJC_SELECTOR_REFERENCES_.6:
	.quad	L_OBJC_METH_VAR_NAME_.5

	.section	__DATA,__objc_data
	.globl	_OBJC_CLASS_$_AddressInfo1 ## @"OBJC_CLASS_$_AddressInfo1"
	.p2align	3
_OBJC_CLASS_$_AddressInfo1:
	.quad	_OBJC_METACLASS_$_AddressInfo1
	.quad	_OBJC_CLASS_$_NSObject
	.quad	__objc_empty_cache
	.quad	0
	.quad	__OBJC_CLASS_RO_$_AddressInfo1

	.section	__DATA,__objc_classrefs,regular,no_dead_strip
	.p2align	3               ## @"OBJC_CLASSLIST_REFERENCES_$_.7"
_OBJC_CLASSLIST_REFERENCES_$_.7:
	.quad	_OBJC_CLASS_$_AddressInfo1

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.8:                ## @OBJC_METH_VAR_NAME_.8
	.asciz	"class"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.p2align	3               ## @OBJC_SELECTOR_REFERENCES_.9
_OBJC_SELECTOR_REFERENCES_.9:
	.quad	L_OBJC_METH_VAR_NAME_.8

	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"&cls = %p"

	.section	__DATA,__cfstring
	.p2align	3               ## @_unnamed_cfstring_
L__unnamed_cfstring_:
	.quad	___CFConstantStringClassReference
	.long	1992                    ## 0x7c8
	.space	4
	.quad	L_.str
	.quad	9                       ## 0x9

	.section	__TEXT,__cstring,cstring_literals
L_.str.10:                              ## @.str.10
	.asciz	"&cls1 = %p"

	.section	__DATA,__cfstring
	.p2align	3               ## @_unnamed_cfstring_.11
L__unnamed_cfstring_.11:
	.quad	___CFConstantStringClassReference
	.long	1992                    ## 0x7c8
	.space	4
	.quad	L_.str.10
	.quad	10                      ## 0xa

	.section	__TEXT,__cstring,cstring_literals
L_.str.12:                              ## @.str.12
	.asciz	"&obj = %p"

	.section	__DATA,__cfstring
	.p2align	3               ## @_unnamed_cfstring_.13
L__unnamed_cfstring_.13:
	.quad	___CFConstantStringClassReference
	.long	1992                    ## 0x7c8
	.space	4
	.quad	L_.str.12
	.quad	9                       ## 0x9

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.14:               ## @OBJC_METH_VAR_NAME_.14
	.asciz	"logDescription"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.p2align	3               ## @OBJC_SELECTOR_REFERENCES_.15
_OBJC_SELECTOR_REFERENCES_.15:
	.quad	L_OBJC_METH_VAR_NAME_.14

	.section	__TEXT,__cstring,cstring_literals
L_.str.16:                              ## @.str.16
	.asciz	"2222222222%d"

	.section	__DATA,__cfstring
	.p2align	3               ## @_unnamed_cfstring_.17
L__unnamed_cfstring_.17:
	.quad	___CFConstantStringClassReference
	.long	1992                    ## 0x7c8
	.space	4
	.quad	L_.str.16
	.quad	12                      ## 0xc

	.section	__TEXT,__cstring,cstring_literals
L_.str.18:                              ## @.str.18
	.asciz	"v8@?0"

	.section	__TEXT,__objc_classname,cstring_literals
L_OBJC_CLASS_NAME_:                     ## @OBJC_CLASS_NAME_
	.space	1

	.private_extern	"___block_descriptor_36_e5_v8?0l" ## @"__block_descriptor_36_e5_v8\01?0l"
	.section	__DATA,__const
	.globl	"___block_descriptor_36_e5_v8?0l"
	.weak_def_can_be_hidden	"___block_descriptor_36_e5_v8?0l"
	.p2align	3
"___block_descriptor_36_e5_v8?0l":
	.quad	0                       ## 0x0
	.quad	36                      ## 0x24
	.quad	L_.str.18
	.quad	L_OBJC_CLASS_NAME_

	.private_extern	"___block_descriptor_32_e5_v8?0l" ## @"__block_descriptor_32_e5_v8\01?0l"
	.globl	"___block_descriptor_32_e5_v8?0l"
	.weak_def_can_be_hidden	"___block_descriptor_32_e5_v8?0l"
	.p2align	3
"___block_descriptor_32_e5_v8?0l":
	.quad	0                       ## 0x0
	.quad	32                      ## 0x20
	.quad	L_.str.18
	.quad	0

	.p2align	3               ## @__block_literal_global
___block_literal_global:
	.quad	__NSConcreteGlobalBlock
	.long	1342177280              ## 0x50000000
	.long	0                       ## 0x0
	.quad	"___53-[TestViewDidLoadCallStackViewController viewDidLoad]_block_invoke_2"
	.quad	"___block_descriptor_32_e5_v8?0l"

	.section	__TEXT,__cstring,cstring_literals
L_.str.19:                              ## @.str.19
	.asciz	"1111111111"

	.section	__DATA,__cfstring
	.p2align	3               ## @_unnamed_cfstring_.20
L__unnamed_cfstring_.20:
	.quad	___CFConstantStringClassReference
	.long	1992                    ## 0x7c8
	.space	4
	.quad	L_.str.19
	.quad	10                      ## 0xa

	.section	__TEXT,__cstring,cstring_literals
L_.str.21:                              ## @.str.21
	.asciz	"%p"

	.section	__DATA,__cfstring
	.p2align	3               ## @_unnamed_cfstring_.22
L__unnamed_cfstring_.22:
	.quad	___CFConstantStringClassReference
	.long	1992                    ## 0x7c8
	.space	4
	.quad	L_.str.21
	.quad	2                       ## 0x2

	.section	__TEXT,__cstring,cstring_literals
L_.str.23:                              ## @.str.23
	.asciz	"333333333"

	.section	__DATA,__cfstring
	.p2align	3               ## @_unnamed_cfstring_.24
L__unnamed_cfstring_.24:
	.quad	___CFConstantStringClassReference
	.long	1992                    ## 0x7c8
	.space	4
	.quad	L_.str.23
	.quad	9                       ## 0x9

	.section	__TEXT,__cstring,cstring_literals
L_.str.25:                              ## @.str.25
	.asciz	"%s"

	.section	__DATA,__cfstring
	.p2align	3               ## @_unnamed_cfstring_.26
L__unnamed_cfstring_.26:
	.quad	___CFConstantStringClassReference
	.long	1992                    ## 0x7c8
	.space	4
	.quad	L_.str.25
	.quad	2                       ## 0x2

	.section	__TEXT,__cstring,cstring_literals
"L___FUNCTION__.-[TestViewDidLoadCallStackViewController dealloc]": ## @"__FUNCTION__.-[TestViewDidLoadCallStackViewController dealloc]"
	.asciz	"-[TestViewDidLoadCallStackViewController dealloc]"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.27:               ## @OBJC_METH_VAR_NAME_.27
	.asciz	"dealloc"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.p2align	3               ## @OBJC_SELECTOR_REFERENCES_.28
_OBJC_SELECTOR_REFERENCES_.28:
	.quad	L_OBJC_METH_VAR_NAME_.27

	.section	__TEXT,__objc_classname,cstring_literals
L_OBJC_CLASS_NAME_.29:                  ## @OBJC_CLASS_NAME_.29
	.asciz	"TestViewDidLoadCallStackViewController"

	.section	__DATA,__objc_const
	.p2align	3               ## @"_OBJC_METACLASS_RO_$_TestViewDidLoadCallStackViewController"
__OBJC_METACLASS_RO_$_TestViewDidLoadCallStackViewController:
	.long	129                     ## 0x81
	.long	40                      ## 0x28
	.long	40                      ## 0x28
	.space	4
	.quad	0
	.quad	L_OBJC_CLASS_NAME_.29
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0

	.section	__DATA,__objc_data
	.globl	_OBJC_METACLASS_$_TestViewDidLoadCallStackViewController ## @"OBJC_METACLASS_$_TestViewDidLoadCallStackViewController"
	.p2align	3
_OBJC_METACLASS_$_TestViewDidLoadCallStackViewController:
	.quad	_OBJC_METACLASS_$_NSObject
	.quad	_OBJC_METACLASS_$_UIViewController
	.quad	__objc_empty_cache
	.quad	0
	.quad	__OBJC_METACLASS_RO_$_TestViewDidLoadCallStackViewController

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_:                  ## @OBJC_METH_VAR_TYPE_
	.asciz	"v16@0:8"

	.section	__DATA,__objc_const
	.p2align	3               ## @"_OBJC_$_INSTANCE_METHODS_TestViewDidLoadCallStackViewController"
__OBJC_$_INSTANCE_METHODS_TestViewDidLoadCallStackViewController:
	.long	24                      ## 0x18
	.long	2                       ## 0x2
	.quad	L_OBJC_METH_VAR_NAME_
	.quad	L_OBJC_METH_VAR_TYPE_
	.quad	"-[TestViewDidLoadCallStackViewController viewDidLoad]"
	.quad	L_OBJC_METH_VAR_NAME_.27
	.quad	L_OBJC_METH_VAR_TYPE_
	.quad	"-[TestViewDidLoadCallStackViewController dealloc]"

	.p2align	3               ## @"_OBJC_CLASS_RO_$_TestViewDidLoadCallStackViewController"
__OBJC_CLASS_RO_$_TestViewDidLoadCallStackViewController:
	.long	128                     ## 0x80
	.long	8                       ## 0x8
	.long	8                       ## 0x8
	.space	4
	.quad	0
	.quad	L_OBJC_CLASS_NAME_.29
	.quad	__OBJC_$_INSTANCE_METHODS_TestViewDidLoadCallStackViewController
	.quad	0
	.quad	0
	.quad	0
	.quad	0

	.section	__TEXT,__cstring,cstring_literals
L_.str.30:                              ## @.str.30
	.asciz	"self.name = %@"

	.section	__DATA,__cfstring
	.p2align	3               ## @_unnamed_cfstring_.31
L__unnamed_cfstring_.31:
	.quad	___CFConstantStringClassReference
	.long	1992                    ## 0x7c8
	.space	4
	.quad	L_.str.30
	.quad	14                      ## 0xe

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.32:               ## @OBJC_METH_VAR_NAME_.32
	.asciz	"addressName"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.p2align	3               ## @OBJC_SELECTOR_REFERENCES_.33
_OBJC_SELECTOR_REFERENCES_.33:
	.quad	L_OBJC_METH_VAR_NAME_.32

	.section	__TEXT,__cstring,cstring_literals
L_.str.34:                              ## @.str.34
	.asciz	"self.description = %@"

	.section	__DATA,__cfstring
	.p2align	3               ## @_unnamed_cfstring_.35
L__unnamed_cfstring_.35:
	.quad	___CFConstantStringClassReference
	.long	1992                    ## 0x7c8
	.space	4
	.quad	L_.str.34
	.quad	21                      ## 0x15

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.36:               ## @OBJC_METH_VAR_NAME_.36
	.asciz	"description"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.p2align	3               ## @OBJC_SELECTOR_REFERENCES_.37
_OBJC_SELECTOR_REFERENCES_.37:
	.quad	L_OBJC_METH_VAR_NAME_.36

	.section	__TEXT,__cstring,cstring_literals
L_.str.38:                              ## @.str.38
	.asciz	"self.addressNumber = %@"

	.section	__DATA,__cfstring
	.p2align	3               ## @_unnamed_cfstring_.39
L__unnamed_cfstring_.39:
	.quad	___CFConstantStringClassReference
	.long	1992                    ## 0x7c8
	.space	4
	.quad	L_.str.38
	.quad	23                      ## 0x17

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.40:               ## @OBJC_METH_VAR_NAME_.40
	.asciz	"addressNumber"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.p2align	3               ## @OBJC_SELECTOR_REFERENCES_.41
_OBJC_SELECTOR_REFERENCES_.41:
	.quad	L_OBJC_METH_VAR_NAME_.40

	.section	__TEXT,__cstring,cstring_literals
L_.str.42:                              ## @.str.42
	.asciz	"self.addressDesc = %@"

	.section	__DATA,__cfstring
	.p2align	3               ## @_unnamed_cfstring_.43
L__unnamed_cfstring_.43:
	.quad	___CFConstantStringClassReference
	.long	1992                    ## 0x7c8
	.space	4
	.quad	L_.str.42
	.quad	21                      ## 0x15

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.44:               ## @OBJC_METH_VAR_NAME_.44
	.asciz	"addressDesc"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.p2align	3               ## @OBJC_SELECTOR_REFERENCES_.45
_OBJC_SELECTOR_REFERENCES_.45:
	.quad	L_OBJC_METH_VAR_NAME_.44

	.section	__TEXT,__objc_classname,cstring_literals
L_OBJC_CLASS_NAME_.46:                  ## @OBJC_CLASS_NAME_.46
	.asciz	"AddressInfo"

	.section	__DATA,__objc_const
	.p2align	3               ## @"_OBJC_METACLASS_RO_$_AddressInfo"
__OBJC_METACLASS_RO_$_AddressInfo:
	.long	389                     ## 0x185
	.long	40                      ## 0x28
	.long	40                      ## 0x28
	.space	4
	.quad	0
	.quad	L_OBJC_CLASS_NAME_.46
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
	.quad	__OBJC_METACLASS_RO_$_AddressInfo

	.section	__TEXT,__objc_classname,cstring_literals
L_OBJC_CLASS_NAME_.47:                  ## @OBJC_CLASS_NAME_.47
	.asciz	"\004"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_.48:               ## @OBJC_METH_VAR_TYPE_.48
	.asciz	"@16@0:8"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.49:               ## @OBJC_METH_VAR_NAME_.49
	.asciz	"setAddressName:"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_.50:               ## @OBJC_METH_VAR_TYPE_.50
	.asciz	"v24@0:8@16"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.51:               ## @OBJC_METH_VAR_NAME_.51
	.asciz	"setAddressNumber:"

L_OBJC_METH_VAR_NAME_.52:               ## @OBJC_METH_VAR_NAME_.52
	.asciz	"addressId"

L_OBJC_METH_VAR_NAME_.53:               ## @OBJC_METH_VAR_NAME_.53
	.asciz	"setAddressId:"

L_OBJC_METH_VAR_NAME_.54:               ## @OBJC_METH_VAR_NAME_.54
	.asciz	"setAddressDesc:"

L_OBJC_METH_VAR_NAME_.55:               ## @OBJC_METH_VAR_NAME_.55
	.asciz	".cxx_destruct"

	.section	__DATA,__objc_const
	.p2align	3               ## @"_OBJC_$_INSTANCE_METHODS_AddressInfo"
__OBJC_$_INSTANCE_METHODS_AddressInfo:
	.long	24                      ## 0x18
	.long	10                      ## 0xa
	.quad	L_OBJC_METH_VAR_NAME_.14
	.quad	L_OBJC_METH_VAR_TYPE_
	.quad	"-[AddressInfo logDescription]"
	.quad	L_OBJC_METH_VAR_NAME_.32
	.quad	L_OBJC_METH_VAR_TYPE_.48
	.quad	"-[AddressInfo addressName]"
	.quad	L_OBJC_METH_VAR_NAME_.49
	.quad	L_OBJC_METH_VAR_TYPE_.50
	.quad	"-[AddressInfo setAddressName:]"
	.quad	L_OBJC_METH_VAR_NAME_.40
	.quad	L_OBJC_METH_VAR_TYPE_.48
	.quad	"-[AddressInfo addressNumber]"
	.quad	L_OBJC_METH_VAR_NAME_.51
	.quad	L_OBJC_METH_VAR_TYPE_.50
	.quad	"-[AddressInfo setAddressNumber:]"
	.quad	L_OBJC_METH_VAR_NAME_.52
	.quad	L_OBJC_METH_VAR_TYPE_.48
	.quad	"-[AddressInfo addressId]"
	.quad	L_OBJC_METH_VAR_NAME_.53
	.quad	L_OBJC_METH_VAR_TYPE_.50
	.quad	"-[AddressInfo setAddressId:]"
	.quad	L_OBJC_METH_VAR_NAME_.44
	.quad	L_OBJC_METH_VAR_TYPE_.48
	.quad	"-[AddressInfo addressDesc]"
	.quad	L_OBJC_METH_VAR_NAME_.54
	.quad	L_OBJC_METH_VAR_TYPE_.50
	.quad	"-[AddressInfo setAddressDesc:]"
	.quad	L_OBJC_METH_VAR_NAME_.55
	.quad	L_OBJC_METH_VAR_TYPE_
	.quad	"-[AddressInfo .cxx_destruct]"

	.private_extern	_OBJC_IVAR_$_AddressInfo._addressName ## @"OBJC_IVAR_$_AddressInfo._addressName"
	.section	__DATA,__objc_ivar
	.globl	_OBJC_IVAR_$_AddressInfo._addressName
	.p2align	3
_OBJC_IVAR_$_AddressInfo._addressName:
	.quad	8                       ## 0x8

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.56:               ## @OBJC_METH_VAR_NAME_.56
	.asciz	"_addressName"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_.57:               ## @OBJC_METH_VAR_TYPE_.57
	.asciz	"@\"NSString\""

	.private_extern	_OBJC_IVAR_$_AddressInfo._addressNumber ## @"OBJC_IVAR_$_AddressInfo._addressNumber"
	.section	__DATA,__objc_ivar
	.globl	_OBJC_IVAR_$_AddressInfo._addressNumber
	.p2align	3
_OBJC_IVAR_$_AddressInfo._addressNumber:
	.quad	16                      ## 0x10

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.58:               ## @OBJC_METH_VAR_NAME_.58
	.asciz	"_addressNumber"

	.private_extern	_OBJC_IVAR_$_AddressInfo._addressId ## @"OBJC_IVAR_$_AddressInfo._addressId"
	.section	__DATA,__objc_ivar
	.globl	_OBJC_IVAR_$_AddressInfo._addressId
	.p2align	3
_OBJC_IVAR_$_AddressInfo._addressId:
	.quad	24                      ## 0x18

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.59:               ## @OBJC_METH_VAR_NAME_.59
	.asciz	"_addressId"

	.private_extern	_OBJC_IVAR_$_AddressInfo._addressDesc ## @"OBJC_IVAR_$_AddressInfo._addressDesc"
	.section	__DATA,__objc_ivar
	.globl	_OBJC_IVAR_$_AddressInfo._addressDesc
	.p2align	3
_OBJC_IVAR_$_AddressInfo._addressDesc:
	.quad	32                      ## 0x20

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.60:               ## @OBJC_METH_VAR_NAME_.60
	.asciz	"_addressDesc"

	.section	__DATA,__objc_const
	.p2align	3               ## @"_OBJC_$_INSTANCE_VARIABLES_AddressInfo"
__OBJC_$_INSTANCE_VARIABLES_AddressInfo:
	.long	32                      ## 0x20
	.long	4                       ## 0x4
	.quad	_OBJC_IVAR_$_AddressInfo._addressName
	.quad	L_OBJC_METH_VAR_NAME_.56
	.quad	L_OBJC_METH_VAR_TYPE_.57
	.long	3                       ## 0x3
	.long	8                       ## 0x8
	.quad	_OBJC_IVAR_$_AddressInfo._addressNumber
	.quad	L_OBJC_METH_VAR_NAME_.58
	.quad	L_OBJC_METH_VAR_TYPE_.57
	.long	3                       ## 0x3
	.long	8                       ## 0x8
	.quad	_OBJC_IVAR_$_AddressInfo._addressId
	.quad	L_OBJC_METH_VAR_NAME_.59
	.quad	L_OBJC_METH_VAR_TYPE_.57
	.long	3                       ## 0x3
	.long	8                       ## 0x8
	.quad	_OBJC_IVAR_$_AddressInfo._addressDesc
	.quad	L_OBJC_METH_VAR_NAME_.60
	.quad	L_OBJC_METH_VAR_TYPE_.57
	.long	3                       ## 0x3
	.long	8                       ## 0x8

	.section	__TEXT,__cstring,cstring_literals
L_OBJC_PROP_NAME_ATTR_:                 ## @OBJC_PROP_NAME_ATTR_
	.asciz	"addressName"

L_OBJC_PROP_NAME_ATTR_.61:              ## @OBJC_PROP_NAME_ATTR_.61
	.asciz	"T@\"NSString\",C,N,V_addressName"

L_OBJC_PROP_NAME_ATTR_.62:              ## @OBJC_PROP_NAME_ATTR_.62
	.asciz	"addressNumber"

L_OBJC_PROP_NAME_ATTR_.63:              ## @OBJC_PROP_NAME_ATTR_.63
	.asciz	"T@\"NSString\",C,N,V_addressNumber"

L_OBJC_PROP_NAME_ATTR_.64:              ## @OBJC_PROP_NAME_ATTR_.64
	.asciz	"addressId"

L_OBJC_PROP_NAME_ATTR_.65:              ## @OBJC_PROP_NAME_ATTR_.65
	.asciz	"T@\"NSString\",C,N,V_addressId"

L_OBJC_PROP_NAME_ATTR_.66:              ## @OBJC_PROP_NAME_ATTR_.66
	.asciz	"addressDesc"

L_OBJC_PROP_NAME_ATTR_.67:              ## @OBJC_PROP_NAME_ATTR_.67
	.asciz	"T@\"NSString\",C,N,V_addressDesc"

	.section	__DATA,__objc_const
	.p2align	3               ## @"_OBJC_$_PROP_LIST_AddressInfo"
__OBJC_$_PROP_LIST_AddressInfo:
	.long	16                      ## 0x10
	.long	4                       ## 0x4
	.quad	L_OBJC_PROP_NAME_ATTR_
	.quad	L_OBJC_PROP_NAME_ATTR_.61
	.quad	L_OBJC_PROP_NAME_ATTR_.62
	.quad	L_OBJC_PROP_NAME_ATTR_.63
	.quad	L_OBJC_PROP_NAME_ATTR_.64
	.quad	L_OBJC_PROP_NAME_ATTR_.65
	.quad	L_OBJC_PROP_NAME_ATTR_.66
	.quad	L_OBJC_PROP_NAME_ATTR_.67

	.p2align	3               ## @"_OBJC_CLASS_RO_$_AddressInfo"
__OBJC_CLASS_RO_$_AddressInfo:
	.long	388                     ## 0x184
	.long	8                       ## 0x8
	.long	40                      ## 0x28
	.space	4
	.quad	L_OBJC_CLASS_NAME_.47
	.quad	L_OBJC_CLASS_NAME_.46
	.quad	__OBJC_$_INSTANCE_METHODS_AddressInfo
	.quad	0
	.quad	__OBJC_$_INSTANCE_VARIABLES_AddressInfo
	.quad	0
	.quad	__OBJC_$_PROP_LIST_AddressInfo

	.section	__DATA,__objc_data
	.globl	_OBJC_CLASS_$_AddressInfo ## @"OBJC_CLASS_$_AddressInfo"
	.p2align	3
_OBJC_CLASS_$_AddressInfo:
	.quad	_OBJC_METACLASS_$_AddressInfo
	.quad	_OBJC_CLASS_$_NSObject
	.quad	__objc_empty_cache
	.quad	0
	.quad	__OBJC_CLASS_RO_$_AddressInfo

	.section	__TEXT,__cstring,cstring_literals
L_.str.68:                              ## @.str.68
	.asciz	"addressName"

	.section	__DATA,__cfstring
	.p2align	3               ## @_unnamed_cfstring_.69
L__unnamed_cfstring_.69:
	.quad	___CFConstantStringClassReference
	.long	1992                    ## 0x7c8
	.space	4
	.quad	L_.str.68
	.quad	11                      ## 0xb

	.section	__TEXT,__objc_classname,cstring_literals
L_OBJC_CLASS_NAME_.70:                  ## @OBJC_CLASS_NAME_.70
	.asciz	"AddressInfo1"

	.section	__DATA,__objc_const
	.p2align	3               ## @"_OBJC_METACLASS_RO_$_AddressInfo1"
__OBJC_METACLASS_RO_$_AddressInfo1:
	.long	389                     ## 0x185
	.long	40                      ## 0x28
	.long	40                      ## 0x28
	.space	4
	.quad	0
	.quad	L_OBJC_CLASS_NAME_.70
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0

	.section	__DATA,__objc_data
	.globl	_OBJC_METACLASS_$_AddressInfo1 ## @"OBJC_METACLASS_$_AddressInfo1"
	.p2align	3
_OBJC_METACLASS_$_AddressInfo1:
	.quad	_OBJC_METACLASS_$_NSObject
	.quad	_OBJC_METACLASS_$_NSObject
	.quad	__objc_empty_cache
	.quad	0
	.quad	__OBJC_METACLASS_RO_$_AddressInfo1

	.section	__TEXT,__objc_classname,cstring_literals
L_OBJC_CLASS_NAME_.71:                  ## @OBJC_CLASS_NAME_.71
	.asciz	"\021"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.72:               ## @OBJC_METH_VAR_NAME_.72
	.asciz	"countryCode"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_.73:               ## @OBJC_METH_VAR_TYPE_.73
	.asciz	"i16@0:8"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.74:               ## @OBJC_METH_VAR_NAME_.74
	.asciz	"setCountryCode:"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_.75:               ## @OBJC_METH_VAR_TYPE_.75
	.asciz	"v20@0:8i16"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.76:               ## @OBJC_METH_VAR_NAME_.76
	.asciz	"cityCode"

L_OBJC_METH_VAR_NAME_.77:               ## @OBJC_METH_VAR_NAME_.77
	.asciz	"setCityCode:"

	.section	__DATA,__objc_const
	.p2align	3               ## @"_OBJC_$_INSTANCE_METHODS_AddressInfo1"
__OBJC_$_INSTANCE_METHODS_AddressInfo1:
	.long	24                      ## 0x18
	.long	8                       ## 0x8
	.quad	L_OBJC_METH_VAR_NAME_.14
	.quad	L_OBJC_METH_VAR_TYPE_
	.quad	"-[AddressInfo1 logDescription]"
	.quad	L_OBJC_METH_VAR_NAME_.32
	.quad	L_OBJC_METH_VAR_TYPE_.48
	.quad	"-[AddressInfo1 addressName]"
	.quad	L_OBJC_METH_VAR_NAME_.49
	.quad	L_OBJC_METH_VAR_TYPE_.50
	.quad	"-[AddressInfo1 setAddressName:]"
	.quad	L_OBJC_METH_VAR_NAME_.72
	.quad	L_OBJC_METH_VAR_TYPE_.73
	.quad	"-[AddressInfo1 countryCode]"
	.quad	L_OBJC_METH_VAR_NAME_.74
	.quad	L_OBJC_METH_VAR_TYPE_.75
	.quad	"-[AddressInfo1 setCountryCode:]"
	.quad	L_OBJC_METH_VAR_NAME_.76
	.quad	L_OBJC_METH_VAR_TYPE_.73
	.quad	"-[AddressInfo1 cityCode]"
	.quad	L_OBJC_METH_VAR_NAME_.77
	.quad	L_OBJC_METH_VAR_TYPE_.75
	.quad	"-[AddressInfo1 setCityCode:]"
	.quad	L_OBJC_METH_VAR_NAME_.55
	.quad	L_OBJC_METH_VAR_TYPE_
	.quad	"-[AddressInfo1 .cxx_destruct]"

	.private_extern	_OBJC_IVAR_$_AddressInfo1._countryCode ## @"OBJC_IVAR_$_AddressInfo1._countryCode"
	.section	__DATA,__objc_ivar
	.globl	_OBJC_IVAR_$_AddressInfo1._countryCode
	.p2align	3
_OBJC_IVAR_$_AddressInfo1._countryCode:
	.quad	8                       ## 0x8

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.78:               ## @OBJC_METH_VAR_NAME_.78
	.asciz	"_countryCode"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_.79:               ## @OBJC_METH_VAR_TYPE_.79
	.asciz	"i"

	.private_extern	_OBJC_IVAR_$_AddressInfo1._cityCode ## @"OBJC_IVAR_$_AddressInfo1._cityCode"
	.section	__DATA,__objc_ivar
	.globl	_OBJC_IVAR_$_AddressInfo1._cityCode
	.p2align	3
_OBJC_IVAR_$_AddressInfo1._cityCode:
	.quad	12                      ## 0xc

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.80:               ## @OBJC_METH_VAR_NAME_.80
	.asciz	"_cityCode"

	.private_extern	_OBJC_IVAR_$_AddressInfo1._addressName ## @"OBJC_IVAR_$_AddressInfo1._addressName"
	.section	__DATA,__objc_ivar
	.globl	_OBJC_IVAR_$_AddressInfo1._addressName
	.p2align	3
_OBJC_IVAR_$_AddressInfo1._addressName:
	.quad	16                      ## 0x10

	.section	__DATA,__objc_const
	.p2align	3               ## @"_OBJC_$_INSTANCE_VARIABLES_AddressInfo1"
__OBJC_$_INSTANCE_VARIABLES_AddressInfo1:
	.long	32                      ## 0x20
	.long	3                       ## 0x3
	.quad	_OBJC_IVAR_$_AddressInfo1._countryCode
	.quad	L_OBJC_METH_VAR_NAME_.78
	.quad	L_OBJC_METH_VAR_TYPE_.79
	.long	2                       ## 0x2
	.long	4                       ## 0x4
	.quad	_OBJC_IVAR_$_AddressInfo1._cityCode
	.quad	L_OBJC_METH_VAR_NAME_.80
	.quad	L_OBJC_METH_VAR_TYPE_.79
	.long	2                       ## 0x2
	.long	4                       ## 0x4
	.quad	_OBJC_IVAR_$_AddressInfo1._addressName
	.quad	L_OBJC_METH_VAR_NAME_.56
	.quad	L_OBJC_METH_VAR_TYPE_.57
	.long	3                       ## 0x3
	.long	8                       ## 0x8

	.section	__TEXT,__cstring,cstring_literals
L_OBJC_PROP_NAME_ATTR_.81:              ## @OBJC_PROP_NAME_ATTR_.81
	.asciz	"countryCode"

L_OBJC_PROP_NAME_ATTR_.82:              ## @OBJC_PROP_NAME_ATTR_.82
	.asciz	"Ti,N,V_countryCode"

L_OBJC_PROP_NAME_ATTR_.83:              ## @OBJC_PROP_NAME_ATTR_.83
	.asciz	"cityCode"

L_OBJC_PROP_NAME_ATTR_.84:              ## @OBJC_PROP_NAME_ATTR_.84
	.asciz	"Ti,N,V_cityCode"

	.section	__DATA,__objc_const
	.p2align	3               ## @"_OBJC_$_PROP_LIST_AddressInfo1"
__OBJC_$_PROP_LIST_AddressInfo1:
	.long	16                      ## 0x10
	.long	3                       ## 0x3
	.quad	L_OBJC_PROP_NAME_ATTR_
	.quad	L_OBJC_PROP_NAME_ATTR_.61
	.quad	L_OBJC_PROP_NAME_ATTR_.81
	.quad	L_OBJC_PROP_NAME_ATTR_.82
	.quad	L_OBJC_PROP_NAME_ATTR_.83
	.quad	L_OBJC_PROP_NAME_ATTR_.84

	.p2align	3               ## @"_OBJC_CLASS_RO_$_AddressInfo1"
__OBJC_CLASS_RO_$_AddressInfo1:
	.long	388                     ## 0x184
	.long	8                       ## 0x8
	.long	24                      ## 0x18
	.space	4
	.quad	L_OBJC_CLASS_NAME_.71
	.quad	L_OBJC_CLASS_NAME_.70
	.quad	__OBJC_$_INSTANCE_METHODS_AddressInfo1
	.quad	0
	.quad	__OBJC_$_INSTANCE_VARIABLES_AddressInfo1
	.quad	0
	.quad	__OBJC_$_PROP_LIST_AddressInfo1

	.section	__DATA,__objc_classlist,regular,no_dead_strip
	.p2align	3               ## @"OBJC_LABEL_CLASS_$"
L_OBJC_LABEL_CLASS_$:
	.quad	_OBJC_CLASS_$_TestViewDidLoadCallStackViewController
	.quad	_OBJC_CLASS_$_AddressInfo
	.quad	_OBJC_CLASS_$_AddressInfo1

	.section	__DATA,__objc_imageinfo,regular,no_dead_strip
L_OBJC_IMAGE_INFO:
	.long	0
	.long	96

.subsections_via_symbols
