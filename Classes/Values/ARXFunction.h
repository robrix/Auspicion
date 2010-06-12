// ARXFunction.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "ARXValue.h"

@class ARXContext, ARXBlock, ARXFunctionType, ARXModule, ARXType;

@interface ARXFunction : ARXValue

+(id)functionInModule:(ARXModule *)module withName:(NSString *)name type:(ARXType *)type;

@property (nonatomic, readonly) ARXFunctionType *functionType;

@property (nonatomic, readonly) ARXContext *context;
@property (nonatomic, readonly) ARXModule *module;

-(ARXValue *)argumentAtIndex:(NSUInteger)index;
-(ARXValue *)argumentNamed:(NSString *)name;

-(BOOL)verifyWithError:(NSError **)error;

-(ARXBlock *)appendBlockWithName:(NSString *)name;

@property (nonatomic, readonly) ARXBlock *entryBlock;

-(ARXValue *)call:(ARXValue *)arg, ...;

@end
