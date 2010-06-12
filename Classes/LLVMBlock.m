// LLVMBlock.m
// Created by Rob Rix on 2010-01-03
// Copyright 2010 Monochrome Industries

#import "LLVMBlock.h"
#import "LLVMBlock+Protected.h"
#import "LLVMFunction.h"
#import "LLVMValue+Protected.h"

@implementation LLVMBlock

-(id)initWithBlockRef:(LLVMBasicBlockRef)_blockRef {
	if(self = [super init]) {
		blockRef = _blockRef;
	}
	return self;
}

+(id)blockWithBlockRef:(LLVMBasicBlockRef)_blockRef {
	return [self createUniqueInstanceForReference: _blockRef initializer: @selector(initWithBlockRef:)];
}


@synthesize blockRef;


-(LLVMFunction *)parentFunction {
	return [LLVMFunction valueWithValueRef: LLVMGetBasicBlockParent(self.blockRef)];
}

@end
