	.section	__TEXT,__text,regular,pure_instructions
	.ios_version_min 9, 0	sdk_version 14, 2
	.p2align	2               ; -- Begin function +[TestCategorySwizzle load]
"+[TestCategorySwizzle load]":          ; @"\01+[TestCategorySwizzle load]"
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #16             ; =16
	.cfi_def_cfa_offset 16
	str	x0, [sp, #8]
	str	x1, [sp]
	add	sp, sp, #16             ; =16
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2               ; -- Begin function -[TestCategorySwizzle testCategorySwizzle]
"-[TestCategorySwizzle testCategorySwizzle]": ; @"\01-[TestCategorySwizzle testCategorySwizzle]"
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48             ; =48
	stp	x29, x30, [sp, #32]     ; 16-byte Folded Spill
	add	x29, sp, #32            ; =32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	str	x1, [sp, #16]
	adrp	x0, l__unnamed_cfstring_@PAGE
	add	x0, x0, l__unnamed_cfstring_@PAGEOFF
	mov	x8, sp
	adrp	x9, "l___FUNCTION__.-[TestCategorySwizzle testCategorySwizzle]"@PAGE
	add	x9, x9, "l___FUNCTION__.-[TestCategorySwizzle testCategorySwizzle]"@PAGEOFF
	str	x9, [x8]
	bl	_NSLog
	ldp	x29, x30, [sp, #32]     ; 16-byte Folded Reload
	add	sp, sp, #48             ; =48
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2               ; -- Begin function +[TestCategorySwizzle testClassMethod]
"+[TestCategorySwizzle testClassMethod]": ; @"\01+[TestCategorySwizzle testClassMethod]"
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #16             ; =16
	.cfi_def_cfa_offset 16
	str	x0, [sp, #8]
	str	x1, [sp]
	add	sp, sp, #16             ; =16
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2               ; -- Begin function +[TestCategorySwizzle(Log) load]
"+[TestCategorySwizzle(Log) load]":     ; @"\01+[TestCategorySwizzle(Log) load]"
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48             ; =48
	stp	x29, x30, [sp, #32]     ; 16-byte Folded Spill
	add	x29, sp, #32            ; =32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	x8, #0
	str	x0, [sp, #8]
	str	x1, [sp]
	adrp	x9, _load.onceToken@PAGE
	add	x9, x9, _load.onceToken@PAGEOFF
	stur	x9, [x29, #-8]
	add	x0, sp, #16             ; =16
	str	x8, [sp, #16]
	adrp	x1, ___block_literal_global@PAGE
	add	x1, x1, ___block_literal_global@PAGEOFF
	bl	_objc_storeStrong
	ldur	x8, [x29, #-8]
	ldr	x8, [x8]
	mov	x9, #-1
	cmp	x8, x9
	b.eq	LBB3_2
; %bb.1:
	ldur	x0, [x29, #-8]
	ldr	x1, [sp, #16]
	bl	_dispatch_once
	b	LBB3_3
LBB3_2:
	; InlineAsm Start
	; InlineAsm End
LBB3_3:
	add	x0, sp, #16             ; =16
	mov	x8, #0
	mov	x1, x8
	bl	_objc_storeStrong
	ldp	x29, x30, [sp, #32]     ; 16-byte Folded Reload
	add	sp, sp, #48             ; =48
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2               ; -- Begin function __32+[TestCategorySwizzle(Log) load]_block_invoke
"___32+[TestCategorySwizzle(Log) load]_block_invoke": ; @"__32+[TestCategorySwizzle(Log) load]_block_invoke"
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #16             ; =16
	.cfi_def_cfa_offset 16
	str	x0, [sp, #8]
	str	x0, [sp]
	add	sp, sp, #16             ; =16
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2               ; -- Begin function -[TestCategorySwizzle(Log) log_testCategorySwizzle]
"-[TestCategorySwizzle(Log) log_testCategorySwizzle]": ; @"\01-[TestCategorySwizzle(Log) log_testCategorySwizzle]"
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48             ; =48
	stp	x29, x30, [sp, #32]     ; 16-byte Folded Spill
	add	x29, sp, #32            ; =32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	str	x1, [sp, #16]
	ldur	x0, [x29, #-8]
	adrp	x8, _OBJC_SELECTOR_REFERENCES_@PAGE
	add	x8, x8, _OBJC_SELECTOR_REFERENCES_@PAGEOFF
	ldr	x1, [x8]
	bl	_objc_msgSend
	adrp	x0, l__unnamed_cfstring_@PAGE
	add	x0, x0, l__unnamed_cfstring_@PAGEOFF
	mov	x8, sp
	adrp	x9, "l___FUNCTION__.-[TestCategorySwizzle(Log) log_testCategorySwizzle]"@PAGE
	add	x9, x9, "l___FUNCTION__.-[TestCategorySwizzle(Log) log_testCategorySwizzle]"@PAGEOFF
	str	x9, [x8]
	bl	_NSLog
	ldp	x29, x30, [sp, #32]     ; 16-byte Folded Reload
	add	sp, sp, #48             ; =48
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2               ; -- Begin function +[TestCategorySwizzle(EventTrack) load]
"+[TestCategorySwizzle(EventTrack) load]": ; @"\01+[TestCategorySwizzle(EventTrack) load]"
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48             ; =48
	stp	x29, x30, [sp, #32]     ; 16-byte Folded Spill
	add	x29, sp, #32            ; =32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	x8, #0
	str	x0, [sp, #8]
	str	x1, [sp]
	adrp	x9, _load.onceToken.6@PAGE
	add	x9, x9, _load.onceToken.6@PAGEOFF
	stur	x9, [x29, #-8]
	add	x0, sp, #16             ; =16
	str	x8, [sp, #16]
	adrp	x1, ___block_literal_global.7@PAGE
	add	x1, x1, ___block_literal_global.7@PAGEOFF
	bl	_objc_storeStrong
	ldur	x8, [x29, #-8]
	ldr	x8, [x8]
	mov	x9, #-1
	cmp	x8, x9
	b.eq	LBB6_2
; %bb.1:
	ldur	x0, [x29, #-8]
	ldr	x1, [sp, #16]
	bl	_dispatch_once
	b	LBB6_3
LBB6_2:
	; InlineAsm Start
	; InlineAsm End
LBB6_3:
	add	x0, sp, #16             ; =16
	mov	x8, #0
	mov	x1, x8
	bl	_objc_storeStrong
	ldp	x29, x30, [sp, #32]     ; 16-byte Folded Reload
	add	sp, sp, #48             ; =48
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2               ; -- Begin function __39+[TestCategorySwizzle(EventTrack) load]_block_invoke
"___39+[TestCategorySwizzle(EventTrack) load]_block_invoke": ; @"__39+[TestCategorySwizzle(EventTrack) load]_block_invoke"
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #16             ; =16
	.cfi_def_cfa_offset 16
	str	x0, [sp, #8]
	str	x0, [sp]
	add	sp, sp, #16             ; =16
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2               ; -- Begin function -[TestCategorySwizzle(EventTrack) track_testCategorySwizzle]
"-[TestCategorySwizzle(EventTrack) track_testCategorySwizzle]": ; @"\01-[TestCategorySwizzle(EventTrack) track_testCategorySwizzle]"
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48             ; =48
	stp	x29, x30, [sp, #32]     ; 16-byte Folded Spill
	add	x29, sp, #32            ; =32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	str	x1, [sp, #16]
	ldur	x0, [x29, #-8]
	adrp	x8, _OBJC_SELECTOR_REFERENCES_.9@PAGE
	add	x8, x8, _OBJC_SELECTOR_REFERENCES_.9@PAGEOFF
	ldr	x1, [x8]
	bl	_objc_msgSend
	adrp	x0, l__unnamed_cfstring_@PAGE
	add	x0, x0, l__unnamed_cfstring_@PAGEOFF
	mov	x8, sp
	adrp	x9, "l___FUNCTION__.-[TestCategorySwizzle(EventTrack) track_testCategorySwizzle]"@PAGE
	add	x9, x9, "l___FUNCTION__.-[TestCategorySwizzle(EventTrack) track_testCategorySwizzle]"@PAGEOFF
	str	x9, [x8]
	bl	_NSLog
	ldp	x29, x30, [sp, #32]     ; 16-byte Folded Reload
	add	sp, sp, #48             ; =48
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2               ; -- Begin function +[TestCategorySwizzle(ClassMethod) load]
"+[TestCategorySwizzle(ClassMethod) load]": ; @"\01+[TestCategorySwizzle(ClassMethod) load]"
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #96             ; =96
	stp	x29, x30, [sp, #80]     ; 16-byte Folded Spill
	add	x29, sp, #80            ; =80
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	x8, #0
	stur	x0, [x29, #-24]
	stur	x1, [x29, #-32]
	add	x9, sp, #8              ; =8
	adrp	x10, __NSConcreteStackBlock@GOTPAGE
	ldr	x10, [x10, __NSConcreteStackBlock@GOTPAGEOFF]
	str	x10, [sp, #8]
	mov	w11, #-1040187392
	str	w11, [sp, #16]
	str	wzr, [sp, #20]
	adrp	x10, "___40+[TestCategorySwizzle(ClassMethod) load]_block_invoke"@PAGE
	add	x10, x10, "___40+[TestCategorySwizzle(ClassMethod) load]_block_invoke"@PAGEOFF
	str	x10, [x9, #16]
	adrp	x10, "___block_descriptor_40_e8__e5_v8?0l"@PAGE
	add	x10, x10, "___block_descriptor_40_e8__e5_v8?0l"@PAGEOFF
	str	x10, [x9, #24]
	ldur	x10, [x29, #-24]
	str	x10, [x9, #32]
	adrp	x10, _load.onceToken.11@PAGE
	add	x10, x10, _load.onceToken.11@PAGEOFF
	stur	x10, [x29, #-8]
	sub	x0, x29, #16            ; =16
	stur	x8, [x29, #-16]
	mov	x1, x9
	bl	_objc_storeStrong
	ldur	x8, [x29, #-8]
	ldr	x8, [x8]
	mov	x9, #-1
	cmp	x8, x9
	b.eq	LBB9_2
; %bb.1:
	ldur	x0, [x29, #-8]
	ldur	x1, [x29, #-16]
	bl	_dispatch_once
	b	LBB9_3
LBB9_2:
	; InlineAsm Start
	; InlineAsm End
LBB9_3:
	sub	x0, x29, #16            ; =16
	mov	x8, #0
	mov	x1, x8
	bl	_objc_storeStrong
	ldp	x29, x30, [sp, #80]     ; 16-byte Folded Reload
	add	sp, sp, #96             ; =96
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2               ; -- Begin function __40+[TestCategorySwizzle(ClassMethod) load]_block_invoke
"___40+[TestCategorySwizzle(ClassMethod) load]_block_invoke": ; @"__40+[TestCategorySwizzle(ClassMethod) load]_block_invoke"
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #144            ; =144
	stp	x29, x30, [sp, #128]    ; 16-byte Folded Spill
	add	x29, sp, #128           ; =128
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	stur	x0, [x29, #-16]
	ldr	x8, [x0, #32]
	adrp	x9, _OBJC_SELECTOR_REFERENCES_.12@PAGE
	add	x9, x9, _OBJC_SELECTOR_REFERENCES_.12@PAGEOFF
	ldr	x1, [x9]
	stur	x0, [x29, #-48]         ; 8-byte Folded Spill
	mov	x0, x8
	stur	x9, [x29, #-56]         ; 8-byte Folded Spill
	bl	_class_getClassMethod
	stur	x0, [x29, #-24]
	ldur	x8, [x29, #-48]         ; 8-byte Folded Reload
	ldr	x0, [x8, #32]
	adrp	x9, _OBJC_SELECTOR_REFERENCES_.14@PAGE
	add	x9, x9, _OBJC_SELECTOR_REFERENCES_.14@PAGEOFF
	ldr	x1, [x9]
	bl	_class_getClassMethod
	stur	x0, [x29, #-32]
	ldur	x8, [x29, #-48]         ; 8-byte Folded Reload
	ldr	x0, [x8, #32]
	bl	_object_getClass
	stur	x0, [x29, #-40]
	ldur	x0, [x29, #-40]
	ldur	x8, [x29, #-56]         ; 8-byte Folded Reload
	ldr	x1, [x8]
	ldur	x9, [x29, #-32]
	str	x0, [sp, #64]           ; 8-byte Folded Spill
	mov	x0, x9
	str	x1, [sp, #56]           ; 8-byte Folded Spill
	bl	_method_getImplementation
	ldur	x8, [x29, #-32]
	str	x0, [sp, #48]           ; 8-byte Folded Spill
	mov	x0, x8
	bl	_method_getTypeEncoding
	ldr	x8, [sp, #64]           ; 8-byte Folded Reload
	str	x0, [sp, #40]           ; 8-byte Folded Spill
	mov	x0, x8
	ldr	x1, [sp, #56]           ; 8-byte Folded Reload
	ldr	x2, [sp, #48]           ; 8-byte Folded Reload
	ldr	x3, [sp, #40]           ; 8-byte Folded Reload
	bl	_class_addMethod
	tbnz	w0, #0, LBB10_1
	b	LBB10_2
LBB10_1:
	ldur	x8, [x29, #-48]         ; 8-byte Folded Reload
	ldr	x0, [x8, #32]
	adrp	x9, _OBJC_SELECTOR_REFERENCES_.14@PAGE
	add	x9, x9, _OBJC_SELECTOR_REFERENCES_.14@PAGEOFF
	ldr	x1, [x9]
	ldur	x9, [x29, #-24]
	str	x0, [sp, #32]           ; 8-byte Folded Spill
	mov	x0, x9
	str	x1, [sp, #24]           ; 8-byte Folded Spill
	bl	_method_getImplementation
	ldur	x8, [x29, #-24]
	str	x0, [sp, #16]           ; 8-byte Folded Spill
	mov	x0, x8
	bl	_method_getTypeEncoding
	ldr	x8, [sp, #32]           ; 8-byte Folded Reload
	str	x0, [sp, #8]            ; 8-byte Folded Spill
	mov	x0, x8
	ldr	x1, [sp, #24]           ; 8-byte Folded Reload
	ldr	x2, [sp, #16]           ; 8-byte Folded Reload
	ldr	x3, [sp, #8]            ; 8-byte Folded Reload
	bl	_class_replaceMethod
	b	LBB10_3
LBB10_2:
	ldur	x0, [x29, #-24]
	ldur	x1, [x29, #-32]
	bl	_method_exchangeImplementations
LBB10_3:
	ldp	x29, x30, [sp, #128]    ; 16-byte Folded Reload
	add	sp, sp, #144            ; =144
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	___copy_helper_block_e8_ ; -- Begin function __copy_helper_block_e8_
	.globl	___copy_helper_block_e8_
	.weak_def_can_be_hidden	___copy_helper_block_e8_
	.p2align	2
___copy_helper_block_e8_:               ; @__copy_helper_block_e8_
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #16             ; =16
	.cfi_def_cfa_offset 16
	str	x0, [sp, #8]
	str	x1, [sp]
	add	sp, sp, #16             ; =16
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	___destroy_helper_block_e8_ ; -- Begin function __destroy_helper_block_e8_
	.globl	___destroy_helper_block_e8_
	.weak_def_can_be_hidden	___destroy_helper_block_e8_
	.p2align	2
___destroy_helper_block_e8_:            ; @__destroy_helper_block_e8_
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #16             ; =16
	.cfi_def_cfa_offset 16
	str	x0, [sp, #8]
	add	sp, sp, #16             ; =16
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2               ; -- Begin function +[TestCategorySwizzle(ClassMethod) class_testClassMethod]
"+[TestCategorySwizzle(ClassMethod) class_testClassMethod]": ; @"\01+[TestCategorySwizzle(ClassMethod) class_testClassMethod]"
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #16             ; =16
	.cfi_def_cfa_offset 16
	str	x0, [sp, #8]
	str	x1, [sp]
	add	sp, sp, #16             ; =16
	ret
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"%s"

	.section	__DATA,__cfstring
	.p2align	3               ; @_unnamed_cfstring_
l__unnamed_cfstring_:
	.quad	___CFConstantStringClassReference
	.long	1992                    ; 0x7c8
	.space	4
	.quad	l_.str
	.quad	2                       ; 0x2

	.section	__TEXT,__cstring,cstring_literals
"l___FUNCTION__.-[TestCategorySwizzle testCategorySwizzle]": ; @"__FUNCTION__.-[TestCategorySwizzle testCategorySwizzle]"
	.asciz	"-[TestCategorySwizzle testCategorySwizzle]"

	.section	__TEXT,__objc_classname,cstring_literals
l_OBJC_CLASS_NAME_:                     ; @OBJC_CLASS_NAME_
	.asciz	"TestCategorySwizzle"

	.section	__TEXT,__objc_methname,cstring_literals
l_OBJC_METH_VAR_NAME_:                  ; @OBJC_METH_VAR_NAME_
	.asciz	"load"

	.section	__TEXT,__objc_methtype,cstring_literals
l_OBJC_METH_VAR_TYPE_:                  ; @OBJC_METH_VAR_TYPE_
	.asciz	"v16@0:8"

	.section	__TEXT,__objc_methname,cstring_literals
l_OBJC_METH_VAR_NAME_.1:                ; @OBJC_METH_VAR_NAME_.1
	.asciz	"testClassMethod"

	.section	__DATA,__objc_const
	.p2align	3               ; @"_OBJC_$_CLASS_METHODS_TestCategorySwizzle"
__OBJC_$_CLASS_METHODS_TestCategorySwizzle:
	.long	24                      ; 0x18
	.long	2                       ; 0x2
	.quad	l_OBJC_METH_VAR_NAME_
	.quad	l_OBJC_METH_VAR_TYPE_
	.quad	"+[TestCategorySwizzle load]"
	.quad	l_OBJC_METH_VAR_NAME_.1
	.quad	l_OBJC_METH_VAR_TYPE_
	.quad	"+[TestCategorySwizzle testClassMethod]"

	.p2align	3               ; @"_OBJC_METACLASS_RO_$_TestCategorySwizzle"
__OBJC_METACLASS_RO_$_TestCategorySwizzle:
	.long	129                     ; 0x81
	.long	40                      ; 0x28
	.long	40                      ; 0x28
	.space	4
	.quad	0
	.quad	l_OBJC_CLASS_NAME_
	.quad	__OBJC_$_CLASS_METHODS_TestCategorySwizzle
	.quad	0
	.quad	0
	.quad	0
	.quad	0

	.section	__DATA,__objc_data
	.globl	_OBJC_METACLASS_$_TestCategorySwizzle ; @"OBJC_METACLASS_$_TestCategorySwizzle"
	.p2align	3
_OBJC_METACLASS_$_TestCategorySwizzle:
	.quad	_OBJC_METACLASS_$_NSObject
	.quad	_OBJC_METACLASS_$_NSObject
	.quad	__objc_empty_cache
	.quad	0
	.quad	__OBJC_METACLASS_RO_$_TestCategorySwizzle

	.section	__TEXT,__objc_methname,cstring_literals
l_OBJC_METH_VAR_NAME_.2:                ; @OBJC_METH_VAR_NAME_.2
	.asciz	"testCategorySwizzle"

	.section	__DATA,__objc_const
	.p2align	3               ; @"_OBJC_$_INSTANCE_METHODS_TestCategorySwizzle"
__OBJC_$_INSTANCE_METHODS_TestCategorySwizzle:
	.long	24                      ; 0x18
	.long	1                       ; 0x1
	.quad	l_OBJC_METH_VAR_NAME_.2
	.quad	l_OBJC_METH_VAR_TYPE_
	.quad	"-[TestCategorySwizzle testCategorySwizzle]"

	.p2align	3               ; @"_OBJC_CLASS_RO_$_TestCategorySwizzle"
__OBJC_CLASS_RO_$_TestCategorySwizzle:
	.long	128                     ; 0x80
	.long	8                       ; 0x8
	.long	8                       ; 0x8
	.space	4
	.quad	0
	.quad	l_OBJC_CLASS_NAME_
	.quad	__OBJC_$_INSTANCE_METHODS_TestCategorySwizzle
	.quad	0
	.quad	0
	.quad	0
	.quad	0

	.section	__DATA,__objc_data
	.globl	_OBJC_CLASS_$_TestCategorySwizzle ; @"OBJC_CLASS_$_TestCategorySwizzle"
	.p2align	3
_OBJC_CLASS_$_TestCategorySwizzle:
	.quad	_OBJC_METACLASS_$_TestCategorySwizzle
	.quad	_OBJC_CLASS_$_NSObject
	.quad	__objc_empty_cache
	.quad	0
	.quad	__OBJC_CLASS_RO_$_TestCategorySwizzle

.zerofill __DATA,__bss,_load.onceToken,8,3 ; @load.onceToken
	.section	__TEXT,__cstring,cstring_literals
l_.str.3:                               ; @.str.3
	.asciz	"v8@?0"

	.private_extern	"___block_descriptor_32_e5_v8?0l" ; @"__block_descriptor_32_e5_v8\01?0l"
	.section	__DATA,__const
	.globl	"___block_descriptor_32_e5_v8?0l"
	.weak_def_can_be_hidden	"___block_descriptor_32_e5_v8?0l"
	.p2align	3
"___block_descriptor_32_e5_v8?0l":
	.quad	0                       ; 0x0
	.quad	32                      ; 0x20
	.quad	l_.str.3
	.quad	0

	.p2align	3               ; @__block_literal_global
___block_literal_global:
	.quad	__NSConcreteGlobalBlock
	.long	1342177280              ; 0x50000000
	.long	0                       ; 0x0
	.quad	"___32+[TestCategorySwizzle(Log) load]_block_invoke"
	.quad	"___block_descriptor_32_e5_v8?0l"

	.section	__TEXT,__objc_methname,cstring_literals
l_OBJC_METH_VAR_NAME_.4:                ; @OBJC_METH_VAR_NAME_.4
	.asciz	"log_testCategorySwizzle"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.p2align	3               ; @OBJC_SELECTOR_REFERENCES_
_OBJC_SELECTOR_REFERENCES_:
	.quad	l_OBJC_METH_VAR_NAME_.4

	.section	__TEXT,__cstring,cstring_literals
"l___FUNCTION__.-[TestCategorySwizzle(Log) log_testCategorySwizzle]": ; @"__FUNCTION__.-[TestCategorySwizzle(Log) log_testCategorySwizzle]"
	.asciz	"-[TestCategorySwizzle(Log) log_testCategorySwizzle]"

	.section	__TEXT,__objc_classname,cstring_literals
l_OBJC_CLASS_NAME_.5:                   ; @OBJC_CLASS_NAME_.5
	.asciz	"Log"

	.section	__DATA,__objc_const
	.p2align	3               ; @"_OBJC_$_CATEGORY_INSTANCE_METHODS_TestCategorySwizzle_$_Log"
__OBJC_$_CATEGORY_INSTANCE_METHODS_TestCategorySwizzle_$_Log:
	.long	24                      ; 0x18
	.long	1                       ; 0x1
	.quad	l_OBJC_METH_VAR_NAME_.4
	.quad	l_OBJC_METH_VAR_TYPE_
	.quad	"-[TestCategorySwizzle(Log) log_testCategorySwizzle]"

	.p2align	3               ; @"_OBJC_$_CATEGORY_CLASS_METHODS_TestCategorySwizzle_$_Log"
__OBJC_$_CATEGORY_CLASS_METHODS_TestCategorySwizzle_$_Log:
	.long	24                      ; 0x18
	.long	1                       ; 0x1
	.quad	l_OBJC_METH_VAR_NAME_
	.quad	l_OBJC_METH_VAR_TYPE_
	.quad	"+[TestCategorySwizzle(Log) load]"

	.p2align	3               ; @"_OBJC_$_CATEGORY_TestCategorySwizzle_$_Log"
__OBJC_$_CATEGORY_TestCategorySwizzle_$_Log:
	.quad	l_OBJC_CLASS_NAME_.5
	.quad	_OBJC_CLASS_$_TestCategorySwizzle
	.quad	__OBJC_$_CATEGORY_INSTANCE_METHODS_TestCategorySwizzle_$_Log
	.quad	__OBJC_$_CATEGORY_CLASS_METHODS_TestCategorySwizzle_$_Log
	.quad	0
	.quad	0
	.quad	0
	.long	64                      ; 0x40
	.space	4

.zerofill __DATA,__bss,_load.onceToken.6,8,3 ; @load.onceToken.6
	.section	__DATA,__const
	.p2align	3               ; @__block_literal_global.7
___block_literal_global.7:
	.quad	__NSConcreteGlobalBlock
	.long	1342177280              ; 0x50000000
	.long	0                       ; 0x0
	.quad	"___39+[TestCategorySwizzle(EventTrack) load]_block_invoke"
	.quad	"___block_descriptor_32_e5_v8?0l"

	.section	__TEXT,__objc_methname,cstring_literals
l_OBJC_METH_VAR_NAME_.8:                ; @OBJC_METH_VAR_NAME_.8
	.asciz	"track_testCategorySwizzle"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.p2align	3               ; @OBJC_SELECTOR_REFERENCES_.9
_OBJC_SELECTOR_REFERENCES_.9:
	.quad	l_OBJC_METH_VAR_NAME_.8

	.section	__TEXT,__cstring,cstring_literals
"l___FUNCTION__.-[TestCategorySwizzle(EventTrack) track_testCategorySwizzle]": ; @"__FUNCTION__.-[TestCategorySwizzle(EventTrack) track_testCategorySwizzle]"
	.asciz	"-[TestCategorySwizzle(EventTrack) track_testCategorySwizzle]"

	.section	__TEXT,__objc_classname,cstring_literals
l_OBJC_CLASS_NAME_.10:                  ; @OBJC_CLASS_NAME_.10
	.asciz	"EventTrack"

	.section	__DATA,__objc_const
	.p2align	3               ; @"_OBJC_$_CATEGORY_INSTANCE_METHODS_TestCategorySwizzle_$_EventTrack"
__OBJC_$_CATEGORY_INSTANCE_METHODS_TestCategorySwizzle_$_EventTrack:
	.long	24                      ; 0x18
	.long	1                       ; 0x1
	.quad	l_OBJC_METH_VAR_NAME_.8
	.quad	l_OBJC_METH_VAR_TYPE_
	.quad	"-[TestCategorySwizzle(EventTrack) track_testCategorySwizzle]"

	.p2align	3               ; @"_OBJC_$_CATEGORY_CLASS_METHODS_TestCategorySwizzle_$_EventTrack"
__OBJC_$_CATEGORY_CLASS_METHODS_TestCategorySwizzle_$_EventTrack:
	.long	24                      ; 0x18
	.long	1                       ; 0x1
	.quad	l_OBJC_METH_VAR_NAME_
	.quad	l_OBJC_METH_VAR_TYPE_
	.quad	"+[TestCategorySwizzle(EventTrack) load]"

	.p2align	3               ; @"_OBJC_$_CATEGORY_TestCategorySwizzle_$_EventTrack"
__OBJC_$_CATEGORY_TestCategorySwizzle_$_EventTrack:
	.quad	l_OBJC_CLASS_NAME_.10
	.quad	_OBJC_CLASS_$_TestCategorySwizzle
	.quad	__OBJC_$_CATEGORY_INSTANCE_METHODS_TestCategorySwizzle_$_EventTrack
	.quad	__OBJC_$_CATEGORY_CLASS_METHODS_TestCategorySwizzle_$_EventTrack
	.quad	0
	.quad	0
	.quad	0
	.long	64                      ; 0x40
	.space	4

.zerofill __DATA,__bss,_load.onceToken.11,8,3 ; @load.onceToken.11
	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.p2align	3               ; @OBJC_SELECTOR_REFERENCES_.12
_OBJC_SELECTOR_REFERENCES_.12:
	.quad	l_OBJC_METH_VAR_NAME_.1

	.section	__TEXT,__objc_methname,cstring_literals
l_OBJC_METH_VAR_NAME_.13:               ; @OBJC_METH_VAR_NAME_.13
	.asciz	"class_testClassMethod"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.p2align	3               ; @OBJC_SELECTOR_REFERENCES_.14
_OBJC_SELECTOR_REFERENCES_.14:
	.quad	l_OBJC_METH_VAR_NAME_.13

	.section	__TEXT,__objc_classname,cstring_literals
l_OBJC_CLASS_NAME_.15:                  ; @OBJC_CLASS_NAME_.15
	.space	1

	.private_extern	"___block_descriptor_40_e8__e5_v8?0l" ; @"__block_descriptor_40_e8__e5_v8\01?0l"
	.section	__DATA,__const
	.globl	"___block_descriptor_40_e8__e5_v8?0l"
	.weak_def_can_be_hidden	"___block_descriptor_40_e8__e5_v8?0l"
	.p2align	3
"___block_descriptor_40_e8__e5_v8?0l":
	.quad	0                       ; 0x0
	.quad	40                      ; 0x28
	.quad	___copy_helper_block_e8_
	.quad	___destroy_helper_block_e8_
	.quad	l_.str.3
	.quad	l_OBJC_CLASS_NAME_.15

	.section	__TEXT,__objc_classname,cstring_literals
l_OBJC_CLASS_NAME_.16:                  ; @OBJC_CLASS_NAME_.16
	.asciz	"ClassMethod"

	.section	__DATA,__objc_const
	.p2align	3               ; @"_OBJC_$_CATEGORY_CLASS_METHODS_TestCategorySwizzle_$_ClassMethod"
__OBJC_$_CATEGORY_CLASS_METHODS_TestCategorySwizzle_$_ClassMethod:
	.long	24                      ; 0x18
	.long	2                       ; 0x2
	.quad	l_OBJC_METH_VAR_NAME_
	.quad	l_OBJC_METH_VAR_TYPE_
	.quad	"+[TestCategorySwizzle(ClassMethod) load]"
	.quad	l_OBJC_METH_VAR_NAME_.13
	.quad	l_OBJC_METH_VAR_TYPE_
	.quad	"+[TestCategorySwizzle(ClassMethod) class_testClassMethod]"

	.p2align	3               ; @"_OBJC_$_CATEGORY_TestCategorySwizzle_$_ClassMethod"
__OBJC_$_CATEGORY_TestCategorySwizzle_$_ClassMethod:
	.quad	l_OBJC_CLASS_NAME_.16
	.quad	_OBJC_CLASS_$_TestCategorySwizzle
	.quad	0
	.quad	__OBJC_$_CATEGORY_CLASS_METHODS_TestCategorySwizzle_$_ClassMethod
	.quad	0
	.quad	0
	.quad	0
	.long	64                      ; 0x40
	.space	4

	.section	__DATA,__objc_classlist,regular,no_dead_strip
	.p2align	3               ; @"OBJC_LABEL_CLASS_$"
l_OBJC_LABEL_CLASS_$:
	.quad	_OBJC_CLASS_$_TestCategorySwizzle

	.section	__DATA,__objc_nlclslist,regular,no_dead_strip
	.p2align	3               ; @"OBJC_LABEL_NONLAZY_CLASS_$"
l_OBJC_LABEL_NONLAZY_CLASS_$:
	.quad	_OBJC_CLASS_$_TestCategorySwizzle

	.section	__DATA,__objc_catlist,regular,no_dead_strip
	.p2align	3               ; @"OBJC_LABEL_CATEGORY_$"
l_OBJC_LABEL_CATEGORY_$:
	.quad	__OBJC_$_CATEGORY_TestCategorySwizzle_$_Log
	.quad	__OBJC_$_CATEGORY_TestCategorySwizzle_$_EventTrack
	.quad	__OBJC_$_CATEGORY_TestCategorySwizzle_$_ClassMethod

	.section	__DATA,__objc_nlcatlist,regular,no_dead_strip
	.p2align	3               ; @"OBJC_LABEL_NONLAZY_CATEGORY_$"
l_OBJC_LABEL_NONLAZY_CATEGORY_$:
	.quad	__OBJC_$_CATEGORY_TestCategorySwizzle_$_Log
	.quad	__OBJC_$_CATEGORY_TestCategorySwizzle_$_EventTrack
	.quad	__OBJC_$_CATEGORY_TestCategorySwizzle_$_ClassMethod

	.section	__DATA,__objc_imageinfo,regular,no_dead_strip
L_OBJC_IMAGE_INFO:
	.long	0
	.long	64

.subsections_via_symbols
