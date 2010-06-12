// ALLVMModule.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "AuspicionLLVM.h"
#import "ALLVMBuilder.h"
#import "ALLVMContext+Protected.h"
#import "ALLVMFunction+Protected.h"
#import "ALLVMFunctionBuilder.h"
#import "ALLVMModule.h"
#import "ALLVMModule+Protected.h"
#import "ALLVMType+Protected.h"
#import "ALLVMValue+Protected.h"

@implementation ALLVMModule

@synthesize moduleRef, moduleProviderRef, builder;

-(id)initWithModuleRef:(LLVMModuleRef)_moduleRef {
	if(self = [super init]) {
		moduleRef = _moduleRef;
		moduleProviderRef = LLVMCreateModuleProviderForExistingModule(moduleRef);
		builder = [[ALLVMBuilder builderWithContext: self.context] retain];
	}
	return self;
}

+(ALLVMModule *)moduleWithModuleRef:(LLVMModuleRef)_moduleRef {
	return [self createUniqueInstanceForReference: _moduleRef initializer: @selector(initWithModuleRef:)];
}

+(ALLVMModule *)moduleWithName:(NSString *)_name inContext:(ALLVMContext *)_context {
	return [self moduleWithModuleRef: LLVMModuleCreateWithNameInContext([_name UTF8String], _context.contextRef)];
}

-(void)dealloc {
	[builder release];
	[super dealloc];
}


-(ALLVMFunction *)externalFunctionWithName:(NSString *)name type:(ALLVMType *)type {
	ALLVMFunction *function = [self functionNamed: name];
	if(!function) {
		function = [ALLVMFunction functionInModule: self withName: name type: type];
		function.linkage = LLVMExternalLinkage;
	}
	return function;
}


-(ALLVMFunction *)functionNamed:(NSString *)name {
	LLVMValueRef functionRef = LLVMGetNamedFunction(self.moduleRef, [name UTF8String]);
	return functionRef ? [ALLVMFunction valueWithValueRef: functionRef] : nil;
}

-(ALLVMFunction *)functionWithName:(NSString *)name type:(ALLVMType *)type {
	ALLVMFunction *function = [ALLVMFunction functionInModule: self withName: name type: type];
	LLVMAppendBasicBlock(function.valueRef, "entry");
	return function;
}

-(ALLVMFunction *)functionWithName:(NSString *)name type:(ALLVMType *)type definition:(ALLVMModuleFunctionDefinitionBlock)definition {
	ALLVMFunction *function = [self functionWithName: name type: type];
	ALLVMFunctionBuilder *functionBuilder = [[ALLVMFunctionBuilder alloc] initWithFunction: function];
	
	definition(functionBuilder);
	
	[functionBuilder release];
	return function;
}

-(ALLVMFunction *)functionWithName:(NSString *)name typeName:(NSString *)typeName {
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


-(ALLVMContext *)context {
	return [ALLVMContext contextWithContextRef: AuspicionLLVMModuleGetContext(self.moduleRef)];
}


-(ALLVMBuilder *)builder {
	return nil;
}


-(ALLVMType *)typeNamed:(NSString *)name {
	NSParameterAssert(name != nil);
	LLVMTypeRef typeRef = LLVMGetTypeByName(self.moduleRef, [name UTF8String]);
	return typeRef ? [ALLVMType typeWithTypeRef: typeRef] : NULL;
}

-(void)setType:(ALLVMType *)type forName:(NSString *)name {
	NSParameterAssert(type != nil);
	NSParameterAssert(name != nil);
	LLVMAddTypeName(self.moduleRef, [name UTF8String], type.typeRef);
}

@end
