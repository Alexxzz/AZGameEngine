//
//  EntityBuilder.h
//  TestGame
//
//  Created by Oleksandr Zahorskyi on 22/03/15.
//  Copyright (c) 2015 Alexander Zahorskyi. All rights reserved.
//

#import <Foundation/Foundation.h>


@class AZEntity;
@class PlayerControlledComponent;
@class PositionComponent;
@class SpriteComponent;
@class MoveComponent;


@interface EntityBuilder : NSObject

+ (AZEntity *)spaceShip:(void(^)(PositionComponent *position, SpriteComponent *sprite, PlayerControlledComponent *playerControlled))builderBlock;

@end
