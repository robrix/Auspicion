// ALLVMStructureType.h
// Created by Rob Rix on 2010-06-10
// Copyright 2010 Monochrome Industries

#import "ALLVMType.h"

@interface ALLVMStructureType : ALLVMType {
	NSDictionary *elementNames;
}

-(void)declareElementNames:(NSArray *)names;
-(NSUInteger)indexForElementName:(NSString *)name;
-(NSUInteger)elementCount;

@end
