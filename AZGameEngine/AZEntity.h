//
//  AZEntity.h
//  AZGameEngine
//
//  Created by Oleksandr Zahorskyi on 23/01/15.
//  Copyright (c) 2015 Alexander Zahorskyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AZComponent;

@interface AZEntity : NSObject

@property(nonatomic, readonly) NSArray *components;

- (void)addComponent:(AZComponent *)component;
- (void)removeComponent:(AZComponent *)component;

- (AZComponent *)componentWithClass:(Class)componentClass;

@end
