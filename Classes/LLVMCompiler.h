// LLVMCompiler.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import <Foundation/Foundation.h>

@class LLVMContext, LLVMFunction, LLVMModule;

@interface LLVMCompiler : NSObject

+(id)sharedCompiler;
+(id)compilerWithContext:(LLVMContext *)context;

-(void *)compiledFunction:(LLVMFunction *)function;

-(void)addModule:(LLVMModule *)module;

@end
