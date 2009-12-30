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


-(BOOL)verifyWithError:(NSError **)error {
	char *errorMessage = NULL;
	BOOL result = YES;
	if(LLVMVerifyModule(moduleRef, LLVMReturnStatusAction, &errorMessage) == 1) {
		if(error)
			*error = [NSError errorWithDomain: @"com.monochromeindustries.Auspicion" code: -1 userInfo: [NSDictionary dictionaryWithObjectsAndKeys:
				[NSString stringWithUTF8String:errorMessage], NSLocalizedDescriptionKey,
			nil]];
		LLVMDisposeMessage(errorMessage);
		result = NO;
	}
	return result;
}

@end