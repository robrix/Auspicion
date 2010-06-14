// ARXPointerValue.m
// Created by Rob Rix on 2010-06-09
// Copyright 2010 Monochrome Industries

#import "ARXBuilder.h"
#import "ARXPointerValue.h"
#import "ARXStructureValue.h"

@implementation ARXPointerValue

-(ARXValue *)value {
	return [self.builder get: self];
}

-(void)setValue:(ARXValue *)value {
	[self.builder set: self, value];
}


-(ARXStructureValue *)structureValue {
	return (ARXStructureValue *)self.value;
}

@end
