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
	if( (self=[super initWithColor:ccc4(103,151,223,255)]) ) {
        [self setTouchEnabled:YES];
        
        firework = [[Firework alloc] init];
        firework.position = ccp(240,160);
        [self addChild:firework];
        ninja = [[Ninja alloc] init];
        ninja.position = ccp(150,160);
        ninja.anchorPoint = ccp(0.5,.7);
        [self addChild:ninja z:10];
        time = 30;
        
        
        timerLabel = [[CCLabelTTF alloc] initWithString:[NSString stringWithFormat:@"Time:%i",time] fontName:@"DomoAregato" fontSize:30.0f dimensions:CGSizeMake(130, 45) hAlignment:kCCTextAlignmentLeft];
        timerLabel.position = ccp(75,285);
        timerLabel.color = ccc3(0, 0, 0);
        [self addChild:timerLabel];
        
        score = 0;
        scoreLabel = [[CCLabelTTF alloc] initWithString:[NSString stringWithFormat:@"%i",score] fontName:@"DomoAregato" fontSize:30.0f dimensions:CGSizeMake(80, 45) hAlignment:kCCTextAlignmentRight ]; 
        scoreLabel.position = ccp(240,200);
        scoreLabel.color = ccc3(0, 0, 0);
        [self addChild:scoreLabel];
        
        button = [[CCSprite alloc] initWithFile:@"Button.png"];
        button.position = ccp(238,160);
        [self addChild:button];
        
        
        CCSprite *hill = [CCSprite spriteWithFile:@"Hill.png"];
        hill.position = ccp(150, 60);
        [self addChild:hill z:0];
        
        CCSprite *hill2 = [CCSprite spriteWithFile:@"Hill.png"];
        hill2.position = ccp(430, 40);
        [self addChild:hill2 z:0];
        
        CCSprite *tree = [CCSprite spriteWithFile:@"Tree.png"];
        tree.position = ccp(430,220);
        [self addChild:tree];
        
        
        [self scheduleUpdate];
    
        [self schedule:@selector(timer:) interval:1.0f];
    }
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Epic.mp3" loop:NO];//play background music
    
	return self;
}

-(void)timer:(ccTime)dt{
    time = time - 1.0f;
    [timerLabel setString:[NSString stringWithFormat:@"Time:%i",time]];
    //NSLog(@"%.1f",timer);
    
    if(time <= 0){
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
