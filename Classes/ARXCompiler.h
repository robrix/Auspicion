// ARXCompiler.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import <Foundation/Foundation.h>

@class ARXContext, ARXFunction, ARXModule;

@interface ARXCompiler : NSObject {
	struct LLVMOpaqueModuleProvider * moduleProviderRef;
	struct LLVMOpaqueExecutionEngine * compilerRef;
}

+(id)compilerWithContext:(ARXContext *)context;

-(void *)compiledFunction:(ARXFunction *)function;

-(void)addModule:(ARXModule *)module;

@end
