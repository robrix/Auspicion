// LLVMBuilder.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMBuilder.h"
#import "LLVMConcreteBuilder.h"

@implementation LLVMBuilder

+(LLVMBuilder *)builderWithContext:(LLVMContext *)context {
	return [[[LLVMConcreteBuilder alloc] initWithContext: context] autorelease];
}


-(LLVMValue *)return:(LLVMValue *)value {
	[self doesNotRecognizeSelector: _cmd];
	return nil;
}

-(LLVMValue *)call:(LLVMFunction *)function arguments:(NSArray *)arguments {
	[self doesNotRecognizeSelector: _cmd];
	return nil;
}

-(LLVMValue *)select:(LLVMValue *)condition then:(LLVMValue *)thenValue else:(LLVMValue *)elseValue {
	[self doesNotRecognizeSelector: _cmd];
	return nil;
}


-(LLVMValue *)add:(LLVMValue *)left and:(LLVMValue *)right {
	[self doesNotRecognizeSelector: _cmd];
	return nil;
}

-(LLVMValue *)not:(LLVMValue *)value {
	[self doesNotRecognizeSelector: _cmd];
	return nil;
}

@end