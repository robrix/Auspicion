// LLVMCompiler.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "AuspicionLLVM.h"
#import "LLVMCompiler.h"
#import "LLVMCompiler+Protected.h"
#import "LLVMContext.h"
#import "LLVMFunction.h"
#import "LLVMModule+Protected.h"
#import "LLVMValue+Protected.h"

@implementation LLVMCompiler

+(void)initialize {
	LLVMLinkInJIT();
	LLVMInitializeNativeTarget();
	
	// static void *functions[] = {
	// 	LLVMAddTargetData,
	// 	LLVMAddCFGSimplificationPass,
	// 	LLVMAddPromoteMemoryToRegisterPass,
	// 	LLVMGetCompilerTargetData,
	// 	LLVMCreateJITCompiler,
	// 	LLVMAddInstructionCombiningPass,
	// 	LLVMAddGVNPass,
	// 	LLVMAddConstantPropagationPass
	// };
}

+(id)compilerWithContext:(LLVMContext *)context {
	return [[[self alloc] initWithContext: context] autorelease];
}

-(id)initWithContext:(LLVMContext *)context {
	if(self = [super init]) {
		NSParameterAssert(context != nil);
		
		LLVMModule *module = [[LLVMModule moduleWithName: @"com.monochromeindustries.LLVMConcreteCompiler" inContext: context] retain];
		
		char *error = NULL;
		if(LLVMCreateJITCompiler(&compilerRef, module.moduleProviderRef, 2, &error) == 1) {
			NSLog(@"Error creating JIT compiler: %s", error);
			LLVMDisposeMessage(error);
		}
	}
	return self;
}


@synthesize compilerRef;


-(void *)compiledFunction:(LLVMFunction *)function {
	NSParameterAssert(function != nil);
	return AuspicionLLVMGetPointerToFunction(self.compilerRef, function.valueRef);
}


-(void)addModule:(LLVMModule *)module {
	LLVMAddModuleProvider(self.compilerRef, module.moduleProviderRef);
}

@end
