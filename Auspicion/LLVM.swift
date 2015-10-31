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
		case let .Product(types):
			var types = types.map { LLVMTypeRef(type: $0, context: context) }
			self = LLVMStructTypeInContext(context, &types, UInt32(types.count), 0)
		}
	}
}


extension LLVMValueRef {
	init(constant: Constant, context: LLVMContextRef) {
		switch constant {
		case let .Boolean(v):
			self = LLVMConstInt(LLVMTypeRef(type: constant.type, context: context), v ? 0 : 1, 0)
		case let .Integer(i):
			self = LLVMConstInt(LLVMTypeRef(type: constant.type, context: context), UInt64(i), 0)
		case let .Real(r):
			self = LLVMConstReal(LLVMTypeRef(type: constant.type, context: context), r)
		}
	}
}


import llvm
