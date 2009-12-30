// LLVMConcreteType.m
// Created by Rob Rix on 2009-12-30
// Copyright 2009 Monochrome Industries

#import "LLVMConcreteType.h"

@implementation LLVMConcreteType

+(id)typeWithTypeRef:(LLVMTypeRef)_typeRef {
	return [[[self alloc] initWithTypeRef: _typeRef] autorelease];
}

-(id)initWithTypeRef:(LLVMTypeRef)_typeRef {
	if(self = [super init]) {
		typeRef = _typeRef;
		NSParameterAssert(typeRef != NULL);
	}
	return self;
}

@synthesize typeRef;

@end