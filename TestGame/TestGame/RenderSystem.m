//
//  RenderSystem.m
//  TestGame
//
//  Created by Oleksandr Zahorskyi on 22/03/15.
//  Copyright (c) 2015 Alexander Zahorskyi. All rights reserved.
//

#import "RenderSystem.h"

#import "AZGameEngine.h"
#import "AZEntity.h"
#import "AZScene.h"

#import "SpriteComponent.h"
#import "PositionComponent.h"

@import SpriteKit;


@implementation RenderSystem

- (void)updateEntities:(NSSet *)entities withTimeInterval:(NSTimeInterval)timeInterval
{
    for (AZEntity *entity in entities) {
        SpriteComponent *spriteComponent = (SpriteComponent *)[entity componentWithClass:[SpriteComponent class]];
        PositionComponent *positionComponent = (PositionComponent *)[entity componentWithClass:[PositionComponent class]];
        
        if (spriteComponent.sprite.parent != self.engine.currentScene) {
            [self.engine.currentScene addChild:spriteComponent.sprite];
            
            spriteComponent.sprite.position = positionComponent.position;
        }
    }
}

@end
