// LLVMFunctionBuilder.h
// Created by Rob Rix on 2010-05-30
// Copyright 2010 Monochrome Industries

#import <Foundation/Foundation.h>

@class LLVMBuilder, LLVMFunction, LLVMPointerValue, LLVMType, LLVMValue;

@interface LLVMFunctionBuilder : NSObject {
	LLVMFunction *function;
	NSDictionary *argumentNames;
}

-(id)initWithFunction:(LLVMFunction *)function;

@property (nonatomic, readonly) LLVMBuilder *builder;

-(void)declareArgumentNames:(NSArray *)arguments;
-(LLVMValue *)argumentNamed:(NSString *)name;

-(LLVMPointerValue *)allocateVariableOfType:(LLVMType *)type value:(LLVMValue *)value;

-(void)return:(LLVMValue *)value;

@end
