// ALLVMStructureType.m
// Created by Rob Rix on 2010-06-10
// Copyright 2010 Monochrome Industries

#import "ALLVMStructureType.h"
#import "ALLVMType+Protected.h"

@implementation ALLVMStructureType

-(void)declareElementNames:(NSArray *)names {
	NSMutableDictionary *tempNames = [[NSMutableDictionary alloc] init];
	NSUInteger i = 0;
	for(NSString *name in names) {
		[tempNames setObject: [NSNumber numberWithUnsignedInteger: i] forKey: name];
	}
	elementNames = [tempNames copy];
	[tempNames release];
}

-(NSUInteger)indexForElementName:(NSString *)name {
	return [[elementNames objectForKey: name] unsignedIntegerValue];
}


-(NSUInteger)elementCount {
	return LLVMCountStructElementTypes(self.typeRef);
}

@end
