// LLVMBuilder.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMBlock+Protected.h"
#import "LLVMBooleanValue.h"
#import "LLVMBuilder.h"
#import "LLVMBuilder+Protected.h"
#import "LLVMConcreteContext.h"
#import "LLVMFunction.h"
#import "LLVMType+Protected.h"
#import "LLVMValue+Protected.h"

@implementation LLVMBuilder

+(LLVMBuilder *)builderWithContext:(LLVMContext *)context {
	return [[[LLVMBuilder alloc] initWithContext: context] autorelease];
}

-(id)initWithContext:(LLVMContext *)_context {
	if(self = [super init]) {
		builderRef = LLVMCreateBuilderInContext(_context.contextRef);
		context = [_context retain];
	}
	return self;
}


@synthesize builderRef, context;


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
	return [LLVMValue valueWithValueRef: LLVMBuildRet(self.builderRef, value.valueRef)];
}


-(LLVMValue *)call:(LLVMValue *)function arguments:(NSArray *)arguments {
	NSParameterAssert(function != nil);
	LLVMValueRef argumentRefs[arguments.count];
	NSUInteger i = 0;
	for(LLVMValue *argument in arguments) {
		argumentRefs[i++] = argument.valueRef;
	}
	return [LLVMValue valueWithValueRef: LLVMBuildCall(self.builderRef, function.valueRef, argumentRefs, arguments.count, "")];
}

-(LLVMValue *)call:(LLVMValue *)function argument:(LLVMValue *)argument {
	return [self call: function arguments: [NSArray arrayWithObject: argument]];
}

-(LLVMValue *)call:(LLVMValue *)function, ... {
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
	return [LLVMValue valueWithValueRef: LLVMBuildSelect(self.builderRef, condition.valueRef, thenValue.valueRef, elseValue.valueRef, "")];
}


-(LLVMValue *)add:(LLVMValue *)left, ... {
	va_list list;
	va_start(list, left);
	LLVMValue *right = va_arg(list, LLVMValue *);
	va_end(list);
	NSParameterAssert(left != nil);
	NSParameterAssert(right != nil);
	return [LLVMValue valueWithValueRef: LLVMBuildAdd(self.builderRef, left.valueRef, right.valueRef, "")];
}

-(LLVMValue *)subtract:(LLVMValue *)left, ... {
	va_list list;
	va_start(list, left);
	LLVMValue *right = va_arg(list, LLVMValue *);
	va_end(list);
	NSParameterAssert(left != nil);
	NSParameterAssert(right != nil);
	return [LLVMValue valueWithValueRef: LLVMBuildSub(self.builderRef, left.valueRef, right.valueRef, "")];
}

-(LLVMValue *)not:(LLVMValue *)value {
	NSParameterAssert(value != nil);
	return [LLVMValue valueWithValueRef: LLVMBuildNot(self.builderRef, value.valueRef, "")];
}


-(LLVMValue *)stringPointer:(NSString *)string {
	NSParameterAssert(string != nil);
	return [LLVMValue valueWithValueRef: LLVMBuildGlobalStringPtr(self.builderRef, [string UTF8String], "")];
}


// -(LLVMValue *)offsetPointer:(LLVMValue *)pointerValue by:(LLVMValue *)offsetValue {
// 	LLVMValueRef offsetValueRefs[] = { offsetValue.valueRef };
// 	return [LLVMValue valueWithValueRef: LLVMBuildGEP(self.builderRef, pointerValue.valueRef, offsetValueRefs, 1, "")];
// }

// -(LLVMValue *)dereference:(LLVMValue *)pointer {
// 	return [LLVMValue valueWithValueRef: LLVMBuildGEP(self.builderRef, pointer.valueRef, (LLVMValueRef[]){ [self.context constantInteger: 0].valueRef }, 1, "")];
// }


-(LLVMBooleanValue *)and:(LLVMValue *)left, ... {
	va_list list;
	va_start(list, left);
	LLVMValue *right = va_arg(list, LLVMValue *);
	va_end(list);
	NSParameterAssert(left != nil);
	NSParameterAssert(right != nil);
	return [LLVMBooleanValue valueWithValueRef: LLVMBuildAnd(self.builderRef, left.valueRef, right.valueRef, "")];
}

-(LLVMBooleanValue *)or:(LLVMValue *)left, ... {
	va_list list;
	va_start(list, left);
	LLVMValue *right = va_arg(list, LLVMValue *);
	va_end(list);
	NSParameterAssert(left != nil);
	NSParameterAssert(right != nil);
	return [LLVMBooleanValue valueWithValueRef: LLVMBuildOr(self.builderRef, left.valueRef, right.valueRef, "")];
}


-(LLVMBooleanValue *)unsignedLessOrEqual:(LLVMValue *)left, ... {
	va_list list;
	va_start(list, left);
	LLVMValue *right = va_arg(list, LLVMValue *);
	va_end(list);
	NSParameterAssert(left != nil);
	NSParameterAssert(right != nil);
	return [LLVMBooleanValue valueWithValueRef: LLVMBuildICmp(self.builderRef, LLVMIntULE, left.valueRef, right.valueRef, "")];
}

-(LLVMBooleanValue *)unsignedLessThan:(LLVMValue *)left, ... {
	va_list list;
	va_start(list, left);
	LLVMValue *right = va_arg(list, LLVMValue *);
	va_end(list);
	NSParameterAssert(left != nil);
	NSParameterAssert(right != nil);
	return [LLVMBooleanValue valueWithValueRef: LLVMBuildICmp(self.builderRef, LLVMIntULT, left.valueRef, right.valueRef, "")];
}

-(LLVMBooleanValue *)equal:(LLVMValue *)left, ... {
	va_list list;
	va_start(list, left);
	LLVMValue *right = va_arg(list, LLVMValue *);
	va_end(list);
	NSParameterAssert(left != nil);
	NSParameterAssert(right != nil);
	return [LLVMBooleanValue valueWithValueRef: LLVMBuildICmp(self.builderRef, LLVMIntEQ, left.valueRef, right.valueRef, "")];
}

-(LLVMBooleanValue *)notEqual:(LLVMValue *)left, ... {
	va_list list;
	va_start(list, left);
	LLVMValue *right = va_arg(list, LLVMValue *);
	va_end(list);
	NSParameterAssert(left != nil);
	NSParameterAssert(right != nil);
	return [LLVMBooleanValue valueWithValueRef: LLVMBuildICmp(self.builderRef, LLVMIntNE, left.valueRef, right.valueRef, "")];
}


-(LLVMValue *)allocateLocal:(NSString *)name type:(LLVMType *)type {
	NSParameterAssert(name != nil);
	NSParameterAssert(type != nil);
	return [LLVMValue valueWithValueRef: LLVMBuildAlloca(self.builderRef, type.typeRef, [name UTF8String]) name: name];
}


-(LLVMValue *)set:(LLVMValue *)local, ... {
	va_list list;
	va_start(list, local);
	LLVMValue *value = va_arg(list, LLVMValue *);
	va_end(list);
	NSParameterAssert(local != nil);
	NSParameterAssert(value != nil);
	return [LLVMValue valueWithValueRef: LLVMBuildStore(self.builderRef, value.valueRef, local.valueRef)];
}

-(LLVMValue *)setElements:(LLVMValue *)address, ... {
	va_list list;
	va_start(list, address);
	LLVMValue *element = nil;
	NSUInteger i = 0;
	while(element = va_arg(list, LLVMValue *)) {
		LLVMValueRef addressRef = LLVMBuildGEP(self.builderRef, address.valueRef, (LLVMValueRef[]){ [self.context constantUnsignedInt32: 0].valueRef, [self.context constantUnsignedInt32: i].valueRef }, 2, [[NSString stringWithFormat: @"element %u", i] UTF8String]);
		LLVMBuildStore(self.builderRef, element.valueRef, addressRef);
		i++;
	}
	va_end(list);
	return address;
}

-(LLVMValue *)get:(LLVMValue *)local {
	return [LLVMValue valueWithValueRef: LLVMBuildLoad(self.builderRef, local.valueRef, [local.name UTF8String])];
}

-(LLVMValue *)getElement:(LLVMValue *)address atIndex:(NSUInteger)index {
	return [LLVMValue valueWithValueRef: LLVMBuildLoad(self.builderRef, LLVMBuildGEP(self.builderRef, address.valueRef, (LLVMValueRef[]){ [self.context constantUnsignedInt32: 0].valueRef, [self.context constantUnsignedInt32: index].valueRef }, 2, ""), [[NSString stringWithFormat: @"element %u", index] UTF8String])];
}


-(LLVMValue *)if:(LLVMValue *)condition then:(LLVMBlock *)thenBlock else:(LLVMBlock *)elseBlock {
	return [LLVMValue valueWithValueRef: LLVMBuildCondBr(self.builderRef, condition.valueRef, thenBlock.blockRef, elseBlock.blockRef)];
}

-(LLVMValue *)jumpToBlock:(LLVMBlock *)block {
	return [LLVMValue valueWithValueRef: LLVMBuildBr(self.builderRef, block.blockRef)];
}

@end
