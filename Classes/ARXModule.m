// ARXModule.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "AuspicionLLVM.h"
#import "ARXBuilder.h"
#import "ARXContext+Protected.h"
#import "ARXFunction+Protected.h"
#import "ARXFunctionBuilder.h"
#import "ARXModule.h"
#import "ARXModule+Protected.h"
#import "ARXPointerValue.h"
#import "ARXType+Protected.h"
#import "ARXValue+Protected.h"

@implementation ARXModule

@synthesize moduleRef, moduleProviderRef, builder;

-(id)initWithModuleRef:(LLVMModuleRef)_moduleRef {
	if(self = [super init]) {
		moduleRef = _moduleRef;
		moduleProviderRef = LLVMCreateModuleProviderForExistingModule(moduleRef);
		builder = [[ARXBuilder builderWithContext: self.context] retain];
	}
	return self;
}

+(ARXModule *)moduleWithModuleRef:(LLVMModuleRef)_moduleRef {
	return [self createUniqueInstanceForReference: _moduleRef initializer: @selector(initWithModuleRef:)];
}

+(ARXModule *)moduleWithName:(NSString *)_name inContext:(ARXContext *)_context {
	return [self moduleWithModuleRef: LLVMModuleCreateWithNameInContext([_name UTF8String], _context.contextRef)];
}

-(void)dealloc {
	[builder release];
	[super dealloc];
}


-(ARXFunction *)externalFunctionWithName:(NSString *)name type:(ARXType *)type {
	ARXFunction *function = [self functionNamed: name];
	if(!function) {
		function = [ARXFunction valueWithValueRef: LLVMAddFunction(self.moduleRef, [name UTF8String], type.typeRef)];
		function.linkage = LLVMExternalLinkage;
	}
	return function;
}


-(ARXFunction *)functionNamed:(NSString *)name {
	LLVMValueRef functionRef = LLVMGetNamedFunction(self.moduleRef, [name UTF8String]);
	return functionRef ? [ARXFunction valueWithValueRef: functionRef] : nil;
}

-(ARXFunction *)functionWithName:(NSString *)name type:(ARXType *)type {
	ARXFunction *function = [ARXFunction valueWithValueRef: LLVMAddFunction(self.moduleRef, [name UTF8String], type.typeRef)];
	LLVMAppendBasicBlock(function.valueRef, "entry");
	return function;
}

-(ARXFunction *)functionWithName:(NSString *)name type:(ARXType *)type definition:(ARXModuleFunctionDefinitionBlock)definition {
	ARXFunction *function = [self functionWithName: name type: type];
	ARXFunctionBuilder *functionBuilder = [[ARXFunctionBuilder alloc] initWithFunction: function];
	
	definition(functionBuilder);
	
	[functionBuilder release];
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


-(ARXContext *)context {
	return [ARXContext contextWithContextRef: AuspicionLLVMModuleGetContext(self.moduleRef)];
}


-(ARXType *)typeNamed:(NSString *)name {
	NSParameterAssert(name != nil);
	LLVMTypeRef typeRef = LLVMGetTypeByName(self.moduleRef, [name UTF8String]);
	return typeRef ? [ARXType typeWithTypeRef: typeRef] : NULL;
}

-(void)setType:(ARXType *)type forName:(NSString *)name {
	NSParameterAssert(type != nil);
	NSParameterAssert(name != nil);
	LLVMAddTypeName(self.moduleRef, [name UTF8String], type.typeRef);
}


-(ARXPointerValue *)globalPointerNamed:(NSString *)name {
	LLVMValueRef pointerRef = LLVMGetNamedGlobal(self.moduleRef, name.UTF8String);
	ARXPointerValue *pointer = nil;
	if(pointerRef) {
		pointer = [ARXPointerValue valueWithValueRef: pointerRef];
	}
	return pointer;
}

-(ARXValue *)globalNamed:(NSString *)name {
	return [self globalPointerNamed: name].value;
}

-(void)setGlobal:(ARXValue *)global forName:(NSString *)name {
	[self globalPointerNamed: name].isGlobal = YES;
	[self globalPointerNamed: name].value = global;
}

-(void)declareGlobalOfType:(ARXType *)type forName:(NSString *)name {
	LLVMValueRef globalRef = LLVMAddGlobal(self.moduleRef, type.typeRef, name.UTF8String);
	LLVMSetInitializer(globalRef, LLVMConstNull(type.typeRef));
	LLVMSetLinkage(globalRef, LLVMPrivateLinkage);
}

@end
