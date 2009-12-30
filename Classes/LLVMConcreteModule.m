// LLVMConcreteModule.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMConcreteContext.h"
#import "LLVMConcreteFunction.h"
#import "LLVMConcreteModule.h"
#import "LLVMConcreteType.h"
#import "LLVMConcreteValue.h"

@implementation LLVMConcreteModule

-(id)initWithName:(NSString *)_name context:(LLVMContext *)_context {
	if(self = [super init]) {
		moduleRef = LLVMModuleCreateWithNameInContext([_name UTF8String], _context.contextRef);
	}
	return self;
}


@synthesize moduleRef;


-(LLVMFunction *)declareExternalFunctionWithName:(NSString *)name type:(LLVMType *)type {
	LLVMFunction *function = [LLVMFunction functionInModule: self withName: name type: type];
	function.linkage = LLVMExternalLinkage;
	return function;
}


-(LLVMFunction *)functionWithName:(NSString *)name {
	return [LLVMConcreteFunction functionWithFunctionRef: LLVMGetNamedFunction(moduleRef, [name UTF8String])];
}

-(LLVMFunction *)functionWithName:(NSString *)name type:(LLVMType *)type {
	LLVMFunction *function = [LLVMFunction functionInModule: self withName: name type: type];
	LLVMAppendBasicBlock(function.valueRef, "entry");
	return function;
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