// LLVMBlock.m
// Created by Rob Rix on 2010-01-03
// Copyright 2010 Monochrome Industries

#import "LLVMBlock.h"
#import "LLVMBlock+Protected.h"
#import "LLVMFunction.h"
#import "LLVMValue+Protected.h"

@implementation LLVMBlock

+(id)blockWithBlockRef:(LLVMBasicBlockRef)_blockRef {
	return [[[self alloc] initWithBlockRef: _blockRef] autorelease];
}

-(id)initWithBlockRef:(LLVMBasicBlockRef)_blockRef {
	if(self = [super init]) {
		blockRef = _blockRef;
	}
	return self;
}


@synthesize blockRef;


-(LLVMFunction *)parentFunction {
	return [LLVMFunction valueWithValueRef: LLVMGetBasicBlockParent(self.blockRef)];
}

@end
