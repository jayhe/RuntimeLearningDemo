	.section	__TEXT,__text,regular,pure_instructions
	.ios_version_min 9, 0	sdk_version 14, 2
	.section	__TEXT,__objc_classname,cstring_literals
L_OBJC_CLASS_NAME_:                     ## @OBJC_CLASS_NAME_
	.asciz	"HCInjection"

	.section	__DATA,__objc_const
	.p2align	3               ## @"_OBJC_$_CATEGORY_NSObject_$_HCInjection"
__OBJC_$_CATEGORY_NSObject_$_HCInjection:
	.quad	L_OBJC_CLASS_NAME_
	.quad	_OBJC_CLASS_$_NSObject
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.long	64                      ## 0x40
	.space	4

	.section	__DATA,__objc_catlist,regular,no_dead_strip
	.p2align	3               ## @"OBJC_LABEL_CATEGORY_$"
L_OBJC_LABEL_CATEGORY_$:
	.quad	__OBJC_$_CATEGORY_NSObject_$_HCInjection

	.section	__DATA,__objc_imageinfo,regular,no_dead_strip
L_OBJC_IMAGE_INFO:
	.long	0
	.long	96

.subsections_via_symbols
