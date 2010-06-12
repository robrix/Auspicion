// LLVMModule+Protected.h
// Created by Rob Rix on 2010-06-12
// Copyright 2010 Monochrome Industries

#import "LLVMModule.h"

@interface LLVMModule ()

@property (nonatomic, readonly) LLVMModuleRef moduleRef;
@property (nonatomic, readonly) LLVMModuleProviderRef moduleProviderRef;

+(LLVMModule *)moduleWithModuleRef:(LLVMModuleRef)_moduleRef;

@end
