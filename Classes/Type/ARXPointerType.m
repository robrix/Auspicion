// ARXPointerType.m
// Created by Rob Rix on 2010-06-12
// Copyright 2010 Monochrome Industries

#import "ARXPointerType.h"
#import "ARXType+Protected.h"

@implementation ARXPointerType

-(ARXType *)referencedType {
	return [ARXType typeWithTypeRef: LLVMGetElementType(self.typeRef)];
}

@end
