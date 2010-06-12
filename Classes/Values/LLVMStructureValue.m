// LLVMStructureValue.m
// Created by Rob Rix on 2010-06-10
// Copyright 2010 Monochrome Industries

#import "LLVMBuilder+Protected.h"
#import "LLVMContext.h"
#import "LLVMPointerValue.h"
#import "LLVMStructureValue.h"
#import "LLVMStructureType.h"
#import "LLVMValue+Protected.h"

@implementation LLVMStructureValue

-(LLVMPointerValue *)referenceToElementAtIndex:(NSUInteger)i {
	return (LLVMPointerValue*)[LLVMValue valueWithValueRef: LLVMBuildGEP(self.builder.builderRef, self.valueRef, (LLVMValueRef[]){ [self.context constantUnsignedInt32: 0].valueRef, [self.context constantUnsignedInt32: i].valueRef }, 2, [[NSString stringWithFormat: @"element %u", i] UTF8String])];
}

-(LLVMValue *)elementAtIndex:(NSUInteger)i {
	return [self referenceToElementAtIndex: i].value;
}


-(LLVMValue *)elementNamed:(NSString *)name {
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
	for(LLVMValue *element in elements) {
		[self.builder set: [self referenceToElementAtIndex: i], element];
		i++;
	}
}


-(LLVMStructureType *)structureType {
	return (LLVMStructureType *)self.type;
}

@end
