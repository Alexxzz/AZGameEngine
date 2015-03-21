//
//  AZSystem.m
//  AZGameEngine
//
//  Created by Oleksandr Zahorskyi on 23/01/15.
//  Copyright (c) 2015 Alexander Zahorskyi. All rights reserved.
//

#import "AZSystem.h"

@implementation AZSystem

- (instancetype)initWithEngine:(AZGameEngine *)engine
             componentsClasses:(NSArray *)classes
{
    self = [super init];
    if (self) {
        _engine = engine;
        _componentsClasses = classes;
    }
    return self;
}

- (void)updateEntities:(NSSet *)entities
      withTimeInterval:(NSTimeInterval)timeInterval;
{
    NSAssert(YES, @"Implement in subclass");
}

@end
