// ALLVMStructureValue.m
// Created by Rob Rix on 2010-06-10
// Copyright 2010 Monochrome Industries

#import "ALLVMBuilder+Protected.h"
#import "ALLVMContext.h"
#import "ALLVMPointerValue.h"
#import "ALLVMStructureValue.h"
#import "ALLVMStructureType.h"
#import "ALLVMValue+Protected.h"

@implementation ALLVMStructureValue

-(ALLVMPointerValue *)referenceToElementAtIndex:(NSUInteger)i {
	return (ALLVMPointerValue*)[ALLVMValue valueWithValueRef: LLVMBuildGEP(self.builder.builderRef, self.valueRef, (LLVMValueRef[]){ [self.context constantUnsignedInt32: 0].valueRef, [self.context constantUnsignedInt32: i].valueRef }, 2, [[NSString stringWithFormat: @"element %u", i] UTF8String])];
}

-(ALLVMValue *)elementAtIndex:(NSUInteger)i {
	return [self referenceToElementAtIndex: i].value;
}


-(ALLVMValue *)elementNamed:(NSString *)name {
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
	for(ALLVMValue *element in elements) {
		[self.builder set: [self referenceToElementAtIndex: i], element];
		i++;
	}
}


-(ALLVMStructureType *)structureType {
	return (ALLVMStructureType *)self.type;
}

@end
