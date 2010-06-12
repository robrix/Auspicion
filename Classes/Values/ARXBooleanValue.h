// ARXBooleanValue.h
// Created by Rob Rix on 2010-06-09
// Copyright 2010 Monochrome Industries

#import "ARXValue.h"

@interface ARXBooleanValue : ARXValue

-(void)ifTrue:(void(^)())block;

-(ARXValue *)select:(ARXValue *)either or:(ARXValue *)or;

-(ARXBooleanValue *)and:(ARXValue *)other;

@end
