// LLVMConcreteFunction.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMFunction.h"

@interface LLVMFunction ()

@property (nonatomic) LLVMLinkage linkage;

@end


@interface LLVMConcreteFunction : LLVMFunction {
	LLVMValueRef functionRef;
}

-(id)initWithFunctionRef:(LLVMValueRef)_functionRef;

@end