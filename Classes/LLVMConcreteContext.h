// LLVMConcreteContext.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMContext.h"

@interface LLVMContext ()

@property (nonatomic, readonly) LLVMContextRef contextRef;

@end

@interface LLVMConcreteContext : LLVMContext {
	LLVMContextRef contextRef;
}

-(id)initWithContextRef:(LLVMContextRef)_contextRef;

@end