// ARXBooleanType.m
// Created by Rob Rix on 2010-06-14
// Copyright 2010 Monochrome Industries

#import "ARXBooleanType.h"
#import "ARXBooleanValue.h"
#import "ARXType+Protected.h"

@implementation ARXBooleanType

-(Class)correspondingValueClass {
	return [ARXBooleanValue class];
}

@end
