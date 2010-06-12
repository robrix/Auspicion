// ALLVMCompiler.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "AuspicionLLVM.h"
#import "ALLVMCompiler.h"
#import "ALLVMCompiler+Protected.h"
#import "ALLVMContext.h"
#import "ALLVMFunction.h"
#import "ALLVMModule+Protected.h"
#import "ALLVMValue+Protected.h"

@implementation ALLVMCompiler

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

+(id)compilerWithContext:(ALLVMContext *)context {
	return [[[self alloc] initWithContext: context] autorelease];
}

-(id)initWithContext:(ALLVMContext *)context {
	if(self = [super init]) {
		NSParameterAssert(context != nil);
		
		ALLVMModule *module = [[ALLVMModule moduleWithName: @"com.monochromeindustries.LLVMConcreteCompiler" inContext: context] retain];
		
		char *error = NULL;
		if(LLVMCreateJITCompiler(&compilerRef, module.moduleProviderRef, 2, &error) == 1) {
			NSLog(@"Error creating JIT compiler: %s", error);
			LLVMDisposeMessage(error);
		}
	}
	return self;
}


@synthesize compilerRef;


-(void *)compiledFunction:(ALLVMFunction *)function {
	NSParameterAssert(function != nil);
	return AuspicionLLVMGetPointerToFunction(self.compilerRef, function.valueRef);
}


-(void)addModule:(ALLVMModule *)module {
	LLVMAddModuleProvider(self.compilerRef, module.moduleProviderRef);
}

@end
