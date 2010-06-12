// ALLVMContext+Protected.h
// Created by Rob Rix on 2010-06-12
// Copyright 2010 Monochrome Industries

#import "ALLVMContext.h"

@interface ALLVMContext ()

+(ALLVMContext *)contextWithContextRef:(LLVMContextRef)_contextRef;

@property (nonatomic, readonly) LLVMContextRef contextRef;

@end
