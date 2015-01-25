//
//  AZEntity.m
//  AZGameEngine
//
//  Created by Oleksandr Zahorskyi on 23/01/15.
//  Copyright (c) 2015 Alexander Zahorskyi. All rights reserved.
//

#import "AZEntity.h"

@implementation AZEntity

- (instancetype)init
{
    self = [super init];
    if (self) {
        _components = @[];
    }
    return self;
}

- (void)addComponent:(AZComponent *)component
{
    if ([self.components containsObject:component]) {
        return;
    }
    _components = [self.components arrayByAddingObject:component];
}


- (void)removeComponent:(AZComponent *)component
{
    NSUInteger indexOfObject = [self.components indexOfObject:component];
    if (indexOfObject == NSNotFound) {
        return;
    }
    
    NSArray *firstSubArray = [self.components subarrayWithRange:NSMakeRange(0, indexOfObject)];
    NSArray *secondSubArray = [self.components subarrayWithRange:NSMakeRange(indexOfObject + 1, self.components.count - indexOfObject - 1)];
    _components = [firstSubArray arrayByAddingObjectsFromArray:secondSubArray];
}

- (AZComponent *)componentWithClass:(Class)componentClass
{
    AZComponent *result = nil;
    for (id component in self.components) {
        if ([component isKindOfClass:componentClass]) {
            result = component;
            break;
        }
    }
    return result;
}

@end
