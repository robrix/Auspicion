// ARXModule+Protected.h
// Created by Rob Rix on 2010-06-12
// Copyright 2010 Monochrome Industries

#import "ARXModule.h"

@interface ARXModule ()

@property (nonatomic, readonly) LLVMModuleRef moduleRef;
@property (nonatomic, readonly) LLVMModuleProviderRef moduleProviderRef;

+(ARXModule *)moduleWithModuleRef:(LLVMModuleRef)_moduleRef;

@end
