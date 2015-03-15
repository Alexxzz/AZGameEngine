//
//  AZGameEngine.h
//  AZGameEngine
//
//  Created by Oleksandr Zahorskyi on 21/01/15.
//  Copyright (c) 2015 Alexander Zahorskyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SKView;
@class AZScene;
@class AZSystem;

@interface AZGameEngine : NSObject

@property (nonatomic, readonly) SKView *view;
@property (nonatomic, readonly) AZScene *currentScene;
@property (nonatomic, readonly) NSArray *systems;

- (instancetype)initWithView:(SKView *)view;

- (void)presentScene:(AZScene *)scene;

- (void)addSystem:(AZSystem *)system;
- (void)removeSystem:(AZSystem *)system;

- (void)update:(NSTimeInterval)timeInterval;

- (NSSet *)entitiesWithComponentsClasses:(NSArray *)classes;

@end
