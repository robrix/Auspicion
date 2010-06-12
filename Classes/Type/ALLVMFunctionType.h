// ALLVMFunctionType.h
// Created by Rob Rix on 2010-06-10
// Copyright 2010 Monochrome Industries

#import "ALLVMType.h"

@interface ALLVMFunctionType : ALLVMType {
	NSDictionary *argumentNames;
}

@property (nonatomic, readonly) ALLVMType *returnType;

@property (nonatomic, readonly) NSArray *argumentTypes;

-(void)declareArgumentNames:(NSArray *)names;
-(NSUInteger)indexForArgumentName:(NSString *)name;

@property (nonatomic, readonly) NSUInteger arity;
@property (nonatomic, readonly, getter=hasVariableArity) BOOL variableArity;

@end
