// LLVMConcreteValue.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMValue.h"

@interface LLVMValue ()

@property (nonatomic, readonly) LLVMValueRef valueRef;

@end


@interface LLVMConcreteValue : LLVMValue {
	LLVMValueRef valueRef;
	NSString *name;
}

+(id)valueWithValueRef:(LLVMValueRef)_valueRef name:(NSString *)name;
+(id)valueWithValueRef:(LLVMValueRef)_valueRef;
-(id)initWithValueRef:(LLVMValueRef)_valueRef name:(NSString *)name;

@end