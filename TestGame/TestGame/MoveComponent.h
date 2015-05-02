//
//  MoveComponent.h
//  TestGame
//
//  Created by Oleksandr Zahorskyi on 22/03/15.
//  Copyright (c) 2015 Alexander Zahorskyi. All rights reserved.
//

#import "AZComponent.h"

@class SKAction;

@interface MoveComponent : AZComponent
@property (nonatomic, strong) SKAction *moveAction;
@end
