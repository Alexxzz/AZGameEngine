//
//  AZScene.h
//  AZGameEngine
//
//  Created by Oleksandr Zahorskyi on 29/01/15.
//  Copyright (c) 2015 Alexander Zahorskyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@import SpriteKit;


@class AZGameEngine;
@class AZEntity;

@interface AZScene : SKScene

@property (nonatomic, readonly) AZGameEngine *gameEngine;
@property (nonatomic, readonly) NSSet *entities;

- (instancetype)initWithEngine:(AZGameEngine *)gameEngine;

- (void)addEntity:(AZEntity *)entity;
- (void)removeEntity:(AZEntity *)entity;

- (NSSet *)entitiesWithComponentsClasses:(NSArray *)componentsClasses;

@end
