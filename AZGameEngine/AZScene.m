//
//  AZScene.m
//  AZGameEngine
//
//  Created by Oleksandr Zahorskyi on 29/01/15.
//  Copyright (c) 2015 Alexander Zahorskyi. All rights reserved.
//

#import "AZScene.h"

#import "AZEntity.h"


@implementation AZScene

- (instancetype)initWithEngine:(AZGameEngine *)gameEngine
{
    self = [super init];
    if (self) {
        _gameEngine = gameEngine;
        _entities   = [NSSet set];
    }
    return self;
}

- (void)addEntity:(AZEntity *)entity
{
    if (entity == nil) {
        return;
    }
    
    _entities = [_entities setByAddingObject:entity];
}

- (void)removeEntity:(AZEntity *)entity
{
    if (entity == nil) {
        return;
    }
    
    NSMutableSet *mutableSet = [NSMutableSet setWithSet:_entities];
    [mutableSet removeObject:entity];
    
    _entities = [mutableSet copy];
}

- (NSSet *)entitiesWithComponentsClasses:(NSArray *)componentsClasses
{
    if (componentsClasses.count == 0) {
        return nil;
    }
    
    return [_entities objectsPassingTest:^BOOL(AZEntity *obj, BOOL *stop) {
        BOOL contains = YES;
        for (Class componentClass in componentsClasses) {
            contains = contains && ([obj componentWithClass:componentClass] != nil);
        }
        return contains;
    }];
}

@end
