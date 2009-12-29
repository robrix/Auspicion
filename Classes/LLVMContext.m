// LLVMContext.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMContext.h"
#import "LLVMConcreteContext.h"

@implementation LLVMContext

+(LLVMContext *)sharedContext {
	return [[[LLVMConcreteContext alloc] initWithContextRef: LLVMGetGlobalContext()] autorelease];
}


+(LLVMContext *)context {
	return [[[LLVMConcreteContext alloc] initWithContextRef: LLVMContextCreate()] autorelease];
}


-(LLVMContextRef)contextRef {
	[self doesNotRecognizeSelector: _cmd];
	return NULL;
}

@end