// ARXCompiler.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "AuspicionLLVM.h"
#import "ARXCompiler.h"
#import "ARXCompiler+Protected.h"
#import "ARXContext.h"
#import "ARXFunction.h"
#import "ARXModule+Protected.h"
#import "ARXValue+Protected.h"

@implementation ARXCompiler

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

+(id)compilerWithContext:(ARXContext *)context {
	return [[[self alloc] initWithContext: context] autorelease];
}

-(id)initWithContext:(ARXContext *)context {
	if(self = [super init]) {
		NSParameterAssert(context != nil);
		
		ARXModule *module = [[ARXModule moduleWithName: @"com.monochromeindustries.LLVMConcreteCompiler" inContext: context] retain];
		
		char *error = NULL;
		if(LLVMCreateJITCompiler(&compilerRef, module.moduleProviderRef, 2, &error) == 1) {
			NSLog(@"Error creating JIT compiler: %s", error);
			LLVMDisposeMessage(error);
		}
	}
	return self;
}


@synthesize compilerRef;


-(void *)compiledFunction:(ARXFunction *)function {
	NSParameterAssert(function != nil);
	return AuspicionLLVMGetPointerToFunction(self.compilerRef, function.valueRef);
}


-(void)addModule:(ARXModule *)module {
	LLVMAddModuleProvider(self.compilerRef, module.moduleProviderRef);
}

@end
