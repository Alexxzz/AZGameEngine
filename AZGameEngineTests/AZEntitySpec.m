//
//  AZEntitySpec.m
//  AZGameEngine
//
//  Created by Oleksandr Zahorskyi on 25/01/15.
//  Copyright 2015 Alexander Zahorskyi. All rights reserved.
//

#import "Specta.h"
#import "Expecta.h"
#import "AZEntity.h"
#import "AZComponent.h"

// Component subclass
@interface TestComponent : AZComponent
@end

@implementation TestComponent
@end
//


SpecBegin(AZEntity)

describe(@"AZEntity", ^{
    __block AZEntity *entity;
    
    beforeEach(^{
        entity = [[AZEntity alloc] init];
    });
    
    it(@"should contain component after adding", ^{
        AZComponent *component = [[AZComponent alloc] init];
        [entity addComponent:component];
        
        expect(entity.components).to.contain(component);
    });
    
    it(@"should not add component twice", ^{
        AZComponent *component = [[AZComponent alloc] init];
        [entity addComponent:component];
        [entity addComponent:component];
        
        expect(entity.components).to.haveCountOf(1);
    });
    
    it(@"should not contain component after removing", ^{
        AZComponent *component = [[AZComponent alloc] init];
        [entity addComponent:component];
        
        [entity removeComponent:component];
        
        expect(entity.components).to.haveCountOf(0);
    });
    
    it(@"should not crash if removing component is nil or not in the entity", ^{
        [entity removeComponent:nil];
        
        AZComponent *component = [[AZComponent alloc] init];
        [entity removeComponent:component];
    });
    
    it(@"should return component by its class", ^{
        TestComponent *component = [[TestComponent alloc] init];
        [entity addComponent:component];
        
        expect([entity componentWithClass:[TestComponent class]]).to.equal(component);
        expect([entity componentWithClass:[AZComponent class]]).to.beNil;
        expect([entity componentWithClass:nil]).to.beNil;
    });
});

SpecEnd
