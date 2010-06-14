// ARXStructureValue.m
// Created by Rob Rix on 2010-06-10
// Copyright 2010 Monochrome Industries

#import "ARXBuilder+Protected.h"
#import "ARXContext.h"
#import "ARXPointerValue.h"
#import "ARXStructureValue.h"
#import "ARXStructureType.h"
#import "ARXValue+Protected.h"

@implementation ARXStructureValue

-(ARXPointerValue *)referenceToElementAtIndex:(NSUInteger)i {
	// return [ARXValue valueWithValueRef: LLVMBuildGEP(self.builder.builderRef, self.valueRef, (LLVMValueRef[]){ [self.context constantUnsignedInt32: i].valueRef }, 1, [[NSString stringWithFormat: @"element %u", i] UTF8String])];
	return [ARXValue valueWithValueRef: LLVMBuildGEP(self.builder.builderRef, self.valueRef, (LLVMValueRef[]){ [self.context constantUnsignedInt32: 0].valueRef, [self.context constantUnsignedInt32: i].valueRef }, 2, [[NSString stringWithFormat: @"element %u", i] UTF8String])];
}

-(ARXValue *)elementAtIndex:(NSUInteger)i {
	// return [self referenceToElementAtIndex: i];
	return [self referenceToElementAtIndex: i].value;
}


-(ARXValue *)elementNamed:(NSString *)name {
	return [self elementAtIndex: [self.structureType indexForElementName: name]];
}


-(NSArray *)elements {
	NSMutableArray *elements = [NSMutableArray array];
	for(NSUInteger i = 0; i < self.structureType.elementCount; i++) {
		[elements addObject: [self elementAtIndex: i]];
	}
	return elements;
}

-(void)setElements:(NSArray *)elements {
	NSUInteger i = 0;
	for(ARXValue *element in elements) {
		[self.builder set: [self referenceToElementAtIndex: i], element];
		i++;
	}
}


-(ARXStructureType *)structureType {
	return (ARXStructureType *)self.type;
}

@end
