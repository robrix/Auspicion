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
	return [LLVMConcreteValue valueWithValueRef: LLVMBuildSelect(builderRef, condition.valueRef, thenValue.valueRef, elseValue.valueRef, "")];
}


-(LLVMValue *)add:(LLVMValue *)left and:(LLVMValue *)right {
	return [LLVMConcreteValue valueWithValueRef: LLVMBuildAdd(builderRef, left.valueRef, right.valueRef, "")];
}

-(LLVMValue *)not:(LLVMValue *)value {
	return [LLVMConcreteValue valueWithValueRef: LLVMBuildNot(builderRef, value.valueRef, "")];
}

@end