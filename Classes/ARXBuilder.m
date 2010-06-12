// ARXBuilder.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "ARXBlock+Protected.h"
#import "ARXBooleanValue.h"
#import "ARXBuilder.h"
#import "ARXBuilder+Protected.h"
#import "ARXContext+Protected.h"
#import "ARXFunction.h"
#import "ARXPointerValue.h"
#import "ARXType+Protected.h"
#import "ARXValue+Protected.h"

@implementation ARXBuilder

+(ARXBuilder *)builderWithContext:(ARXContext *)context {
	return [[[ARXBuilder alloc] initWithContext: context] autorelease];
}

-(id)initWithContext:(ARXContext *)_context {
	if(self = [super init]) {
		builderRef = LLVMCreateBuilderInContext(_context.contextRef);
		context = [_context retain];
	}
	return self;
}


@synthesize builderRef, context;


-(void)positionAtEndOfFunction:(ARXFunction *)function {
	NSParameterAssert(function != nil);
	[self positionAtEndOfBlock: function.entryBlock];
}

-(void)positionAtEndOfBlock:(ARXBlock *)block {
	NSParameterAssert(block != nil);
	LLVMPositionBuilderAtEnd(self.builderRef, block.blockRef);
}


-(ARXBlock *)currentBlock {
	return [ARXBlock blockWithBlockRef: LLVMGetInsertBlock(self.builderRef)];
}


-(ARXValue *)return:(ARXValue *)value {
	NSParameterAssert(value != nil);
	return [ARXValue valueWithValueRef: LLVMBuildRet(self.builderRef, value.valueRef)];
}


-(ARXValue *)call:(ARXValue *)function arguments:(NSArray *)arguments {
	NSParameterAssert(function != nil);
	LLVMValueRef argumentRefs[arguments.count];
	NSUInteger i = 0;
	for(ARXValue *argument in arguments) {
		argumentRefs[i++] = argument.valueRef;
	}
	return [ARXValue valueWithValueRef: LLVMBuildCall(self.builderRef, function.valueRef, argumentRefs, arguments.count, "")];
}

-(ARXValue *)call:(ARXValue *)function argument:(ARXValue *)argument {
	return [self call: function arguments: [NSArray arrayWithObject: argument]];
}

-(ARXValue *)call:(ARXValue *)function, ... {
	va_list list;
	NSMutableArray *arguments = [NSMutableArray array];
	va_start(list, function);
	ARXValue *argument = nil;
	while(argument = va_arg(list, ARXValue *)) {
		[arguments addObject: argument];
	}
	va_end(list);
	return [self call: function arguments: arguments];
}


-(ARXValue *)condition:(ARXValue *)condition then:(ARXValue *)thenValue else:(ARXValue *)elseValue {
	NSParameterAssert(condition != nil);
	NSParameterAssert(thenValue != nil);
	NSParameterAssert(elseValue != nil);
	return [ARXValue valueWithValueRef: LLVMBuildSelect(self.builderRef, condition.valueRef, thenValue.valueRef, elseValue.valueRef, "")];
}


-(ARXValue *)add:(ARXValue *)left, ... {
	va_list list;
	va_start(list, left);
	ARXValue *right = va_arg(list, ARXValue *);
	va_end(list);
	NSParameterAssert(left != nil);
	NSParameterAssert(right != nil);
	return [ARXValue valueWithValueRef: LLVMBuildAdd(self.builderRef, left.valueRef, right.valueRef, "")];
}

-(ARXValue *)subtract:(ARXValue *)left, ... {
	va_list list;
	va_start(list, left);
	ARXValue *right = va_arg(list, ARXValue *);
	va_end(list);
	NSParameterAssert(left != nil);
	NSParameterAssert(right != nil);
	return [ARXValue valueWithValueRef: LLVMBuildSub(self.builderRef, left.valueRef, right.valueRef, "")];
}

-(ARXValue *)not:(ARXValue *)value {
	NSParameterAssert(value != nil);
	return [ARXValue valueWithValueRef: LLVMBuildNot(self.builderRef, value.valueRef, "")];
}


-(ARXValue *)stringPointer:(NSString *)string {
	NSParameterAssert(string != nil);
	return [ARXValue valueWithValueRef: LLVMBuildGlobalStringPtr(self.builderRef, [string UTF8String], "")];
}


// -(ARXValue *)offsetPointer:(ARXValue *)pointerValue by:(ARXValue *)offsetValue {
// 	LLVMValueRef offsetValueRefs[] = { offsetValue.valueRef };
// 	return [ARXValue valueWithValueRef: LLVMBuildGEP(self.builderRef, pointerValue.valueRef, offsetValueRefs, 1, "")];
// }

// -(ARXValue *)dereference:(ARXValue *)pointer {
// 	return [ARXValue valueWithValueRef: LLVMBuildGEP(self.builderRef, pointer.valueRef, (LLVMValueRef[]){ [self.context constantInteger: 0].valueRef }, 1, "")];
// }


-(ARXBooleanValue *)and:(ARXValue *)left, ... {
	va_list list;
	va_start(list, left);
	ARXValue *right = va_arg(list, ARXValue *);
	va_end(list);
	NSParameterAssert(left != nil);
	NSParameterAssert(right != nil);
	return [ARXBooleanValue valueWithValueRef: LLVMBuildAnd(self.builderRef, left.valueRef, right.valueRef, "")];
}

-(ARXBooleanValue *)or:(ARXValue *)left, ... {
	va_list list;
	va_start(list, left);
	ARXValue *right = va_arg(list, ARXValue *);
	va_end(list);
	NSParameterAssert(left != nil);
	NSParameterAssert(right != nil);
	return [ARXBooleanValue valueWithValueRef: LLVMBuildOr(self.builderRef, left.valueRef, right.valueRef, "")];
}


-(ARXBooleanValue *)unsignedLessOrEqual:(ARXValue *)left, ... {
	va_list list;
	va_start(list, left);
	ARXValue *right = va_arg(list, ARXValue *);
	va_end(list);
	NSParameterAssert(left != nil);
	NSParameterAssert(right != nil);
	return [ARXBooleanValue valueWithValueRef: LLVMBuildICmp(self.builderRef, LLVMIntULE, left.valueRef, right.valueRef, "")];
}

-(ARXBooleanValue *)unsignedLessThan:(ARXValue *)left, ... {
	va_list list;
	va_start(list, left);
	ARXValue *right = va_arg(list, ARXValue *);
	va_end(list);
	NSParameterAssert(left != nil);
	NSParameterAssert(right != nil);
	return [ARXBooleanValue valueWithValueRef: LLVMBuildICmp(self.builderRef, LLVMIntULT, left.valueRef, right.valueRef, "")];
}

-(ARXBooleanValue *)equal:(ARXValue *)left, ... {
	va_list list;
	va_start(list, left);
	ARXValue *right = va_arg(list, ARXValue *);
	va_end(list);
	NSParameterAssert(left != nil);
	NSParameterAssert(right != nil);
	return [ARXBooleanValue valueWithValueRef: LLVMBuildICmp(self.builderRef, LLVMIntEQ, left.valueRef, right.valueRef, "")];
}

-(ARXBooleanValue *)notEqual:(ARXValue *)left, ... {
	va_list list;
	va_start(list, left);
	ARXValue *right = va_arg(list, ARXValue *);
	va_end(list);
	NSParameterAssert(left != nil);
	NSParameterAssert(right != nil);
	return [ARXBooleanValue valueWithValueRef: LLVMBuildICmp(self.builderRef, LLVMIntNE, left.valueRef, right.valueRef, "")];
}


-(ARXPointerValue *)allocateLocal:(NSString *)name type:(ARXType *)type {
	NSParameterAssert(name != nil);
	NSParameterAssert(type != nil);
	return [ARXPointerValue valueWithValueRef: LLVMBuildAlloca(self.builderRef, type.typeRef, [name UTF8String]) name: name];
}


-(ARXValue *)set:(ARXValue *)local, ... {
	va_list list;
	va_start(list, local);
	ARXValue *value = va_arg(list, ARXValue *);
	va_end(list);
	NSParameterAssert(local != nil);
	NSParameterAssert(value != nil);
	return [ARXValue valueWithValueRef: LLVMBuildStore(self.builderRef, value.valueRef, local.valueRef)];
}

-(ARXValue *)setElements:(ARXValue *)address, ... {
	va_list list;
	va_start(list, address);
	ARXValue *element = nil;
	NSUInteger i = 0;
	while(element = va_arg(list, ARXValue *)) {
		LLVMValueRef addressRef = LLVMBuildGEP(self.builderRef, address.valueRef, (LLVMValueRef[]){ [self.context constantUnsignedInt32: 0].valueRef, [self.context constantUnsignedInt32: i].valueRef }, 2, [[NSString stringWithFormat: @"element %u", i] UTF8String]);
		LLVMBuildStore(self.builderRef, element.valueRef, addressRef);
		i++;
	}
	va_end(list);
	return address;
}

-(ARXValue *)get:(ARXValue *)local {
	return [ARXValue valueWithValueRef: LLVMBuildLoad(self.builderRef, local.valueRef, [local.name UTF8String])];
}

-(ARXValue *)getElement:(ARXValue *)address atIndex:(NSUInteger)index {
	return [ARXValue valueWithValueRef: LLVMBuildLoad(self.builderRef, LLVMBuildGEP(self.builderRef, address.valueRef, (LLVMValueRef[]){ [self.context constantUnsignedInt32: 0].valueRef, [self.context constantUnsignedInt32: index].valueRef }, 2, ""), [[NSString stringWithFormat: @"element %u", index] UTF8String])];
}


-(ARXValue *)if:(ARXValue *)condition then:(ARXBlock *)thenBlock else:(ARXBlock *)elseBlock {
	return [ARXValue valueWithValueRef: LLVMBuildCondBr(self.builderRef, condition.valueRef, thenBlock.blockRef, elseBlock.blockRef)];
}

-(ARXValue *)goto:(ARXBlock *)block {
	return [ARXValue valueWithValueRef: LLVMBuildBr(self.builderRef, block.blockRef)];
}

@end
