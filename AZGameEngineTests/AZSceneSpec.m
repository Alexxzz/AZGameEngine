//
//  AZSceneSpec.m
//  AZGameEngine
//
//  Created by Oleksandr Zahorskyi on 29/01/15.
//  Copyright 2015 Alexander Zahorskyi. All rights reserved.
//

#import "Specta.h"
#import "Expecta.h"
#import "AZScene.h"

#import "AZGameEngine.h"
#import "AZEntity.h"
#import "AZComponent.h"

@interface TestComponentOne : AZComponent
@end
@implementation TestComponentOne
@end

@interface TestComponentTwo : AZComponent
@end
@implementation TestComponentTwo
@end

@interface TestComponentThree : AZComponent
@end
@implementation TestComponentThree
@end

SpecBegin(AZScene)

describe(@"AZScene", ^{
    __block AZScene *scene = nil;
    AZGameEngine *engine = [[AZGameEngine alloc] init];
    
    beforeEach(^{
        scene = [[AZScene alloc] initWithEngine:engine];
    });
    
    it(@"should set engine property after init", ^{
        expect(scene.gameEngine).to.equal(engine);
    });
    
    it(@"should contain entity after adding", ^{
        AZEntity *entity = [[AZEntity alloc] init];
        [scene addEntity:entity];
        
        expect(scene.entities).to.contain(entity);
        expect(scene.entities).to.haveCountOf(1);
    });
    
    it(@"shoudl not add entity twice", ^{
        AZEntity *entity = [[AZEntity alloc] init];
        [scene addEntity:entity];
        [scene addEntity:entity];
        
        expect(scene.entities).to.contain(entity);
        expect(scene.entities).to.haveCountOf(1);
    });
    
    it(@"should not contain entity after removing", ^{
        AZEntity *entity = [[AZEntity alloc] init];
        [scene addEntity:entity];
        [scene removeEntity:entity];
        
        expect(scene.entities).toNot.contain(entity);
        expect(scene.entities).to.haveCountOf(0);
    });
    
    it(@"should not crash if adding or removing nil entity", ^{
        [scene addEntity:nil];
        [scene removeEntity:nil];
    });
    
    it(@"should return entities which contains components with provided classes", ^{
        AZEntity *entity1 = [[AZEntity alloc] init];
        [scene addEntity:entity1];
        
        AZEntity *entity2 = [AZEntity new];
        [entity2 addComponent:[TestComponentOne new]];
        [entity2 addComponent:[TestComponentThree new]];
        [scene addEntity:entity2];
        
        AZEntity *entity3 = [[AZEntity alloc] init];
        [entity3 addComponent:[TestComponentThree new]];
        [scene addEntity:entity3];
        
        AZEntity *entity4 = [[AZEntity alloc] init];
        [entity4 addComponent:[TestComponentOne new]];
        [entity4 addComponent:[TestComponentTwo new]];
        [entity4 addComponent:[TestComponentThree new]];
        [scene addEntity:entity4];
        
        AZEntity *entity5 = [[AZEntity alloc] init];
        [entity5 addComponent:[TestComponentOne new]];
        [entity5 addComponent:[TestComponentTwo new]];
        [scene addEntity:entity5];
        
        NSSet *entities = [scene entitiesWithComponentsClasses:@[[TestComponentOne class], [TestComponentThree class]]];
        
        expect(entities).to.contain(entity2);
        expect(entities).to.contain(entity4);
        expect(entities).to.haveCountOf(2);
    });
    
    it(@"should return nil if entitiesWithComponentsClasses called with empty array or nil", ^{
        AZEntity *entity1 = [[AZEntity alloc] init];
        [scene addEntity:entity1];
        
        AZEntity *entity2 = [AZEntity new];
        [entity2 addComponent:[TestComponentOne new]];
        [entity2 addComponent:[TestComponentThree new]];
        [scene addEntity:entity2];
        
        NSSet *entities = [scene entitiesWithComponentsClasses:@[]];
        expect(entities).to.beNil;
        
        entities = [scene entitiesWithComponentsClasses:nil];
        expect(entities).to.beNil;
    });
});

SpecEnd
