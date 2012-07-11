//
//  GameLayer.m
//  Click Ninja
//
//  Created by Michael Jaoudi on 7/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"
#import "GameOver.h"

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
	if( (self=[super initWithColor:ccc4(32,32,32,255)]) ) {
    self.isTouchEnabled = YES;
    firework = [[Firework alloc] init];
    firework.position = ccp(240,160);
    [self addChild:firework];
    ninja = [[Ninja alloc] init];
    ninja.position = ccp(150,160);
    [self addChild:ninja];
    timer = 30.0f;
    timerLabel = [[CCLabelTTF alloc] initWithString:[NSString stringWithFormat:@"%f",timer] dimensions:CGSizeMake(80, 45) hAlignment:kCCTextAlignmentLeft fontName:@"DomoAregato" fontSize:30.0f];
    timerLabel.position = ccp(55,285);
    [self addChild:timerLabel];
    score = 0;
    scoreLabel = [[CCLabelTTF alloc] initWithString:[NSString stringWithFormat:@"%i",score] dimensions:CGSizeMake(80, 45) hAlignment:kCCTextAlignmentRight fontName:@"DomoAregato" fontSize:30.0f];
    scoreLabel.position = ccp(420,285);
    [self addChild:scoreLabel];
    button = [[CCSprite alloc] initWithFile:@"Button.png"];
    button.position = ccp(240,160);
    [self addChild:button];
    
    [self scheduleUpdate];
    
    [self schedule:@selector(timer:) interval:0.1f];
  }
	return self;
}

-(void)timer:(ccTime)dt{
  timer = timer - 0.1f;
  [timerLabel setString:[NSString stringWithFormat:@"%.1f",timer]];
  //NSLog(@"%.1f",timer);
  if(timer<=0.0f){
    [[CCDirector  sharedDirector] replaceScene:[GameOver scene]];
  }
}


-(void) update:(ccTime)dt{
  delay++;
  if(delay>40){
    [ninja stopKicking];
  }
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

  UITouch *touch = [touches anyObject];
  CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
  
  CGPoint buttonLocation = [button convertToNodeSpace:touchLocation];
  CGRect buttonRect = [button textureRect];
  buttonRect.origin = CGPointZero;
  
  
  if(CGRectContainsPoint(buttonRect, buttonLocation))
  {
    NSLog(@"yay for buttooooons");
    [firework fire];
    [ninja startKicking];
    delay=0;
    score++;
    [scoreLabel setString:[NSString stringWithFormat:@"%i",score]];
  }
  
  


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
