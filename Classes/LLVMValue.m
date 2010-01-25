// LLVMValue.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMValue.h"

@implementation LLVMValue

-(NSString *)name {
	[self doesNotRecognizeSelector: _cmd];
	return nil;
}


-(LLVMValueRef)valueRef {
	[self doesNotRecognizeSelector: _cmd];
	return NULL;
}

@end
