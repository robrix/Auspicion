// ARXPointerType.m
// Created by Rob Rix on 2010-06-12
// Copyright 2010 Monochrome Industries

#import "ARXPointerType.h"
#import "ARXFunction.h"
#import "ARXFunctionType.h"
#import "ARXPointerValue.h"
#import "ARXStructureType.h"
#import "ARXStructureValue.h"
#import "ARXType+Protected.h"

@implementation ARXPointerType

-(ARXType *)referencedType {
	return [ARXType typeWithTypeRef: LLVMGetElementType(self.typeRef)];
}


-(Class)correspondingValueClass {
	Class result = Nil;
	if([self.referencedType isKindOfClass: [ARXStructureType class]]) {
		result = [ARXStructureValue class];
	} else if([self.referencedType isKindOfClass: [ARXFunctionType class]]) {
		result = [ARXFunction class];
	} else {
		result = [ARXPointerValue class];
	}
	return result;
}

@end
