// LLVMConcreteCompiler.m
// Created by Rob Rix on 2009-12-30
// Copyright 2009 Monochrome Industries

#import "LLVMConcreteContext.h"
#import "LLVMConcreteCompiler.h"
#import "LLVMConcreteModule.h"

@implementation LLVMConcreteCompiler

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


-(id)initWithContext:(LLVMContext *)context {
	if(self = [super init]) {
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

@end