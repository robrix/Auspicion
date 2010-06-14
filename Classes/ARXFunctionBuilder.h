// ARXFunctionBuilder.h
// Created by Rob Rix on 2010-05-30
// Copyright 2010 Monochrome Industries

#import <Foundation/Foundation.h>

@class ARXBuilder, ARXFunction, ARXPointerValue, ARXStructureValue, ARXType, ARXValue;

@interface ARXFunctionBuilder : NSObject {
	ARXFunction *function;
	NSDictionary *argumentNames;
}

-(id)initWithFunction:(ARXFunction *)function;

@property (nonatomic, readonly) ARXBuilder *builder;

-(ARXValue *)argumentNamed:(NSString *)name;
-(ARXPointerValue *)pointerArgumentNamed:(NSString *)name;
-(ARXStructureValue *)structureArgumentNamed:(NSString *)name;

-(ARXBlock *)addBlockWithName:(NSString *)name;
-(void)goto:(ARXBlock *)destination;

-(ARXPointerValue *)allocateVariableOfType:(ARXType *)type value:(ARXValue *)value;

-(void)return:(ARXValue *)value;

@end
