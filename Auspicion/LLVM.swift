//  Copyright © 2015 Rob Rix. All rights reserved.

extension LLVMTypeRef {
	init(type: Type, context: LLVMContextRef) {
		switch type {
		case .Void:
			self = LLVMVoidType()
		case let .Integer(i):
			self = LLVMIntTypeInContext(context, UInt32(i))
		case .Float:
			self = LLVMFloatTypeInContext(context)
		case .Double:
			self = LLVMDoubleTypeInContext(context)
		default:
			print("unimplemented")
			self = LLVMVoidType()
		}
	}
}


import llvm
