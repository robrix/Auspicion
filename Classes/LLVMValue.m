// LLVMValue.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMConcreteType.h"
#import "LLVMValue.h"
#import "AuspicionLLVM.h"

@implementation LLVMValue

-(LLVMValueRef)valueRef {
	[self doesNotRecognizeSelector: _cmd];
	return NULL;
}


-(NSString *)name {
	return [NSString stringWithUTF8String: LLVMGetValueName(self.valueRef)];
}

-(void)setName:(NSString *)name {
	LLVMSetValueName(self.valueRef, [name UTF8String]);
}


-(LLVMType *)type {
	return [LLVMConcreteType typeWithTypeRef: LLVMTypeOf(self.valueRef)];
}


-(NSString *)description {
	char *bytes = AuspicionLLVMPrintValue(self.valueRef);
	NSString *result = [NSString stringWithCString: bytes encoding: NSUTF8StringEncoding];
	free(bytes);
	return result;
}

@end
