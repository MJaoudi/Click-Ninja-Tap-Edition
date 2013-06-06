//
//  GameLayer.m
//  Click Ninja
//
//  Created by Mike Jaoudi on 7/4/12.
//  Copyright 2012 Mike Jaoudi. All rights reserved.
//

#import "GameLayer.h"
#import "GameOver.h"
#import "AppDelegate.h"
#import "GameCenter.h"

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
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        firework = [[Firework alloc] init];
        firework.position = ccp(size.width/2,150);
        [self addChild:firework];
        ninja = [[Ninja alloc] init];
        ninja.position = ccp(size.width/2-90,160);
        ninja.anchorPoint = ccp(0.5,.7);
        [self addChild:ninja z:10];
        time = 30;
        
        
        timerLabel = [[CCLabelTTF alloc] initWithString:[NSString stringWithFormat:@"Time:%i",time] fontName:@"DomoAregato" fontSize:30.0f dimensions:CGSizeMake(130, 45) hAlignment:kCCTextAlignmentLeft];
        timerLabel.position = ccp(75,285);
        timerLabel.color = ccc3(0, 0, 0);
        [self addChild:timerLabel];
        
        score = 0;
        scoreLabel = [[CCLabelTTF alloc] initWithString:[NSString stringWithFormat:@"%i",score] fontName:@"DomoAregato" fontSize:30.0f dimensions:CGSizeMake(80, 45) hAlignment:kCCTextAlignmentRight ];
        scoreLabel.position = ccp(size.width/2,200);
        scoreLabel.color = ccc3(0, 0, 0);
        [self addChild:scoreLabel];
        
        button = [[CCSprite alloc] initWithSpriteFrameName:@"TapButton.png"];
        button.position = ccp(size.width/2,160);
        [self addChild:button];
        
        
        CCSprite *hill = [[CCSprite alloc] initWithSpriteFrameName:@"Hill.png"];
        hill.position = ccp(size.width/2-90, 60);
        [self addChild:hill z:0];
        
        CCSprite *hill2 = [[CCSprite alloc] initWithSpriteFrameName:@"Hill.png"];
        hill2.position = ccp(size.width/2+190, 40);
        [self addChild:hill2 z:0];
        
        CCSprite *tree = [[CCSprite alloc] initWithSpriteFrameName:@"Tree3.png"];
        tree.position = ccp(size.width/2+190,220);
        [self addChild:tree];
        
        
        particleSystem = [CCParticleSystemQuad particleWithFile:@"Wood.plist"];
        particleSystem.position = ccp(button.position.x-button.contentSize.width/2, button.position.y);
        [self addChild:particleSystem];
        
        [particleSystem stopSystem];
        
        [[GameCenter sharedGameCenter] reportAchievementIdentifier:@"first" percentComplete:100.0f];
        
        [self scheduleUpdate];
        
        [self schedule:@selector(timer:) interval:1.0f];
    }
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Epic.mp3" loop:NO];//play background music
    
	return self;
}

-(void)timer:(ccTime)dt{
    time = time - 1.0f;
    [timerLabel setString:[NSString stringWithFormat:@"Time:%i",time]];
    
    if(time <= 0){
        AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [app setScore:score];
        [[CCDirector  sharedDirector] replaceScene:[GameOver scene]];
        
    }
}


-(void) update:(ccTime)dt{
    delay++;
    if(delay>40){
        [particleSystem stopSystem];
        [ninja stopKicking];
    }
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    for (UITouch *touch in touches) {
        
        
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
            if(![particleSystem active]){
                
                [particleSystem runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.2], [CCCallFunc actionWithTarget:particleSystem selector:@selector(resetSystem)], nil]];
            }
        }
        
    }
    
    
}
// on "dealloc" you need to release all your retained objects


@end
