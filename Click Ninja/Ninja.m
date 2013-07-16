//
//  Ninja.m
//  Click Ninja
//
//  Created by Mike Jaoudi on 7/6/12.
//  Copyright 2012 Mike Jaoudi. All rights reserved.
//

#import "Ninja.h"


@implementation Ninja
-(id)init{
    
    

    if(self = [super initWithSpriteFrameName:@"RobeNinja_1.png"]){
        // self = [[CCSpriteBatchNode batchNodeWithFile:@"Blue Fireworks_default.png"] retain];
        
        NSMutableArray *jumpFrames = [NSMutableArray array];
        for(int i = 1; i <= 2; ++i) {
            [jumpFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"Kick%02d.png", i]]];
        }
        
        NSMutableArray *kickFrames = [NSMutableArray array];
        for(int i = 3; i <= 4; ++i) {
            [kickFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"Kick%02d.png", i]]];
        }
        
        NSMutableArray *landFrames = [NSMutableArray array];
        for(int i = 5; i <= 7; ++i) {
            [landFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"Kick%02d.png", i]]];
        }
        
        
        NSMutableArray *startFrames = [NSMutableArray array];
        for (int i=1; i < 7; i++) {
            [startFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"RobeNinja_%01d.png", i]]];
        }
        [startFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"Kick01.png"]];
        
        jump = [[CCAnimation alloc]  initWithSpriteFrames:jumpFrames delay:0.1f];
        kick = [[CCAnimation alloc]  initWithSpriteFrames:kickFrames delay:0.08f];
        land = [[CCAnimation alloc]  initWithSpriteFrames:landFrames delay:0.1f];
        start = [[CCAnimation alloc] initWithSpriteFrames:startFrames delay:0.15f];
        
        
        kicking = NO;
    }
    return self;
}

-(void)robeOff{
    [self setTexture:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"RobeNinja_1.png"].texture];

    [self stopAllActions];
    kicking = NO;
    [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.2f],[CCAnimate actionWithAnimation:start],nil]];

}

-(void)startKicking{
    if(kicking){ return; }
    
    [self runAction:[CCSequence actions:[CCAnimate actionWithAnimation:jump],[CCRepeat actionWithAction:[CCAnimate actionWithAnimation:kick] times:NSUIntegerMax], nil]];
    
    
    kicking = YES;
    
}

-(void)stopKicking{
    if(!kicking){ return; }
    
    [self stopAllActions];
    
    [self runAction:[CCAnimate actionWithAnimation:land]];
    
    kicking = NO;
}
@end
