//  Copyright © 2015 Rob Rix. All rights reserved.

extension LLVMTypeRef {
	init(type: Type, context: LLVMContextRef) {
		switch type {
		case .Void:
			self = LLVMVoidType()
		case let .Integer(i):
			self = LLVMIntTypeInContext(context, UInt32(i))
		default:
			print("unimplemented")
			self = LLVMVoidType()
		}
	}
}


import llvm
