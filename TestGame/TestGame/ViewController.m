//
//  ViewController.m
//  TestGame
//
//  Created by Oleksandr Zahorskyi on 21/03/15.
//  Copyright (c) 2015 Alexander Zahorskyi. All rights reserved.
//

#import "ViewController.h"

#import <AZGameEngine/AZGameEngine.h>
#import "AZScene.h"
#import "AZEntity.h"

#import "PlayerControlledComponent.h"
#import "PositionComponent.h"
#import "SpriteComponent.h"
#import "MoveComponent.h"

#import "TouchMoveSystem.h"
#import "RenderSystem.h"

#import "EntityBuilder.h"

@import SpriteKit;


@interface ViewController ()
@property (nonatomic, strong) AZGameEngine *gameEngine;
@property (nonatomic, strong) SKView *view;
@end

@implementation ViewController

@dynamic view;


- (void)loadView
{
    [super loadView];
    
    self.view = [[SKView alloc] initWithFrame:self.view.bounds];
    self.view.showsFPS = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Engine
    self.gameEngine = [[AZGameEngine alloc] initWithView:self.view];
    
    // Systems
    RenderSystem *renderer = [[RenderSystem alloc] initWithEngine:self.gameEngine componentsClasses:@[[PositionComponent class],
                                                                                                      [SpriteComponent class]]];
    [self.gameEngine addSystem:renderer];
    
    TouchMoveSystem *touchControll = [[TouchMoveSystem alloc] initWithEngine:self.gameEngine componentsClasses:@[[PositionComponent class],
                                                                                                                 [MoveComponent class],
                                                                                                                 [PlayerControlledComponent class],
                                                                                                                 [SpriteComponent class]]];
    [self.gameEngine addSystem:touchControll];
    
    // Entities
    AZEntity *playerSpaceship = [EntityBuilder spaceShip:^(PositionComponent *position, SpriteComponent *sprite, PlayerControlledComponent *playerControlled) {
        position.position = self.view.center;
        sprite.sprite.size = CGSizeMake(75, 75);
        playerControlled.playerControlled = YES;
    }];
    
    AZEntity *spaceship = [EntityBuilder spaceShip:^(PositionComponent *position, SpriteComponent *sprite, PlayerControlledComponent *playerControlled) {
        position.position = CGPointMake(100, 100);
        sprite.sprite.size = CGSizeMake(75, 75);
    }];

    // Scene
    AZScene *scene = [[AZScene alloc] initWithEngine:self.gameEngine];
    [scene addEntity:playerSpaceship];
    [scene addEntity:spaceship];
    
    [self.gameEngine presentScene:scene];
}

@end
