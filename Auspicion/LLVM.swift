//  Copyright © 2015 Rob Rix. All rights reserved.

extension LLVMTypeRef {
	init(type: Type, context: LLVMContextRef) {
		switch type {
		case .Void:
			self = LLVMVoidType()
		default:
			print("unimplemented")
			self = LLVMVoidType()
		}
	}
}


import llvm
