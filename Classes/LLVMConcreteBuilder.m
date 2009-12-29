// LLVMConcreteBuilder.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMConcreteBuilder.h"
#import "LLVMConcreteContext.h"
#import "LLVMConcreteValue.h"

@implementation LLVMConcreteBuilder

-(id)initWithContext:(LLVMContext *)context {
	if(self = [super init]) {
		builderRef = LLVMCreateBuilderInContext(context.contextRef);
	}
	return self;
}


-(LLVMValue *)return:(LLVMValue *)value {
	return [LLVMConcreteValue valueWithValueRef: LLVMBuildRet(builderRef, value.valueRef)];
}

-(LLVMValue *)functionCall:(LLVMFunction *)function arguments:(NSArray *)arguments {
	return nil;
}

-(LLVMValue *)select:(LLVMValue *)condition then:(LLVMValue *)thenValue else:(LLVMValue *)elseValue {
	return nil;
}

@end