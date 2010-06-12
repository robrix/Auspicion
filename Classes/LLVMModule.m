// LLVMModule.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "AuspicionLLVM.h"
#import "LLVMBuilder.h"
#import "LLVMConcreteContext.h"
#import "LLVMConcreteFunction.h"
#import "LLVMConcreteModule.h"
#import "LLVMFunctionBuilder.h"
#import "LLVMModule.h"
#import "LLVMType+Protected.h"

@implementation LLVMModule

+(LLVMModule *)moduleWithName:(NSString *)_name inContext:(LLVMContext *)_context {
	return [[[LLVMConcreteModule alloc] initWithName: _name context: _context] autorelease];
}


-(id)init {
	if(self = [super init]) {
		typesByName = [[NSMutableDictionary alloc] init];
	}
	return self;
}


-(LLVMModuleRef)moduleRef {
	[self doesNotRecognizeSelector: _cmd];
	return NULL;
}

-(LLVMModuleProviderRef)moduleProviderRef {
	[self doesNotRecognizeSelector: _cmd];
	return NULL;
}


-(LLVMFunction *)externalFunctionWithName:(NSString *)name type:(LLVMType *)type {
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

-(LLVMFunction *)functionWithName:(NSString *)name type:(LLVMType *)type definition:(LLVMModuleFunctionDefinitionBlock)definition {
	LLVMFunction *function = [self functionWithName: name type: type];
	LLVMFunctionBuilder *functionBuilder = [[LLVMFunctionBuilder alloc] initWithFunction: function];
	
	definition(functionBuilder);
	
	[functionBuilder release];
	return function;
}

-(LLVMFunction *)functionWithName:(NSString *)name typeName:(NSString *)typeName {
	return [self functionWithName: name type: [self typeNamed: typeName]];
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


-(LLVMContext *)context {
	return [[[LLVMConcreteContext alloc] initWithContextRef: AuspicionLLVMModuleGetContext(self.moduleRef)] autorelease];
}


-(LLVMBuilder *)builder {
	return nil;
}


-(LLVMType *)typeNamed:(NSString *)name {
	return [typesByName objectForKey: name];
}

-(void)setType:(LLVMType *)type forName:(NSString *)name {
	LLVMAddTypeName(self.moduleRef, [name UTF8String], type.typeRef);
	[typesByName setObject: type forKey: name];
}

@end
