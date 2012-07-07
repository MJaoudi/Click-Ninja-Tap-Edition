//
//  GameLayer.m
//  Click Ninja
//
//  Created by Michael Jaoudi on 7/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"

@implementation GameLayer
// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
    self.isTouchEnabled = YES;
    firework = [[Firework alloc] init];
    firework.position = ccp(100,100);
    [self addChild:firework];
    ninja = [[Ninja alloc] init];
    ninja.position = ccp(240,160);
    [self addChild:ninja];
    /*  CCSprite *sprite = [[CCSprite alloc] initWithFile:@"Shaolin Animation Kicking_1.png"];
     sprite.position = ccp(240,160);
     [self addChild:sprite];
     CCAnimation *kick = [CCAnimation animationWithAnimationFrames:[NSArray arrayWithObjects:[CCSpriteFrame @"Shaolin Animation Kicking_1.png","Shaolin Animation Kicking_2.png",nil] delayPerUnit:0.02f loops:3];
     CCAnimate *kicking = [CCAnimate actionWithAnimation:kick];
     [sprite runAction:[CCRepeatForever actionWithAction:kicking]];*/
    
    //    [firework explode];
  }
	return self;
}
- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
  [firework fire];
  [ninja startKicking];
}
// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}


@end
