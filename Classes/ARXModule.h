// ARXModule.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import <Foundation/Foundation.h>

@class ARXBuilder, ARXContext, ARXFunction, ARXFunctionBuilder, ARXType, ARXValue;

typedef void (^ARXModuleFunctionDefinitionBlock)(ARXFunctionBuilder *);

@interface ARXModule : NSObject {
	struct LLVMOpaqueModule * moduleRef;
	struct LLVMOpaqueModuleProvider * moduleProviderRef;
	ARXBuilder *builder;
}

+(ARXModule *)moduleWithName:(NSString *)_name inContext:(ARXContext *)_context;

-(ARXFunction *)externalFunctionWithName:(NSString *)name type:(ARXType *)type;

-(ARXFunction *)functionNamed:(NSString *)name; // returns the named function if it exists
-(ARXFunction *)functionWithName:(NSString *)name type:(ARXType *)type; // creates a new function with the given name and type
-(ARXFunction *)functionWithName:(NSString *)name type:(ARXType *)type definition:(ARXModuleFunctionDefinitionBlock)definition;

-(BOOL)verifyWithError:(NSError **)error;

@property (nonatomic, readonly) ARXContext *context;
@property (nonatomic, readonly) ARXBuilder *builder;

-(ARXType *)typeNamed:(NSString *)name;
-(void)setType:(ARXType *)type forName:(NSString *)name;

-(ARXValue *)globalNamed:(NSString *)name;
-(void)setGlobal:(ARXValue *)global forName:(NSString *)name;
-(void)initializeGlobal:(ARXValue *)global forName:(NSString *)name;

@end
