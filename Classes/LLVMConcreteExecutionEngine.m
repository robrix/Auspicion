// LLVMConcreteExecutionEngine.m
// Created by Rob Rix on 2009-12-30
// Copyright 2009 Monochrome Industries

#import "LLVMConcreteExecutionEngine.h"

@implementation LLVMConcreteExecutionEngine

+(void)initialize {
	LLVMLinkInJIT();
	LLVMInitializeNativeTarget();
}

@end