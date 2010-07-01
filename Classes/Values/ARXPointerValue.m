// ARXPointerValue.m
// Created by Rob Rix on 2010-06-09
// Copyright 2010 Monochrome Industries

#import "ARXBuilder+Protected.h"
#import "ARXPointerValue.h"
#import "ARXStructureValue.h"
#import "ARXValue+Protected.h"

@implementation ARXPointerValue

-(ARXValue *)value {
	ARXValue *value = [ARXValue valueWithValueRef: LLVMBuildLoad(self.builder.builderRef, self.valueRef, [self.name UTF8String])];
	[value referencedByPointer: self];
	return value;
}

-(void)setValue:(ARXValue *)value {
	[self.builder set: self, value];
}


-(ARXStructureValue *)structureValue {
	return (ARXStructureValue *)self.value;
}

@end
