//
//  EntityBuilder.m
//  TestGame
//
//  Created by Oleksandr Zahorskyi on 22/03/15.
//  Copyright (c) 2015 Alexander Zahorskyi. All rights reserved.
//

#import "EntityBuilder.h"

#import "PlayerControlledComponent.h"
#import "PositionComponent.h"
#import "SpriteComponent.h"
#import "MoveComponent.h"

#import "AZEntity.h"


@implementation EntityBuilder

+ (AZEntity *)spaceShip:(void(^)(PositionComponent *position, SpriteComponent *sprite, PlayerControlledComponent *playerControlled))builderBlock
{
    PositionComponent *position = [[PositionComponent alloc] init];
    
    SpriteComponent *sprite = [[SpriteComponent alloc] init];
    sprite.sprite = [SKSpriteNode spriteNodeWithImageNamed:@"spaceship"];
    
    PlayerControlledComponent *playerControlledComponent = [[PlayerControlledComponent alloc] init];
    
    MoveComponent *moveComponent = [[MoveComponent alloc] init];
    
    if (builderBlock) {
        builderBlock(position, sprite, playerControlledComponent);
    }
    
    AZEntity *spaceship = [[AZEntity alloc] init];
    [spaceship addComponent:position];
    [spaceship addComponent:sprite];
    [spaceship addComponent:playerControlledComponent];
    [spaceship addComponent:moveComponent];
    
    return spaceship;
}

@end
