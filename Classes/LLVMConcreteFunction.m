// LLVMConcreteFunction.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMConcreteFunction.h"
#import "LLVMConcreteValue.h"

@implementation LLVMConcreteFunction

@synthesize valueRef=functionRef;

-(id)initWithFunctionRef:(LLVMValueRef)_functionRef {
	if(self = [super init]) {
		functionRef = _functionRef;
	}
	return self;
}


-(LLVMValue *)argumentValueAtIndex:(NSUInteger)index {
	return [LLVMConcreteValue valueWithValueRef: LLVMGetParam(functionRef, index)];
}


-(LLVMFunctionLinkage)linkage {
	return LLVMGetLinkage(functionRef);
}

-(void)setLinkage:(LLVMFunctionLinkage)_linkage {
	LLVMSetLinkage(functionRef, _linkage);
}


-(BOOL)verifyWithError:(NSError **)error {
	BOOL result = YES;
	if(LLVMVerifyFunction(functionRef, LLVMReturnStatusAction) == 1) {
		if(error)
			*error = [NSError errorWithDomain: @"com.monochromeindustries.Auspicion" code: -2 userInfo: nil];
		result = NO;
	}
	return result;
}

@end