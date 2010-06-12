// NSObject+UniqueFactory.h
// Created by Rob Rix on 2010-06-12
// Copyright 2010 Monochrome Industries

#import <Foundation/Foundation.h>

@interface NSObject (NSObjectUniqueFactory)

+(id)createUniqueInstanceForReference:(void *)reference initializer:(SEL)selector;

@end
