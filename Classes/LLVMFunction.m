// LLVMFunction.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMConcreteFunction.h"
#import "LLVMConcreteModule.h"
#import "LLVMConcreteType.h"
#import "LLVMFunction.h"

@implementation LLVMFunction

+(id)functionInModule:(LLVMModule *)module withName:(NSString *)name type:(LLVMType *)type {
	return [LLVMConcreteFunction functionWithFunctionRef: LLVMAddFunction(module.moduleRef, [name UTF8String], type.typeRef)];
}


-(LLVMValue *)argumentValueAtIndex:(NSUInteger)index {
	[self doesNotRecognizeSelector: _cmd];
	return nil;
}


-(LLVMLinkage)linkage {
	[self doesNotRecognizeSelector: _cmd];
	return 0;
}

-(void)setLinkage:(LLVMLinkage)_linkage {
	[self doesNotRecognizeSelector: _cmd];
}


-(BOOL)verifyWithError:(NSError **)error {
	[self doesNotRecognizeSelector: _cmd];
	return NO;
}

@end