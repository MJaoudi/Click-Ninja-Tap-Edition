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

@implementation GameLayer{
    Firework *firework;
    Ninja *ninja;
    
    CCSprite *button;
    CCSprite *resetButton;

    CCLabelTTF *timerLabel;
    CCLabelTTF *scoreLabel;
    CCLabelTTF *startLabel;
    
    CCParticleSystem *particleSystem;

    
    int delay;
    int time;
    int score;
    
    BOOL started;
}
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
        ninja.position = ccp(size.width/2-90,170);
        ninja.anchorPoint = ccp(0.5,.7);
        [self addChild:ninja z:10];
        
        
        timerLabel = [[CCLabelTTF alloc] initWithString:[NSString stringWithFormat:@"Time:%i",time] fontName:@"DomoAregato" fontSize:30.0f dimensions:CGSizeMake(130, 45) hAlignment:kCCTextAlignmentLeft];
        timerLabel.position = ccp(75,285);
        timerLabel.color = ccc3(0, 0, 0);
        [self addChild:timerLabel];
        
        score = 0;
        scoreLabel = [[CCLabelTTF alloc] initWithString:[NSString stringWithFormat:@"%i",score] fontName:@"DomoAregato" fontSize:30.0f dimensions:CGSizeMake(80, 45) hAlignment:kCCTextAlignmentRight ];
        scoreLabel.position = ccp(size.width/2,190);
        scoreLabel.color = ccc3(0, 0, 0);
        [self addChild:scoreLabel];
        [scoreLabel setScale:0.0f];

        
        startLabel = [[CCLabelTTF alloc] initWithString:[NSString stringWithFormat:@"Ready"] fontName:@"DomoAregato" fontSize:50.0f dimensions:CGSizeMake(130, 45) hAlignment:kCCTextAlignmentCenter];
        startLabel.position = ccp(size.width/2,250);
        startLabel.color = ccc3(0, 0, 0);
        [self addChild:startLabel];
        
        button = [[CCSprite alloc] initWithSpriteFrameName:@"TapButton.png"];
        button.position = ccp(size.width/2,160);
        [self addChild:button];
        [button setScale:0.0f];
        
        resetButton = [[CCSprite alloc] initWithSpriteFrameName:@"Replay.png"];
        resetButton.position = ccp(25, 260);
        [self addChild:resetButton];
        
        
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
        
    }
    [self setup];
    
	return self;
}

-(void)setup{
    started = NO;
    time = 30;
    score = 0;
    
    [button stopAllActions];
    [scoreLabel stopAllActions];
    [startLabel stopAllActions];
    
    [button runAction:[CCScaleTo actionWithDuration:0.3f scale:0.0f]];
    [scoreLabel runAction:[CCScaleTo actionWithDuration:0.3f scale:0.0f]];

    [timerLabel setString:[NSString stringWithFormat:@"Time:%i",time]];
    [scoreLabel setString:[NSString stringWithFormat:@"%i",score]];

    
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"Epic.mp3"];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(begin) object:nil];
    [self performSelector:@selector(begin) withObject:nil afterDelay:3.0f];
    [self unschedule:@selector(timer:)];
    
    [particleSystem stopSystem];

    [ninja robeOff];
    [button runAction:[CCSequence actions:[CCDelayTime actionWithDuration:2.8f],[CCScaleTo actionWithDuration:0.2f scale:1.0f], nil]];
    [scoreLabel runAction:[CCSequence actions:[CCDelayTime actionWithDuration:2.8f],[CCScaleTo actionWithDuration:0.2f scale:1.0f], nil]];
    [startLabel setOpacity:255.0f];
    [startLabel runAction:[CCSequence actions:[CCCallBlock actionWithBlock:^(){
        [startLabel setString:@"Ready"];
    }],[CCDelayTime actionWithDuration:1.4f], [CCScaleTo actionWithDuration:0.1f scale:0.0f], [CCCallBlock actionWithBlock:^(){
        [startLabel setString:@"Set"];
    }],[CCScaleTo actionWithDuration:0.1f scale:1.0f], [CCDelayTime actionWithDuration:1.3f], [CCScaleTo actionWithDuration:0.1f scale:0.0f], [CCCallBlock actionWithBlock:^(){
        [startLabel setString:@"KICK!"];
    }],[CCScaleTo actionWithDuration:0.1f scale:1.0f], [CCDelayTime actionWithDuration:0.5f], [CCFadeOut actionWithDuration:0.5f], nil]];

    
}

-(void)begin{
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Epic.mp3" loop:NO];//play background music

    [self schedule:@selector(timer:) interval:1.0f];
    started = YES;
}

-(void)timer:(ccTime)dt{
    time = time - 1.0f;
    [timerLabel setString:[NSString stringWithFormat:@"Time:%i",time]];
    
    if(time <= 0){
        AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [app setScore:score];
        
        if (score == 0) {
            [[GameCenter sharedGameCenter] reportAchievementIdentifier:@"notaps" percentComplete:100.0f];
        }
        
        [self recordTaps];
        [self recordGames];
        

        
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
        
        CGRect resetRect = [resetButton textureRect];
        resetRect.origin = CGPointZero;
        
        
        if(CGRectContainsPoint(buttonRect, buttonLocation) && started)
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
        
        if(CGRectContainsPoint(resetRect, [resetButton convertToNodeSpace:touchLocation]) && started){
            started = NO;
            [self recordTaps];
            [self setup];
        }
        
    }
    
    
}

-(void)recordTaps{
    int totalTaps = [[NSUserDefaults standardUserDefaults] integerForKey:@"taps"];
    totalTaps+=score;
    [[NSUserDefaults standardUserDefaults] setInteger:totalTaps forKey:@"taps"];
    [[GameCenter sharedGameCenter] reportAchievementIdentifier:@"1000taps" percentComplete:100*(totalTaps/1000.0f)];
    [[GameCenter sharedGameCenter] reportAchievementIdentifier:@"10000taps" percentComplete:100*(totalTaps/10000.0f)];
    [[GameCenter sharedGameCenter] reportAchievementIdentifier:@"25000taps" percentComplete:100*(totalTaps/25000.0f)];
    [[GameCenter sharedGameCenter] reportAchievementIdentifier:@"100000taps" percentComplete:100*(totalTaps/100000.0f)];
}

-(void)recordGames{
    
    int totalGames = [[NSUserDefaults standardUserDefaults] integerForKey:@"gameskey"];
    totalGames++;
    [[NSUserDefaults standardUserDefaults] setInteger:totalGames forKey:@"gameskey"];
    [[GameCenter sharedGameCenter] reportAchievementIdentifier:@"10games" percentComplete:100*(totalGames/10.0f)];
    [[GameCenter sharedGameCenter] reportAchievementIdentifier:@"50games" percentComplete:100*(totalGames/50.0f)];
    [[GameCenter sharedGameCenter] reportAchievementIdentifier:@"100games" percentComplete:100*(totalGames/100.0f)];
    [[GameCenter sharedGameCenter] reportAchievementIdentifier:@"1000games" percentComplete:100*(totalGames/1000.0f)];
}
// on "dealloc" you need to release all your retained objects


@end
