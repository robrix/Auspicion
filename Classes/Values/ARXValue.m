// ARXValue.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "ARXBlock+Protected.h"
#import "ARXBuilder.h"
#import "ARXContext.h"
#import "ARXFunction.h"
#import "ARXFunctionType.h"
#import "ARXModule.h"
#import "ARXPointerType.h"
#import "ARXPointerValue.h"
#import "ARXStructureValue.h"
#import "ARXType+Protected.h"
#import "ARXValue+Protected.h"
#import "AuspicionLLVM.h"

@implementation ARXValue

+(Class)classForType:(ARXType *)type {
	Class result = Nil;
	switch(type.typeKind) {
		case LLVMStructTypeKind:
			result = [ARXStructureValue class];
			break;
		case LLVMFunctionTypeKind:
			result = [ARXFunction class];
			break;
		case LLVMPointerTypeKind:
			if([[(ARXPointerType *)type referencedType] isKindOfClass: [ARXFunctionType class]]) {
				result = [ARXFunction class];
			} else {
				result = [ARXPointerValue class];
			}
			break;
		default:
			result = self;
			break;
	}
	return result;
}

+(id)valueWithValueRef:(LLVMValueRef)_valueRef name:(NSString *)_name {
	return [[[[self classForType: [ARXType typeOfValueRef: _valueRef]] alloc] initWithValueRef: _valueRef name: _name] autorelease];
}

+(id)valueWithValueRef:(LLVMValueRef)_valueRef {
	return [[[[self classForType: [ARXType typeOfValueRef: _valueRef]] alloc] initWithValueRef: _valueRef name: @""] autorelease];
}

-(id)initWithValueRef:(LLVMValueRef)_valueRef name:(NSString *)_name {
	if(self = [super init]) {
		valueRef = _valueRef;
		NSParameterAssert(valueRef != NULL);
	}
	return self;
}


@synthesize valueRef;


-(NSString *)name {
	return [NSString stringWithUTF8String: LLVMGetValueName(self.valueRef)];
}

-(void)setName:(NSString *)name {
	LLVMSetValueName(self.valueRef, [name UTF8String]);
}


-(ARXType *)type {
	return [ARXType typeWithTypeRef: LLVMTypeOf(self.valueRef)];
}


-(ARXBlock *)parentBlock {
	return [ARXBlock blockWithBlockRef: LLVMGetInstructionParent(self.valueRef)];
}

-(ARXModule *)module {
	return self.parentBlock.parentFunction.module;
}

-(ARXContext *)context {
	return self.module.context;
}


-(ARXBuilder *)builder {
	return self.module.builder;
}


-(ARXBooleanValue *)equals:(ARXValue *)other {
	return [self.builder equal: self, other];
}

-(ARXBooleanValue *)notEquals:(ARXValue *)other {
	return [self.builder notEqual: self, other];
}


-(ARXValue *)plus:(ARXValue *)other {
	return [self.builder add: self, other];
}


-(NSString *)description {
	char *bytes = AuspicionLLVMPrintValue(self.valueRef);
	NSString *result = [NSString stringWithCString: bytes encoding: NSUTF8StringEncoding];
	free(bytes);
	return result;
}

@end
