//
//  GameLayer.m
//  Click Ninja
//
//  Created by Mike Jaoudi on 7/4/12.
//  Copyright 2012 Mike Jaoudi. All rights reserved.
//

#import "GameOver.h"
#import "GameLayer.h"
#import "AppDelegate.h"
#import "GameCenter.h"
#import "Menu.h"

@implementation GameOver
// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameOver *layer = [GameOver node];
	
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
        
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        CCSprite *ninja = [[CCSprite alloc] initWithSpriteFrameName:@"RobeNinja_1.png"];
        ninja.position = ccp(size.width/2-90,210);
        ninja.anchorPoint = ccp(0.5,.7);
        [ninja setScale:0.8];
        [self addChild:ninja z:10];
        
        CCLabelTTF *scoreLabel = [[CCLabelTTF alloc] initWithString:[NSString stringWithFormat:@"You got %i points",app.score] fontName:@"DomoAregato" fontSize:30.0f dimensions:CGSizeMake(300, 45) hAlignment:kCCTextAlignmentCenter ];
        scoreLabel.position = ccp(size.width/2-90,290);
        scoreLabel.color = ccc3(0, 0, 0);
        [self addChild:scoreLabel];
        
        int highscore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highscore"];
        
        if(app.score > highscore){
            highscore = app.score;
            [[NSUserDefaults standardUserDefaults] setInteger:highscore forKey:@"highscore"];
        }
        
        
        
        CCLabelTTF *highscoreLabel = [[CCLabelTTF alloc] initWithString:[NSString stringWithFormat:@"Highscore: %i points",highscore] fontName:@"DomoAregato" fontSize:30.0f dimensions:CGSizeMake(300, 45) hAlignment:kCCTextAlignmentCenter ];
        highscoreLabel.position = ccp(size.width/2-90,250);
        highscoreLabel.color = ccc3(0, 0, 0);
        [self addChild:highscoreLabel];
        
        
        CCSprite *hill = [[CCSprite alloc] initWithSpriteFrameName:@"Hill.png"];
        hill.position = ccp(size.width/2-90, 60);
        [self addChild:hill z:0];
        
        CCSprite *hill2 = [[CCSprite alloc] initWithSpriteFrameName:@"Hill.png"];
        hill2.position = ccp(size.width/2+190, 40);
        [self addChild:hill2 z:0];
        
        CCSprite *tree = [[CCSprite alloc] initWithSpriteFrameName:@"Tree3.png"];
        tree.position = ccp(size.width/2+190,220);
        [self addChild:tree];
        
        
        CCMenuItemSprite *gameCenter = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"GameCenter.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"GameCenter_selected.png"] block:^(id sender){
            
            [[GameCenter sharedGameCenter] showLeaderboard];
            
        }];
        [gameCenter setScale:0.8f];
        gameCenter.position = ccp(size.width/2+140, 120);
        
        CCMenuItemSprite *again = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"AgainButton.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"AgainButton.png"] block:^(id sender){
            
            [[CCDirector sharedDirector] replaceScene:[GameLayer scene]];
        }];
        again.position = ccp(size.width/2-90, 130);
        
        CCMenuItemSprite *menuButton = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"MenuButton.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"MenuButton.png"] block:^(id sender){
            [[CCDirector sharedDirector] replaceScene:[Menu scene]];

        }];
        menuButton.position = ccp(size.width/2+40, 60);
        
        CCSprite *swordNinja = [[CCSprite alloc] initWithSpriteFrameName:@"SwordNinja.png"];
        [swordNinja setScale:1.0];
        [swordNinja setScaleX:-1.0];
        swordNinja.position = ccp(menuButton.position.x, menuButton.position.y+menuButton.contentSize.height/2+swordNinja.contentSize.height*swordNinja.scaleY/2-4);
        [self addChild:swordNinja z:20];

        
        
        CCMenu *menu = [CCMenu menuWithItems:again, gameCenter, menuButton, nil];
        menu.position = CGPointZero;
        [self addChild:menu];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"HighscoreMusic.wav" loop:YES];
        
        [[GameCenter sharedGameCenter] reportScore:app.score forLeaderboard:@"leaderboard"];
        
    }
	return self;
}

-(void)gameCenter{
}

@end
