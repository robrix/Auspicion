// ARXPointerValue.h
// Created by Rob Rix on 2010-06-09
// Copyright 2010 Monochrome Industries

#import "ARXValue.h"

@class ARXStructureValue;

@interface ARXPointerValue : ARXValue

@property (nonatomic, copy) ARXValue *value;
@property (nonatomic, readonly) ARXStructureValue *structureValue;

@end
