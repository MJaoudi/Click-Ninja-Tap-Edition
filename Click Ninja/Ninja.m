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
  
  
  [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
   @"Ninja.plist"];
  self = [super initWithFile:@"Ninja.png" capacity:150];
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
  
  
  jump = [[CCAnimation alloc]  initWithSpriteFrames:jumpFrames delay:0.1f];
  kick = [[CCAnimation alloc]  initWithSpriteFrames:kickFrames delay:0.08f];
  land = [[CCAnimation alloc]  initWithSpriteFrames:landFrames delay:0.1f];
  
  ninja = [[CCSprite alloc] initWithSpriteFrameName:@"Kick01.png"];
  [self addChild:ninja];
  kicking = FALSE;
  return self;
}
-(void)startKicking{
  if(kicking){ return; }
  
  [ninja runAction:[CCSequence actions:[CCAnimate actionWithAnimation:jump],[CCRepeat actionWithAction:[CCAnimate actionWithAnimation:kick] times:NSUIntegerMax], nil]];
    
  
  kicking = TRUE;
  
}

-(void)stopKicking{
  if(!kicking){ return; }
  
  [ninja stopAllActions];
  
  [ninja runAction:[CCAnimate actionWithAnimation:land]];
  
  kicking = FALSE;
}/*
  -(void)fire{
  int rand = arc4random()%3;
  if(rand==0){
  [[fireworks objectAtIndex:index] runAction:[CCSpawn actions:[CCFadeIn actionWithDuration:0],[CCAnimate actionWithAnimation:redExplosion],[CCFadeOut actionWithDuration:1.0f], nil]];
  }
  else if(rand==1){
  [[fireworks objectAtIndex:index] runAction:[CCSpawn actions:[CCFadeIn actionWithDuration:0],[CCAnimate actionWithAnimation:blueExplosion],[CCFadeOut actionWithDuration:1.0f], nil]];
  }
  else if(rand==2){
  [[fireworks objectAtIndex:index] runAction:[CCSpawn actions:[CCFadeIn actionWithDuration:0],[CCAnimate actionWithAnimation:greenExplosion],[CCFadeOut actionWithDuration:1.0f], nil]];
  }
  double angle = floorf(((double)arc4random() / M_PI/4) - 0.2f);
  
  [[fireworks objectAtIndex:index] runAction:[CCSequence actions:[CCMoveTo actionWithDuration:1.0f position:CGPointMake(200*cos(angle), 200*sin(angle))], [CCMoveTo actionWithDuration:0.0f position:CGPointMake(0,0)],nil]];
  index = (index+1)%[fireworks count];
  
  }*/
@end
