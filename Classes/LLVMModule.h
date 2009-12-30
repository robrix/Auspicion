// LLVMModule.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import <Foundation/Foundation.h>

@class LLVMContext, LLVMFunction, LLVMType;

@interface LLVMModule : NSObject

+(LLVMModule *)moduleWithName:(NSString *)_name inContext:(LLVMContext *)context;

-(LLVMFunction *)declareExternalFunctionWithName:(NSString *)name type:(LLVMType *)type;

-(LLVMFunction *)functionWithName:(NSString *)_name; // returns the named function if it exists
-(LLVMFunction *)functionWithName:(NSString *)_name type:(LLVMType *)type; // creates a new function with the given name and type

-(BOOL)verifyWithError:(NSError **)error;

@end