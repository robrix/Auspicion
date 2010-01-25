// LLVMConcreteModule.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMConcreteContext.h"
#import "LLVMConcreteModule.h"

@implementation LLVMConcreteModule

-(id)initWithName:(NSString *)_name context:(LLVMContext *)_context {
	if(self = [super init]) {
		moduleRef = LLVMModuleCreateWithNameInContext([_name UTF8String], _context.contextRef);
		moduleProviderRef = LLVMCreateModuleProviderForExistingModule(moduleRef);
		context = [_context retain];
	}
	return self;
}

-(void)dealloc {
	[context release];
	[super dealloc];
}


@synthesize moduleRef;

@synthesize moduleProviderRef;

@synthesize context;

@end
