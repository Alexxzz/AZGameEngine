//
//  AZSystem.h
//  AZGameEngine
//
//  Created by Oleksandr Zahorskyi on 23/01/15.
//  Copyright (c) 2015 Alexander Zahorskyi. All rights reserved.
//

#import <Foundation/Foundation.h>


@class AZGameEngine;

@interface AZSystem: NSObject
@property (nonatomic, readonly) NSArray *componentsClasses;
@property (nonatomic, readonly) AZGameEngine *engine;

- (instancetype)initWithEngine:(AZGameEngine *)engine
             componentsClasses:(NSArray *)classes;

- (void)updateEntities:(NSSet *)entities
      withTimeInterval:(NSTimeInterval)timeInterval;
@end
