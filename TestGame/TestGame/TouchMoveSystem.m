//
//  TouchMoveSystem.m
//  TestGame
//
//  Created by Oleksandr Zahorskyi on 22/03/15.
//  Copyright (c) 2015 Alexander Zahorskyi. All rights reserved.
//

#import "TouchMoveSystem.h"

#import "AZGameEngine.h"
#import "AZEntity.h"
#import "AZScene.h"

#import "MoveComponent.h"
#import "PlayerControlledComponent.h"
#import "SpriteComponent.h"
#import "PositionComponent.h"

static NSString * const kMoveActionKey = @"moving";

@interface TouchMoveSystem ()
@property (nonatomic, assign) CGPoint newPoint;
@property (nonatomic, strong) SKAction *moveAction;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@end

@implementation TouchMoveSystem

- (instancetype)initWithEngine:(AZGameEngine *)engine componentsClasses:(NSArray *)classes
{
    self = [super initWithEngine:engine componentsClasses:classes];
    if (self) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    }
    return self;
}

- (void)updateEntities:(NSSet *)entities withTimeInterval:(NSTimeInterval)timeInterval
{
    if ([[self.engine.currentScene.view gestureRecognizers] containsObject:self.tapGesture] == NO) {
        [self.engine.currentScene.view addGestureRecognizer:self.tapGesture];
        return;
    }
    
    if (self.moveAction == nil) {
        return;
    }
    
    for (AZEntity *entity in entities) {
        PlayerControlledComponent *playerControlled = (PlayerControlledComponent *)[entity componentWithClass:[PlayerControlledComponent class]];
        if (playerControlled.playerControlled == NO) {
            continue;
        }
        
        SpriteComponent *spriteComponent = (SpriteComponent *)[entity componentWithClass:[SpriteComponent class]];
        MoveComponent *moveComponent = (MoveComponent *)[entity componentWithClass:[MoveComponent class]];
        PositionComponent *positionComponent = (PositionComponent *)[entity componentWithClass:[PositionComponent class]];
        
        if (self.moveAction) {
            positionComponent.position = self.newPoint;
            moveComponent.moveAction = self.moveAction;
            [spriteComponent.sprite runAction:moveComponent.moveAction withKey:kMoveActionKey];
        }
    }
    
    self.moveAction = nil;
}

- (void)onTap:(UITapGestureRecognizer *)tapGesture
{
    CGPoint touchLocation = [tapGesture locationInView:tapGesture.view];
    touchLocation = [self.engine.currentScene convertPointFromView:touchLocation];
    self.newPoint = touchLocation;
    self.moveAction = [SKAction moveTo:touchLocation duration:1];
}

@end
