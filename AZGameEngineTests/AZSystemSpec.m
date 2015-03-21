//
//  AZSystemSpec.m
//  AZGameEngine
//
//  Created by Oleksandr Zahorskyi on 21/03/15.
//  Copyright 2015 Alexander Zahorskyi. All rights reserved.
//

#import "Specta.h"
#import "Expecta.h"
#import "OCMock.h"

#import "AZGameEngine.h"
#import "AZSystem.h"


@interface Component1 : NSObject
@end
@implementation Component1
@end

@interface Component2 : NSObject
@end
@implementation Component2
@end

@interface Component3 : NSObject
@end
@implementation Component3
@end


SpecBegin(AZSystem)

describe(@"AZSystem", ^{
    __block AZSystem *system = nil;
    
    beforeAll(^{
        AZGameEngine *engine = [[AZGameEngine alloc] init];
        Class class1 = [Component1 class];
        Class class2 = [Component2 class];
        Class class3 = [Component3 class];
        
        system = [[AZSystem alloc] initWithEngine:engine
                                componentsClasses:@[class1, class2, class3]];
    });
    
    it(@"should has engine after init", ^{
        expect(system.engine).notTo.beNil;
    });
    
    it(@"sould has list of components classes after init", ^{
        expect(system.componentsClasses.count).toNot.beLessThan(3);
    });
    
    
});

SpecEnd
