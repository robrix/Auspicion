// LLVMModule.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMConcreteModule.h"
#import "LLVMModule.h"

@implementation LLVMModule

+(LLVMModule *)moduleWithName:(NSString *)_name inContext:(LLVMContext *)context {
	return [[[LLVMConcreteModule alloc] initWithName: _name context: context] autorelease];
}


-(LLVMFunction *)functionWithName:(NSString *)_name {
	[self doesNotRecognizeSelector: _cmd];
	return nil;
}


-(LLVMModuleRef)moduleRef {
	[self doesNotRecognizeSelector: _cmd];
	return NULL;
}

@end