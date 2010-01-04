// LLVMConcreteBlock.m
// Created by Rob Rix on 2010-01-03
// Copyright 2010 Monochrome Industries

#import "LLVMConcreteBlock.h"

@implementation LLVMConcreteBlock

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

@end