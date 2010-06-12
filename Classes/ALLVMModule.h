// ALLVMModule.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import <Foundation/Foundation.h>

@class ALLVMBuilder, ALLVMContext, ALLVMFunction, ALLVMFunctionBuilder, ALLVMType;

typedef void (^ALLVMModuleFunctionDefinitionBlock)(ALLVMFunctionBuilder *);

@interface ALLVMModule : NSObject {
	struct LLVMOpaqueModule * moduleRef;
	struct LLVMOpaqueModuleProvider * moduleProviderRef;
	ALLVMBuilder *builder;
}

+(ALLVMModule *)moduleWithName:(NSString *)_name inContext:(ALLVMContext *)_context;

-(ALLVMFunction *)externalFunctionWithName:(NSString *)name type:(ALLVMType *)type;

-(ALLVMFunction *)functionNamed:(NSString *)name; // returns the named function if it exists
-(ALLVMFunction *)functionWithName:(NSString *)name type:(ALLVMType *)type; // creates a new function with the given name and type
-(ALLVMFunction *)functionWithName:(NSString *)name type:(ALLVMType *)type definition:(ALLVMModuleFunctionDefinitionBlock)definition;
-(ALLVMFunction *)functionWithName:(NSString *)name typeName:(NSString *)typeName; // creates a new function with the given name and type

-(BOOL)verifyWithError:(NSError **)error;

@property (nonatomic, readonly) ALLVMContext *context;
@property (nonatomic, readonly) ALLVMBuilder *builder;

-(ALLVMType *)typeNamed:(NSString *)name;
-(void)setType:(ALLVMType *)type forName:(NSString *)name;

@end
