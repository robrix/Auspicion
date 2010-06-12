// LLVMModule.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "AuspicionLLVM.h"
#import "LLVMBuilder.h"
#import "LLVMContext+Protected.h"
#import "LLVMFunction+Protected.h"
#import "LLVMFunctionBuilder.h"
#import "LLVMModule.h"
#import "LLVMModule+Protected.h"
#import "LLVMType+Protected.h"
#import "LLVMValue+Protected.h"

@implementation LLVMModule

@synthesize moduleRef, moduleProviderRef, builder;

-(id)initWithModuleRef:(LLVMModuleRef)_moduleRef {
	if(self = [super init]) {
		moduleRef = _moduleRef;
		moduleProviderRef = LLVMCreateModuleProviderForExistingModule(moduleRef);
		builder = [[LLVMBuilder builderWithContext: self.context] retain];
	}
	return self;
}

+(LLVMModule *)moduleWithModuleRef:(LLVMModuleRef)_moduleRef {
	return [self createUniqueInstanceForReference: _moduleRef initializer: @selector(initWithModuleRef:)];
}

+(LLVMModule *)moduleWithName:(NSString *)_name inContext:(LLVMContext *)_context {
	return [self moduleWithModuleRef: LLVMModuleCreateWithNameInContext([_name UTF8String], _context.contextRef)];
}

-(void)dealloc {
	[builder release];
	[super dealloc];
}



-(id)init {
	if(self = [super init]) {
		typesByName = [[NSMutableDictionary alloc] init];
	}
	return self;
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
	return functionRef ? [LLVMFunction valueWithValueRef: functionRef] : nil;
}

-(LLVMFunction *)functionWithName:(NSString *)name type:(LLVMType *)type {
	LLVMFunction *function = [LLVMFunction functionInModule: self withName: name type: type];
	LLVMAppendBasicBlock(function.valueRef, "entry");
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
	return [LLVMContext contextWithContextRef: AuspicionLLVMModuleGetContext(self.moduleRef)];
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
