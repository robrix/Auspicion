// LLVMValue.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMValue.h"
#import "AuspicionLLVM.h"

@implementation LLVMValue

-(NSString *)name {
	[self doesNotRecognizeSelector: _cmd];
	return nil;
}


-(LLVMValueRef)valueRef {
	[self doesNotRecognizeSelector: _cmd];
	return NULL;
}


-(NSString *)description {
	char *bytes = AuspicionLLVMPrintValue(self.valueRef);
	NSString *result = [NSString stringWithCString: bytes encoding: NSUTF8StringEncoding];
	free(bytes);
	return result;
}

@end
