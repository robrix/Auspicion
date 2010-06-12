// ARXFunctionType.h
// Created by Rob Rix on 2010-06-10
// Copyright 2010 Monochrome Industries

#import "ARXType.h"

@interface ARXFunctionType : ARXType {
	NSDictionary *argumentNames;
}

@property (nonatomic, readonly) ARXType *returnType;

@property (nonatomic, readonly) NSArray *argumentTypes;

-(void)declareArgumentNames:(NSArray *)names;
-(NSUInteger)indexForArgumentName:(NSString *)name;

@property (nonatomic, readonly) NSUInteger arity;
@property (nonatomic, readonly, getter=hasVariableArity) BOOL variableArity;

@end
