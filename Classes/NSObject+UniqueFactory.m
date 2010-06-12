// NSObject+UniqueFactory.m
// Created by Rob Rix on 2010-06-12
// Copyright 2010 Monochrome Industries

#import "NSObject+UniqueFactory.h"
#import <objc/message.h>

@implementation NSObject (NSObjectUniqueFactory)

+(id)createUniqueInstanceForReference:(void *)reference initializer:(SEL)selector {
	static NSMutableDictionary *instancesByClassName = nil;
	if(!instancesByClassName) {
		instancesByClassName = [[NSMutableDictionary alloc] init];
	}
	NSMutableDictionary *instancesByReference = [instancesByClassName objectForKey: NSStringFromClass(self)];
	if(!instancesByReference) {
		instancesByReference = [[NSMutableDictionary alloc] init];
		[instancesByClassName setObject: instancesByReference forKey: NSStringFromClass(self)];
	}
	id instance = [instancesByReference objectForKey: [NSValue valueWithPointer: reference]];
	if(!instance) {
		instance = [objc_msgSend([self alloc], selector, reference) autorelease];
		[instancesByReference setObject: instance forKey: [NSValue valueWithPointer: reference]];
	}
	return instance;
}

@end
