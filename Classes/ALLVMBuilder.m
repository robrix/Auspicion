// ALLVMBuilder.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "ALLVMBlock+Protected.h"
#import "ALLVMBooleanValue.h"
#import "ALLVMBuilder.h"
#import "ALLVMBuilder+Protected.h"
#import "ALLVMContext+Protected.h"
#import "ALLVMFunction.h"
#import "ALLVMPointerValue.h"
#import "ALLVMType+Protected.h"
#import "ALLVMValue+Protected.h"

@implementation ALLVMBuilder

+(ALLVMBuilder *)builderWithContext:(ALLVMContext *)context {
	return [[[ALLVMBuilder alloc] initWithContext: context] autorelease];
}

-(id)initWithContext:(ALLVMContext *)_context {
	if(self = [super init]) {
		builderRef = LLVMCreateBuilderInContext(_context.contextRef);
		context = [_context retain];
	}
	return self;
}


@synthesize builderRef, context;


-(void)positionAtEndOfFunction:(ALLVMFunction *)function {
	NSParameterAssert(function != nil);
	[self positionAtEndOfBlock: function.entryBlock];
}

-(void)positionAtEndOfBlock:(ALLVMBlock *)block {
	NSParameterAssert(block != nil);
	LLVMPositionBuilderAtEnd(self.builderRef, block.blockRef);
}


-(ALLVMValue *)return:(ALLVMValue *)value {
	NSParameterAssert(value != nil);
	return [ALLVMValue valueWithValueRef: LLVMBuildRet(self.builderRef, value.valueRef)];
}


-(ALLVMValue *)call:(ALLVMValue *)function arguments:(NSArray *)arguments {
	NSParameterAssert(function != nil);
	LLVMValueRef argumentRefs[arguments.count];
	NSUInteger i = 0;
	for(ALLVMValue *argument in arguments) {
		argumentRefs[i++] = argument.valueRef;
	}
	return [ALLVMValue valueWithValueRef: LLVMBuildCall(self.builderRef, function.valueRef, argumentRefs, arguments.count, "")];
}

-(ALLVMValue *)call:(ALLVMValue *)function argument:(ALLVMValue *)argument {
	return [self call: function arguments: [NSArray arrayWithObject: argument]];
}

-(ALLVMValue *)call:(ALLVMValue *)function, ... {
	va_list list;
	NSMutableArray *arguments = [NSMutableArray array];
	va_start(list, function);
	ALLVMValue *argument = nil;
	while(argument = va_arg(list, ALLVMValue *)) {
		[arguments addObject: argument];
	}
	va_end(list);
	return [self call: function arguments: arguments];
}


-(ALLVMValue *)condition:(ALLVMValue *)condition then:(ALLVMValue *)thenValue else:(ALLVMValue *)elseValue {
	NSParameterAssert(condition != nil);
	NSParameterAssert(thenValue != nil);
	NSParameterAssert(elseValue != nil);
	return [ALLVMValue valueWithValueRef: LLVMBuildSelect(self.builderRef, condition.valueRef, thenValue.valueRef, elseValue.valueRef, "")];
}


-(ALLVMValue *)add:(ALLVMValue *)left, ... {
	va_list list;
	va_start(list, left);
	ALLVMValue *right = va_arg(list, ALLVMValue *);
	va_end(list);
	NSParameterAssert(left != nil);
	NSParameterAssert(right != nil);
	return [ALLVMValue valueWithValueRef: LLVMBuildAdd(self.builderRef, left.valueRef, right.valueRef, "")];
}

-(ALLVMValue *)subtract:(ALLVMValue *)left, ... {
	va_list list;
	va_start(list, left);
	ALLVMValue *right = va_arg(list, ALLVMValue *);
	va_end(list);
	NSParameterAssert(left != nil);
	NSParameterAssert(right != nil);
	return [ALLVMValue valueWithValueRef: LLVMBuildSub(self.builderRef, left.valueRef, right.valueRef, "")];
}

-(ALLVMValue *)not:(ALLVMValue *)value {
	NSParameterAssert(value != nil);
	return [ALLVMValue valueWithValueRef: LLVMBuildNot(self.builderRef, value.valueRef, "")];
}


-(ALLVMValue *)stringPointer:(NSString *)string {
	NSParameterAssert(string != nil);
	return [ALLVMValue valueWithValueRef: LLVMBuildGlobalStringPtr(self.builderRef, [string UTF8String], "")];
}


// -(ALLVMValue *)offsetPointer:(ALLVMValue *)pointerValue by:(ALLVMValue *)offsetValue {
// 	LLVMValueRef offsetValueRefs[] = { offsetValue.valueRef };
// 	return [ALLVMValue valueWithValueRef: LLVMBuildGEP(self.builderRef, pointerValue.valueRef, offsetValueRefs, 1, "")];
// }

// -(ALLVMValue *)dereference:(ALLVMValue *)pointer {
// 	return [ALLVMValue valueWithValueRef: LLVMBuildGEP(self.builderRef, pointer.valueRef, (LLVMValueRef[]){ [self.context constantInteger: 0].valueRef }, 1, "")];
// }


-(ALLVMBooleanValue *)and:(ALLVMValue *)left, ... {
	va_list list;
	va_start(list, left);
	ALLVMValue *right = va_arg(list, ALLVMValue *);
	va_end(list);
	NSParameterAssert(left != nil);
	NSParameterAssert(right != nil);
	return [ALLVMBooleanValue valueWithValueRef: LLVMBuildAnd(self.builderRef, left.valueRef, right.valueRef, "")];
}

-(ALLVMBooleanValue *)or:(ALLVMValue *)left, ... {
	va_list list;
	va_start(list, left);
	ALLVMValue *right = va_arg(list, ALLVMValue *);
	va_end(list);
	NSParameterAssert(left != nil);
	NSParameterAssert(right != nil);
	return [ALLVMBooleanValue valueWithValueRef: LLVMBuildOr(self.builderRef, left.valueRef, right.valueRef, "")];
}


-(ALLVMBooleanValue *)unsignedLessOrEqual:(ALLVMValue *)left, ... {
	va_list list;
	va_start(list, left);
	ALLVMValue *right = va_arg(list, ALLVMValue *);
	va_end(list);
	NSParameterAssert(left != nil);
	NSParameterAssert(right != nil);
	return [ALLVMBooleanValue valueWithValueRef: LLVMBuildICmp(self.builderRef, LLVMIntULE, left.valueRef, right.valueRef, "")];
}

-(ALLVMBooleanValue *)unsignedLessThan:(ALLVMValue *)left, ... {
	va_list list;
	va_start(list, left);
	ALLVMValue *right = va_arg(list, ALLVMValue *);
	va_end(list);
	NSParameterAssert(left != nil);
	NSParameterAssert(right != nil);
	return [ALLVMBooleanValue valueWithValueRef: LLVMBuildICmp(self.builderRef, LLVMIntULT, left.valueRef, right.valueRef, "")];
}

-(ALLVMBooleanValue *)equal:(ALLVMValue *)left, ... {
	va_list list;
	va_start(list, left);
	ALLVMValue *right = va_arg(list, ALLVMValue *);
	va_end(list);
	NSParameterAssert(left != nil);
	NSParameterAssert(right != nil);
	return [ALLVMBooleanValue valueWithValueRef: LLVMBuildICmp(self.builderRef, LLVMIntEQ, left.valueRef, right.valueRef, "")];
}

-(ALLVMBooleanValue *)notEqual:(ALLVMValue *)left, ... {
	va_list list;
	va_start(list, left);
	ALLVMValue *right = va_arg(list, ALLVMValue *);
	va_end(list);
	NSParameterAssert(left != nil);
	NSParameterAssert(right != nil);
	return [ALLVMBooleanValue valueWithValueRef: LLVMBuildICmp(self.builderRef, LLVMIntNE, left.valueRef, right.valueRef, "")];
}


-(ALLVMPointerValue *)allocateLocal:(NSString *)name type:(ALLVMType *)type {
	NSParameterAssert(name != nil);
	NSParameterAssert(type != nil);
	return [ALLVMPointerValue valueWithValueRef: LLVMBuildAlloca(self.builderRef, type.typeRef, [name UTF8String]) name: name];
}


-(ALLVMValue *)set:(ALLVMValue *)local, ... {
	va_list list;
	va_start(list, local);
	ALLVMValue *value = va_arg(list, ALLVMValue *);
	va_end(list);
	NSParameterAssert(local != nil);
	NSParameterAssert(value != nil);
	return [ALLVMValue valueWithValueRef: LLVMBuildStore(self.builderRef, value.valueRef, local.valueRef)];
}

-(ALLVMValue *)setElements:(ALLVMValue *)address, ... {
	va_list list;
	va_start(list, address);
	ALLVMValue *element = nil;
	NSUInteger i = 0;
	while(element = va_arg(list, ALLVMValue *)) {
		LLVMValueRef addressRef = LLVMBuildGEP(self.builderRef, address.valueRef, (LLVMValueRef[]){ [self.context constantUnsignedInt32: 0].valueRef, [self.context constantUnsignedInt32: i].valueRef }, 2, [[NSString stringWithFormat: @"element %u", i] UTF8String]);
		LLVMBuildStore(self.builderRef, element.valueRef, addressRef);
		i++;
	}
	va_end(list);
	return address;
}

-(ALLVMValue *)get:(ALLVMValue *)local {
	return [ALLVMValue valueWithValueRef: LLVMBuildLoad(self.builderRef, local.valueRef, [local.name UTF8String])];
}

-(ALLVMValue *)getElement:(ALLVMValue *)address atIndex:(NSUInteger)index {
	return [ALLVMValue valueWithValueRef: LLVMBuildLoad(self.builderRef, LLVMBuildGEP(self.builderRef, address.valueRef, (LLVMValueRef[]){ [self.context constantUnsignedInt32: 0].valueRef, [self.context constantUnsignedInt32: index].valueRef }, 2, ""), [[NSString stringWithFormat: @"element %u", index] UTF8String])];
}


-(ALLVMValue *)if:(ALLVMValue *)condition then:(ALLVMBlock *)thenBlock else:(ALLVMBlock *)elseBlock {
	return [ALLVMValue valueWithValueRef: LLVMBuildCondBr(self.builderRef, condition.valueRef, thenBlock.blockRef, elseBlock.blockRef)];
}

-(ALLVMValue *)jumpToBlock:(ALLVMBlock *)block {
	return [ALLVMValue valueWithValueRef: LLVMBuildBr(self.builderRef, block.blockRef)];
}

@end
