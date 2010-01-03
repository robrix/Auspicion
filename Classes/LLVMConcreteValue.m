// LLVMConcreteValue.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMConcreteValue.h"

@implementation LLVMConcreteValue

+(id)valueWithValueRef:(LLVMValueRef)_valueRef name:(NSString *)_name {
	return [[[self alloc] initWithValueRef: _valueRef name: _name] autorelease];
}

+(id)valueWithValueRef:(LLVMValueRef)_valueRef {
	return [[[self alloc] initWithValueRef: _valueRef name: @""] autorelease];
}

-(id)initWithValueRef:(LLVMValueRef)_valueRef name:(NSString *)_name {
	if(self = [super init]) {
		name = [_name copy];
		NSParameterAssert(name != NULL);
		valueRef = _valueRef;
		NSParameterAssert(valueRef != NULL);
	}
	return self;
}


@synthesize name;

@synthesize valueRef;

@end