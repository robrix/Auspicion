// LLVMConcreteModule.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMBuilder.h"
#import "LLVMConcreteContext.h"
#import "LLVMConcreteModule.h"

@implementation LLVMConcreteModule

-(id)initWithName:(NSString *)_name context:(LLVMContext *)_context {
	return [self initWithModuleRef: LLVMModuleCreateWithNameInContext([_name UTF8String], _context.contextRef)];
}

-(id)initWithModuleRef:(LLVMModuleRef)_moduleRef {
	if(self = [super init]) {
		moduleRef = _moduleRef;
		moduleProviderRef = LLVMCreateModuleProviderForExistingModule(moduleRef);
		builder = [[LLVMBuilder builderWithContext: self.context] retain];
	}
	return self;
}

-(void)dealloc {
	[builder release];
	[super dealloc];
}


@synthesize moduleRef, moduleProviderRef, builder;

@end
