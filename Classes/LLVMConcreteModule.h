// LLVMConcreteModule.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMModule.h"

@interface LLVMModule ()

@property (nonatomic, readonly) LLVMModuleRef moduleRef;
@property (nonatomic, readonly) LLVMModuleProviderRef moduleProviderRef;

@end


@interface LLVMConcreteModule : LLVMModule {
	LLVMModuleRef moduleRef;
	LLVMModuleProviderRef moduleProviderRef;
	LLVMContext *context;
}

-(id)initWithName:(NSString *)_name context:(LLVMContext *)_context;

@end
