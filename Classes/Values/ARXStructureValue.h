// ARXStructureValue.h
// Created by Rob Rix on 2010-06-10
// Copyright 2010 Monochrome Industries

#import "ARXValue.h"

@class ARXPointerValue, ARXStructureType;

@interface ARXStructureValue : ARXValue

-(ARXPointerValue *)referenceToElementAtIndex:(NSUInteger)i;
-(ARXValue *)elementAtIndex:(NSUInteger)i;

-(ARXValue *)elementNamed:(NSString *)name;
-(void)setElement:(ARXValue *)element forName:(NSString *)name;
-(ARXStructureValue *)structureElementNamed:(NSString *)name;

@property (nonatomic, copy) NSArray *elements;

@property (nonatomic, readonly) ARXStructureType *structureType;

@end
