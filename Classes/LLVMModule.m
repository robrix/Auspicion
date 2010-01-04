// LLVMModule.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMConcreteFunction.h"
#import "LLVMConcreteModule.h"
#import "LLVMConcreteType.h"
#import "LLVMConcreteValue.h"
#import "LLVMModule.h"

@implementation LLVMModule

+(LLVMModule *)moduleWithName:(NSString *)_name inContext:(LLVMContext *)context {
	return [[[LLVMConcreteModule alloc] initWithName: _name context: context] autorelease];
}


-(LLVMModuleRef)moduleRef {
	[self doesNotRecognizeSelector: _cmd];
	return NULL;
}

-(LLVMModuleProviderRef)moduleProviderRef {
	[self doesNotRecognizeSelector: _cmd];
	return NULL;
}


-(LLVMFunction *)declareExternalFunctionWithName:(NSString *)name type:(LLVMType *)type {
	LLVMFunction *function = [self functionWithName: name];
	if(!function) {
		function = [LLVMFunction functionInModule: self withName: name type: type];
		function.linkage = LLVMExternalLinkage;
	}
	return function;
}


-(LLVMFunction *)functionWithName:(NSString *)name {
	LLVMValueRef functionRef = LLVMGetNamedFunction(self.moduleRef, [name UTF8String]);
	return functionRef ? [LLVMConcreteFunction functionWithFunctionRef: functionRef] : nil;
}

-(LLVMFunction *)functionWithName:(NSString *)name type:(LLVMType *)type {
	LLVMFunction *function = [LLVMFunction functionInModule: self withName: name type: type];
	LLVMAppendBasicBlock(function.functionRef, "entry");
	return function;
}


-(BOOL)verifyWithError:(NSError **)error {
	char *errorMessage = NULL;
	BOOL result = YES;
	if(LLVMVerifyModule(self.moduleRef, LLVMReturnStatusAction, &errorMessage) == 1) {
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