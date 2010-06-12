// ALLVMFunctionBuilder.h
// Created by Rob Rix on 2010-05-30
// Copyright 2010 Monochrome Industries

#import <Foundation/Foundation.h>

@class ALLVMBuilder, ALLVMFunction, ALLVMPointerValue, ALLVMType, ALLVMValue;

@interface ALLVMFunctionBuilder : NSObject {
	ALLVMFunction *function;
	NSDictionary *argumentNames;
}

-(id)initWithFunction:(ALLVMFunction *)function;

@property (nonatomic, readonly) ALLVMBuilder *builder;

-(ALLVMValue *)argumentNamed:(NSString *)name;

-(ALLVMPointerValue *)allocateVariableOfType:(ALLVMType *)type value:(ALLVMValue *)value;

-(void)return:(ALLVMValue *)value;

@end
