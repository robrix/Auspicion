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
		case let .Function(params, result):
			var params = params.map { LLVMTypeRef(type: $0, context: context) }
			self = LLVMFunctionType(LLVMTypeRef(type: result, context: context), &params, UInt32(params.count), 0)
		case let .Array(type, count):
			self = LLVMArrayType(LLVMTypeRef(type: type, context: context), UInt32(count))
		default:
			print("unimplemented")
			self = LLVMVoidType()
		}
	}
}


import llvm
