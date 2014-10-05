// ARXStructureType.m
// Created by Rob Rix on 2010-06-10
// Copyright 2010 Monochrome Industries

#import "ARXStructureType.h"
#import "ARXStructureValue.h"
#import "ARXType+Protected.h"

@implementation ARXStructureType

-(void)declareElementNames:(NSArray *)names {
	elementNames = [names copy];
}

@synthesize elementNames;

-(NSUInteger)indexForElementName:(NSString *)name {
	return [elementNames indexOfObject: name];
}


-(NSUInteger)elementCount {
	return LLVMCountStructElementTypes(self.typeRef);
}


-(Class)correspondingValueClass {
	return [ARXStructureValue class];
}

@end
