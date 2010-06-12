// ARXBlock.m
// Created by Rob Rix on 2010-01-03
// Copyright 2010 Monochrome Industries

#import "ARXBlock.h"
#import "ARXBlock+Protected.h"
#import "ARXFunction.h"
#import "ARXValue+Protected.h"

@implementation ARXBlock

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


-(ARXFunction *)parentFunction {
	return [ARXFunction valueWithValueRef: LLVMGetBasicBlockParent(self.blockRef)];
}

@end
