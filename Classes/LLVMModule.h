// LLVMModule.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import <Foundation/Foundation.h>

@class LLVMContext, LLVMFunction, LLVMType;

@interface LLVMModule : NSObject {
	NSMutableDictionary *typesByName;
}

+(LLVMModule *)moduleWithName:(NSString *)_name inContext:(LLVMContext *)_context;

-(LLVMFunction *)declareExternalFunctionWithName:(NSString *)name type:(LLVMType *)type;

-(LLVMFunction *)functionWithName:(NSString *)name; // returns the named function if it exists
-(LLVMFunction *)functionWithName:(NSString *)name type:(LLVMType *)type; // creates a new function with the given name and type
-(LLVMFunction *)functionWithName:(NSString *)name typeName:(NSString *)typeName; // creates a new function with the given name and type

-(BOOL)verifyWithError:(NSError **)error;

@property (nonatomic, readonly) LLVMContext *context;

-(LLVMType *)typeNamed:(NSString *)name;
-(void)setType:(LLVMType *)type forName:(NSString *)name;

@end
