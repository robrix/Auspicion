// LLVMConcreteFunction.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMFunction.h"

@interface LLVMFunction ()

@property (nonatomic, readonly) LLVMValueRef functionRef;
@property (nonatomic) LLVMLinkage linkage;

@end


@interface LLVMConcreteFunction : LLVMFunction {
	LLVMValueRef functionRef;
}

+(id)functionWithFunctionRef:(LLVMValueRef)_functionRef;
-(id)initWithFunctionRef:(LLVMValueRef)_functionRef;

@end