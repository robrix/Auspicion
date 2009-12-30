// LLVMConcreteBuilder.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMConcreteBuilder.h"
#import "LLVMConcreteContext.h"
#import "LLVMConcreteFunction.h"
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

-(LLVMValue *)call:(LLVMFunction *)function arguments:(NSArray *)arguments {
	LLVMValueRef argumentRefs[arguments.count];
	NSUInteger i = 0;
	for(LLVMValue *argument in arguments) {
		argumentRefs[i++] = argument.valueRef;
	}
	return [LLVMConcreteValue valueWithValueRef: LLVMBuildCall(builderRef, function.valueRef, argumentRefs, arguments.count, "")];
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