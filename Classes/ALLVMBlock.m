// ALLVMBlock.m
// Created by Rob Rix on 2010-01-03
// Copyright 2010 Monochrome Industries

#import "ALLVMBlock.h"
#import "ALLVMBlock+Protected.h"
#import "ALLVMFunction.h"
#import "ALLVMValue+Protected.h"

@implementation ALLVMBlock

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


-(ALLVMFunction *)parentFunction {
	return [ALLVMFunction valueWithValueRef: LLVMGetBasicBlockParent(self.blockRef)];
}

@end
