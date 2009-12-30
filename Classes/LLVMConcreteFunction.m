// LLVMConcreteFunction.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMConcreteFunction.h"
#import "LLVMConcreteValue.h"

@implementation LLVMConcreteFunction

@synthesize valueRef=functionRef;

-(LLVMValue *)argumentValueAtIndex:(NSUInteger)index {
	return [LLVMConcreteValue valueWithValueRef: LLVMGetParam(functionRef, index)];
}

@end