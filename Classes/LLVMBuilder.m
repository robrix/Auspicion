// LLVMBuilder.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMBuilder.h"
#import "LLVMConcreteBlock.h"
#import "LLVMConcreteBuilder.h"
#import "LLVMConcreteContext.h"
#import "LLVMConcreteFunction.h"
#import "LLVMConcreteType.h"
#import "LLVMConcreteValue.h"

@implementation LLVMBuilder

+(LLVMBuilder *)builderWithContext:(LLVMContext *)context {
	return [[[LLVMConcreteBuilder alloc] initWithContext: context] autorelease];
}


-(LLVMBuilderRef)builderRef {
	[self doesNotRecognizeSelector: _cmd];
	return NULL;
}

-(LLVMContext *)context {
	[self doesNotRecognizeSelector: _cmd];
	return nil;
}


-(void)positionAtEndOfFunction:(LLVMFunction *)function {
	NSParameterAssert(function != nil);
	[self positionAtEndOfBlock: function.entryBlock];
}

-(void)positionAtEndOfBlock:(LLVMBlock *)block {
	NSParameterAssert(block != nil);
	LLVMPositionBuilderAtEnd(self.builderRef, block.blockRef);
}


-(LLVMValue *)return:(LLVMValue *)value {
	NSParameterAssert(value != nil);
	return [LLVMConcreteValue valueWithValueRef: LLVMBuildRet(self.builderRef, value.valueRef)];
}


-(LLVMValue *)call:(LLVMFunction *)function arguments:(NSArray *)arguments {
	NSParameterAssert(function != nil);
	LLVMValueRef argumentRefs[arguments.count];
	NSUInteger i = 0;
	for(LLVMValue *argument in arguments) {
		argumentRefs[i++] = argument.valueRef;
	}
	return [LLVMConcreteValue valueWithValueRef: LLVMBuildCall(self.builderRef, function.functionRef, argumentRefs, arguments.count, "")];
}

-(LLVMValue *)call:(LLVMFunction *)function argument:(LLVMValue *)argument {
	return [self call: function arguments: [NSArray arrayWithObject: argument]];
}

-(LLVMValue *)call:(LLVMFunction *)function, ... {
	va_list list;
	NSMutableArray *arguments = [NSMutableArray array];
	va_start(list, function);
	LLVMValue *argument = nil;
	while(argument = va_arg(list, LLVMValue *)) {
		[arguments addObject: argument];
	}
	va_end(list);
	return [self call: function arguments: arguments];
}


-(LLVMValue *)condition:(LLVMValue *)condition then:(LLVMValue *)thenValue else:(LLVMValue *)elseValue {
	NSParameterAssert(condition != nil);
	NSParameterAssert(thenValue != nil);
	NSParameterAssert(elseValue != nil);
	return [LLVMConcreteValue valueWithValueRef: LLVMBuildSelect(self.builderRef, condition.valueRef, thenValue.valueRef, elseValue.valueRef, "")];
}


-(LLVMValue *)add:(LLVMValue *)left, ... {
	va_list list;
	va_start(list, left);
	LLVMValue *right = va_arg(list, LLVMValue *);
	va_end(list);
	NSParameterAssert(left != nil);
	NSParameterAssert(right != nil);
	return [LLVMConcreteValue valueWithValueRef: LLVMBuildAdd(self.builderRef, left.valueRef, right.valueRef, "")];
}

-(LLVMValue *)not:(LLVMValue *)value {
	NSParameterAssert(value != nil);
	return [LLVMConcreteValue valueWithValueRef: LLVMBuildNot(self.builderRef, value.valueRef, "")];
}


-(LLVMValue *)stringPointer:(NSString *)string {
	NSParameterAssert(string != nil);
	return [LLVMConcreteValue valueWithValueRef: LLVMBuildGlobalStringPtr(self.builderRef, [string UTF8String], "")];
}


// -(LLVMValue *)offsetPointer:(LLVMValue *)pointerValue by:(LLVMValue *)offsetValue {
// 	LLVMValueRef offsetValueRefs[] = { offsetValue.valueRef };
// 	return [LLVMConcreteValue valueWithValueRef: LLVMBuildGEP(self.builderRef, pointerValue.valueRef, offsetValueRefs, 1, "")];
// }

-(LLVMValue *)dereference:(LLVMValue *)pointer {
	return [LLVMConcreteValue valueWithValueRef: LLVMBuildGEP(self.builderRef, pointer.valueRef, (LLVMValueRef[]){ /*[self.context constantInteger: 0].valueRef*/ }, 0, "")];
}


-(LLVMValue *)and:(LLVMValue *)left, ... {
	va_list list;
	va_start(list, left);
	LLVMValue *right = va_arg(list, LLVMValue *);
	va_end(list);
	NSParameterAssert(left != nil);
	NSParameterAssert(right != nil);
	return [LLVMConcreteValue valueWithValueRef: LLVMBuildAnd(self.builderRef, left.valueRef, right.valueRef, "")];
}


-(LLVMValue *)unsignedLessOrEqual:(LLVMValue *)left, ... {
	va_list list;
	va_start(list, left);
	LLVMValue *right = va_arg(list, LLVMValue *);
	va_end(list);
	NSParameterAssert(left != nil);
	NSParameterAssert(right != nil);
	return [LLVMConcreteValue valueWithValueRef: LLVMBuildICmp(self.builderRef, LLVMIntULE, left.valueRef, right.valueRef, "")];
}

-(LLVMValue *)equal:(LLVMValue *)left, ... {
	va_list list;
	va_start(list, left);
	LLVMValue *right = va_arg(list, LLVMValue *);
	va_end(list);
	NSParameterAssert(left != nil);
	NSParameterAssert(right != nil);
	return [LLVMConcreteValue valueWithValueRef: LLVMBuildICmp(self.builderRef, LLVMIntEQ, left.valueRef, right.valueRef, "")];
}

-(LLVMValue *)notEqual:(LLVMValue *)left, ... {
	va_list list;
	va_start(list, left);
	LLVMValue *right = va_arg(list, LLVMValue *);
	va_end(list);
	NSParameterAssert(left != nil);
	NSParameterAssert(right != nil);
	return [LLVMConcreteValue valueWithValueRef: LLVMBuildICmp(self.builderRef, LLVMIntNE, left.valueRef, right.valueRef, "")];
}


-(LLVMValue *)allocateLocal:(NSString *)name type:(LLVMType *)type {
	NSParameterAssert(name != nil);
	NSParameterAssert(type != nil);
	return [LLVMConcreteValue valueWithValueRef: LLVMBuildAlloca(self.builderRef, type.typeRef, [name UTF8String]) name: name];
}

-(LLVMValue *)setLocal:(LLVMValue *)local, ... {
	va_list list;
	va_start(list, local);
	LLVMValue *value = va_arg(list, LLVMValue *);
	va_end(list);
	NSParameterAssert(local != nil);
	NSParameterAssert(value != nil);
	return [LLVMConcreteValue valueWithValueRef: LLVMBuildStore(self.builderRef, value.valueRef, local.valueRef)];
}

-(LLVMValue *)getLocal:(LLVMValue *)local {
	return [LLVMConcreteValue valueWithValueRef: LLVMBuildLoad(self.builderRef, local.valueRef, [local.name UTF8String])];
}


-(LLVMValue *)if:(LLVMValue *)condition then:(LLVMBlock *)thenBlock else:(LLVMBlock *)elseBlock {
	return [LLVMConcreteValue valueWithValueRef: LLVMBuildCondBr(self.builderRef, condition.valueRef, thenBlock.blockRef, elseBlock.blockRef)];
}

-(LLVMValue *)jumpToBlock:(LLVMBlock *)block {
	return [LLVMConcreteValue valueWithValueRef: LLVMBuildBr(self.builderRef, block.blockRef)];
}

@end