//
//  AZGameEngine.m
//  AZGameEngine
//
//  Created by Oleksandr Zahorskyi on 21/01/15.
//  Copyright (c) 2015 Alexander Zahorskyi. All rights reserved.
//

#import "AZGameEngine.h"
#import "AZSystem.h"
#import "AZScene.h"

@import SpriteKit;


@interface AZGameEngine ()
@property (nonatomic, strong) SKView *view;
@property (nonatomic, strong) AZScene *currentScene;
@property (nonatomic, strong) NSArray *systems;
@end

@implementation AZGameEngine

- (instancetype)initWithView:(SKView *)view
{
    self = [super init];
    if (self) {
        _view    = view;
        _systems = @[];
    }
    return self;
}

- (void)presentScene:(AZScene *)scene
{
    self.currentScene = scene;
    [self.view presentScene:(SKScene *)scene];
}

- (void)addSystem:(AZSystem *)system
{
    if ([self.systems containsObject:system]) {
        return;
    }
    
    self.systems = [self.systems arrayByAddingObject:system];
}

- (void)removeSystem:(AZSystem *)system
{
    NSUInteger indexOfObject = [self.systems indexOfObject:system];
    if (indexOfObject == NSNotFound) {
        return;
    }
    
    NSArray *firstSubArray = [self.systems subarrayWithRange:NSMakeRange(0, indexOfObject)];
    NSArray *secondSubArray = [self.systems subarrayWithRange:NSMakeRange(indexOfObject + 1, self.systems.count - indexOfObject - 1)];
    self.systems = [firstSubArray arrayByAddingObjectsFromArray:secondSubArray];
}

- (void)update:(NSTimeInterval)timeInterval
{
    [self.systems enumerateObjectsUsingBlock:^(AZSystem *system, NSUInteger idx, BOOL *stop) {
        [system update:timeInterval];
    }];
}

- (NSSet *)entitiesWithComponentsClasses:(NSArray *)classes
{
    return [self.currentScene entitiesWithComponentsClasses:classes];
}

@end
