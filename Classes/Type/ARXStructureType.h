// ARXStructureType.h
// Created by Rob Rix on 2010-06-10
// Copyright 2010 Monochrome Industries

#import "ARXType.h"

@interface ARXStructureType : ARXType {
	NSArray *elementNames;
}

-(void)declareElementNames:(NSArray *)names;
@property (nonatomic, readonly) NSArray *elementNames;
-(NSUInteger)indexForElementName:(NSString *)name;

@property (nonatomic, readonly) NSUInteger elementCount;

@end
