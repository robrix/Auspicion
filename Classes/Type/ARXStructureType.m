// ARXStructureType.m
// Created by Rob Rix on 2010-06-10
// Copyright 2010 Monochrome Industries

#import "ARXStructureType.h"
#import "ARXStructureValue.h"
#import "ARXType+Protected.h"

@implementation ARXStructureType

-(void)declareElementNames:(NSArray *)names {
	NSMutableDictionary *tempNames = [[NSMutableDictionary alloc] init];
	NSUInteger i = 0;
	for(NSString *name in names) {
		[tempNames setObject: [NSNumber numberWithUnsignedInteger: i] forKey: name];
		i++;
	}
	elementNames = [tempNames copy];
	[tempNames release];
}

-(NSUInteger)indexForElementName:(NSString *)name {
	return [[elementNames objectForKey: name] unsignedIntegerValue];
}


-(NSUInteger)elementCount {
	return LLVMCountStructElementTypes(LLVMGetElementType(self.typeRef));
}


-(Class)correspondingValueClass {
	return [ARXStructureValue class];
}

@end
