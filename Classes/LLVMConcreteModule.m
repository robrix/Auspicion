// LLVMConcreteModule.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMConcreteContext.h"
#import "LLVMConcreteModule.h"

@implementation LLVMConcreteModule

-(id)initWithName:(NSString *)_name context:(LLVMContext *)_context {
	if(self = [super init]) {
		moduleRef = LLVMModuleCreateWithNameInContext([_name UTF8String], _context.contextRef);
	}
	return self;
}


@synthesize moduleRef;


-(LLVMFunction *)functionWithName:(NSString *)_name {
	return nil;
}

@end