// LLVMBlock.m
// Created by Rob Rix on 2010-01-03
// Copyright 2010 Monochrome Industries

#import "LLVMBlock.h"
#import "LLVMConcreteFunction.h"

@implementation LLVMBlock

-(LLVMBasicBlockRef)blockRef {
	[self doesNotRecognizeSelector: _cmd];
	return NULL;
}

-(LLVMFunction *)parentFunction {
	return [LLVMConcreteFunction functionWithFunctionRef: LLVMGetBasicBlockParent(self.blockRef)];
}

@end
