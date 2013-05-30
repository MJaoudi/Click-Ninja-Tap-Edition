//
//  Firework.m
//  Click Ninja
//
//  Created by Mike Jaoudi on 7/5/12.
//  Copyright 2012 Mike Jaoudi. All rights reserved.
//

#import "Firework.h"


@implementation Firework

-(id)init{
    
    // [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA4444];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"Firework.plist"];
    self = [super initWithFile:@"Firework.png" capacity:150];
    // self = [[CCSpriteBatchNode batchNodeWithFile:@"Blue Fireworks_default.png"] retain];
    NSMutableArray *redFrames = [NSMutableArray array];
    for(int i = 1; i <= 56; ++i) {
        [redFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"Red Firework_%02d.png", i]]];
    }
    
    NSMutableArray *blueFrames = [NSMutableArray array];
    for(int i = 1; i <= 62; ++i) {
        [blueFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"Blue Firework_%02d.png", i]]];
    }
    
    NSMutableArray *greenFrames = [NSMutableArray array];
    for(int i = 1; i <= 49; ++i) {
        [greenFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"Green Firework_%02d.png", i]]];
    }
    
    fireworks = [[NSMutableArray alloc] init];
    
    redExplosion = [[CCAnimation alloc]  initWithSpriteFrames:redFrames delay:0.01f];
    blueExplosion = [[CCAnimation alloc]  initWithSpriteFrames:blueFrames delay:0.01f];
    greenExplosion = [[CCAnimation alloc]  initWithSpriteFrames:greenFrames delay:0.01f];
    
    for(int x=0;x<15;x++){
        CCSprite *sprite = [[CCSprite alloc] initWithSpriteFrameName:@"Blue Firework_01.png"];
        [fireworks addObject:sprite];
        [self addChild:sprite];
    }
    
    index = 0;
    
    //[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
    
    return self;
}


-(void)fire{
    int rand = arc4random()%3;
    id animation;
    if(rand==0){
        animation = [CCAnimate actionWithAnimation:redExplosion];
    }
    else if(rand==1){
        animation = [CCAnimate actionWithAnimation:blueExplosion];
        
    }
    else{
        animation = [CCAnimate actionWithAnimation:greenExplosion];
    }
    
    [[fireworks objectAtIndex:index] runAction:[CCSpawn actions:[CCFadeIn actionWithDuration:0],[CCSequence actions:[CCDelayTime actionWithDuration:0.1],animation,nil],[CCSequence actions:[CCDelayTime actionWithDuration:0.5],[CCFadeOut actionWithDuration:0.5f],nil], nil]];
    
    int angle = arc4random()%160+10;
    
    [[fireworks objectAtIndex:index] runAction:[CCSequence actions:[CCMoveTo actionWithDuration:1.0f position:CGPointMake(200*cos(angle*M_PI/180), 200*sin(angle*M_PI/180))], [CCMoveTo actionWithDuration:0.0f position:CGPointMake(0,0)],nil]];
    index = (index+1)%[fireworks count];
    
}
@end
