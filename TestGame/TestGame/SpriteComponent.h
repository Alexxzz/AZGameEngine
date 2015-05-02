//
//  SpriteComponent.h
//  TestGame
//
//  Created by Oleksandr Zahorskyi on 22/03/15.
//  Copyright (c) 2015 Alexander Zahorskyi. All rights reserved.
//

#import "AZComponent.h"

@import SpriteKit;

@interface SpriteComponent : AZComponent
@property (nonatomic, strong) SKSpriteNode *sprite;
@end
