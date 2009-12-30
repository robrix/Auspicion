// LLVMBuilder.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMBuilder.h"
#import "LLVMConcreteBuilder.h"
#import "LLVMConcreteContext.h"
#import "LLVMConcreteFunction.h"
#import "LLVMConcreteValue.h"

@implementation LLVMBuilder

+(LLVMBuilder *)builderWithContext:(LLVMContext *)context {
	return [[[LLVMConcreteBuilder alloc] initWithContext: context] autorelease];
}


-(void)positionAtEndOfFunction:(LLVMFunction *)function {
	LLVMPositionBuilderAtEnd(self.builderRef, LLVMGetEntryBasicBlock(function.valueRef));
}


-(LLVMBuilderRef)builderRef {
	return NULL;
}


-(LLVMValue *)return:(LLVMValue *)value {
	return [LLVMConcreteValue valueWithValueRef: LLVMBuildRet(self.builderRef, value.valueRef)];
}


-(LLVMValue *)call:(LLVMFunction *)function arguments:(NSArray *)arguments {
	LLVMValueRef argumentRefs[arguments.count];
	NSUInteger i = 0;
	for(LLVMValue *argument in arguments) {
		argumentRefs[i++] = argument.valueRef;
	}
	return [LLVMConcreteValue valueWithValueRef: LLVMBuildCall(self.builderRef, function.valueRef, argumentRefs, arguments.count, "")];
}

-(LLVMValue *)call:(LLVMFunction *)function argument:(LLVMValue *)argument {
	return [self call: function arguments: [NSArray arrayWithObject: argument]];
}


-(LLVMValue *)condition:(LLVMValue *)condition then:(LLVMValue *)thenValue else:(LLVMValue *)elseValue {
	return [LLVMConcreteValue valueWithValueRef: LLVMBuildSelect(self.builderRef, condition.valueRef, thenValue.valueRef, elseValue.valueRef, "")];
}


-(LLVMValue *)add:(LLVMValue *)left to:(LLVMValue *)right {
	return [LLVMConcreteValue valueWithValueRef: LLVMBuildAdd(self.builderRef, left.valueRef, right.valueRef, "")];
}

-(LLVMValue *)not:(LLVMValue *)value {
	return [LLVMConcreteValue valueWithValueRef: LLVMBuildNot(self.builderRef, value.valueRef, "")];
}


-(LLVMValue *)stringPointer:(NSString *)string {
	return [LLVMConcreteValue valueWithValueRef: LLVMBuildGlobalStringPtr(self.builderRef, [string UTF8String], "")];
}


-(LLVMValue *)offsetPointer:(LLVMValue *)pointerValue by:(LLVMValue *)offsetValue {
	LLVMValueRef offsetValueRefs[] = { offsetValue.valueRef };
	return [LLVMConcreteValue valueWithValueRef: LLVMBuildGEP(self.builderRef, pointerValue.valueRef, offsetValueRefs, 1, "")];
}


-(LLVMValue *)valueIsTrue:(LLVMValue *)left andValueIsTrue:(LLVMValue *)right {
	return [LLVMConcreteValue valueWithValueRef: LLVMBuildAnd(self.builderRef, left.valueRef, right.valueRef, "")];
}

-(LLVMValue *)unsignedValue:(LLVMValue *)left isLessThanOrEqualTo:(LLVMValue *)right {
	return [LLVMConcreteValue valueWithValueRef: LLVMBuildICmp(self.builderRef, LLVMIntULE, left.valueRef, right.valueRef, "")];
}

-(LLVMValue *)value:(LLVMValue *)left isEqualTo:(LLVMValue *)right {
	return [LLVMConcreteValue valueWithValueRef: LLVMBuildICmp(self.builderRef, LLVMIntEQ, left.valueRef, right.valueRef, "")];
}

@end