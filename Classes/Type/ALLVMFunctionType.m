// ALLVMFunctionType.m
// Created by Rob Rix on 2010-06-10
// Copyright 2010 Monochrome Industries

#import "ALLVMFunctionType.h"
#import "ALLVMType+Protected.h"

@implementation ALLVMFunctionType

-(ALLVMType *)returnType {
	return [ALLVMType typeWithTypeRef: LLVMGetReturnType(self.typeRef)];
}

-(NSArray *)argumentTypes {
	NSUInteger count = LLVMCountParamTypes(self.typeRef);
	LLVMTypeRef typeRefs[count];
	LLVMGetParamTypes(self.typeRef, typeRefs);
	NSMutableArray *argumentTypes = [[NSMutableArray alloc] initWithCapacity: count];
	for(NSUInteger i = 0; i < count; i++) {
		[argumentTypes addObject: [ALLVMType typeWithTypeRef: typeRefs[i]]];
	}
	return [argumentTypes autorelease];
}


-(void)declareArgumentNames:(NSArray *)names {
	NSMutableDictionary *tempNames = [[NSMutableDictionary alloc] init];
	NSUInteger i = 0;
	for(NSString *name in names) {
		[tempNames setObject: [NSNumber numberWithUnsignedInteger: i] forKey: name];
	}
	argumentNames = [tempNames copy];
	[tempNames release];
}

-(NSUInteger)indexForArgumentName:(NSString *)name {
	return [[argumentNames objectForKey: name] unsignedIntegerValue];
}


-(NSUInteger)arity {
	return LLVMCountParamTypes(self.typeRef);
}

-(BOOL)hasVariableArity {
	return LLVMIsFunctionVarArg(self.typeRef);
}

@end
