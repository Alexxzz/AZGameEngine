//
//  AZGameEngineSpec.m
//  AZGameEngine
//
//  Created by Oleksandr Zahorskyi on 29/01/15.
//  Copyright 2015 Alexander Zahorskyi. All rights reserved.
//

#import "Specta.h"
#import "Expecta.h"
#import "OCMock.h"

#import "AZGameEngine.h"

#import "AZScene.h"
#import "AZSystem.h"


@import SpriteKit;


SpecBegin(AZGameEngine)

describe(@"AZGameEngine", ^{
    __block AZGameEngine *engine = nil;
    __block SKView *view = nil;
    
    beforeEach(^{
        view   = [SKView new];
        engine = [[AZGameEngine alloc] initWithView:view];
    });
    
    it(@"should have reference on SKView after init", ^{
        AZGameEngine *testEngine = [[AZGameEngine alloc] initWithView:view];
        
        expect(testEngine.view).to.equal(view);
    });
    
    it(@"should be able to presen scene", ^{
        AZScene *scene = [[AZScene alloc] initWithEngine:engine];
        
        [engine presentScene:scene];
        
        expect(view.scene).equal(scene);
        expect(engine.currentScene).equal(scene);
    });
    
    it(@"should contain system afrer adding", ^{
        AZSystem *system1 = [[AZSystem alloc] init];
        
        [engine addSystem:system1];
        
        expect(engine.systems).contain(system1);
    });
    
    it(@"should not add the same system twice", ^{
        AZSystem *system1 = [[AZSystem alloc] init];
        
        [engine addSystem:system1];
        [engine addSystem:system1];
        
        expect(engine.systems.count).equal(1);
    });
    
    it(@"should not contain system after remove called", ^{
        AZSystem *system1 = [[AZSystem alloc] init];
        AZSystem *system2 = [[AZSystem alloc] init];
        AZSystem *system3 = [[AZSystem alloc] init];
        
        [engine addSystem:system1];
        [engine addSystem:system2];
        [engine addSystem:system3];
        [engine removeSystem:system2];
        
        expect(engine.systems).notTo.contain(system2);
    });
    
    it(@"should update all systems when update method is called", ^{
        AZSystem *system1 = OCMClassMock([AZSystem class]);
        AZSystem *system2 = OCMClassMock([AZSystem class]);
        AZSystem *system3 = OCMClassMock([AZSystem class]);
        
        [engine addSystem:system1];
        [engine addSystem:system2];
        [engine addSystem:system3];
        
        [engine update:100];
        
        OCMVerify([system1 update:100]);
        OCMVerify([system2 update:100]);
        OCMVerify([system3 update:100]);
    });
    
    it(@"should return entities with components of given classes", ^{
        AZScene *scene = OCMClassMock([AZScene class]);
        
        [engine presentScene:scene];
        NSArray  *classes = @[@"class1", @"class2"];
        [engine entitiesWithComponentsClasses:classes];
        
        OCMVerify([scene entitiesWithComponentsClasses:classes]);
    });
    
    it(@"should not crash when entitiesWithComponentsClasses called and there is no currentScene", ^{
        NSArray  *classes = @[@"class1", @"class2"];
        [engine entitiesWithComponentsClasses:classes];
    });
});

SpecEnd
