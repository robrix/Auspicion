// ALLVMCompiler.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import <Foundation/Foundation.h>

@class ALLVMContext, ALLVMFunction, ALLVMModule;

@interface ALLVMCompiler : NSObject {
	struct LLVMOpaqueModuleProvider * moduleProviderRef;
	struct LLVMOpaqueExecutionEngine * compilerRef;
}

+(id)compilerWithContext:(ALLVMContext *)context;

-(void *)compiledFunction:(ALLVMFunction *)function;

-(void)addModule:(ALLVMModule *)module;

@end
