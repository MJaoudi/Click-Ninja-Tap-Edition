//
//  Instructions.m
//  Click Ninja
//
//  Created by Mike Jaoudi on 6/4/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <SimpleAudioEngine.h>
#import <FlurrySDK/Flurry.h>

#import "Instructions.h"
#import "GameCenter.h"
#import "GameLayer.h"

@implementation Instructions

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Instructions *layer = [Instructions node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super initWithColor:ccc4(103,151,223,255)]) ) {
        [self setTouchEnabled:YES];
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        
        CCSprite *hill = [[CCSprite alloc] initWithSpriteFrameName:@"Hill.png"];
        hill.position = ccp(size.width/2-120, 20);
        [self addChild:hill z:0];
        
        CCSprite *hill2 = [[CCSprite alloc] initWithSpriteFrameName:@"Hill.png"];
        hill2.position = ccp(size.width/2+150, 40);

        [self addChild:hill2 z:0];
        
        CCNode *leftHouse = [CCNode node];
        
        
        CCSprite *house = [[CCSprite alloc] initWithSpriteFrameName:@"House.png"];
        house.position = ccp(size.width/2, 100);
        house.scale = 0.8;
        [leftHouse addChild:house z:1];
        

        
        
        for (int x=0; x<2; x++) {
            CCSprite *leftBush = [[CCSprite alloc] initWithSpriteFrameName:@"Tree2.png"];
            leftBush.position = ccp(size.width/2 - leftBush.contentSize.width*x - 50, 24);
            [leftHouse addChild:leftBush z:10];
            
            CCSprite *rightBush = [[CCSprite alloc] initWithSpriteFrameName:@"Tree1.png"];
            rightBush.position = ccp(size.width/2 + rightBush.contentSize.width*x + 50, 24);
            [leftHouse addChild:rightBush z:10];
            
        }
        
        CCSprite *tree = [[CCSprite alloc] initWithSpriteFrameName:@"Tree3.png"];
        tree.position = ccp(size.width/2+220, 140);
        [leftHouse addChild:tree z:4];
        
        CCSprite *tree2 = [[CCSprite alloc] initWithSpriteFrameName:@"Tree3.png"];
        tree2.position = ccp(size.width/2-240, 140);
        [leftHouse addChild:tree2 z:4];
        
        CCSprite *cloud = [[CCSprite alloc] initWithSpriteFrameName:@"Cloud_2.png"];
        cloud.position = ccp(-cloud.contentSize.width/2, 280);
        cloud.scale = 0.5;
        [self addChild:cloud z:0];
        
        [cloud runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCMoveTo actionWithDuration:30.0 position:CGPointMake(size.width+100, cloud.position.y)], [CCMoveTo actionWithDuration:0.0 position:CGPointMake(-cloud.contentSize.width-100, cloud.position.y)],nil]]];
        
        
        CCSprite *blackNinja = [[CCSprite alloc] initWithSpriteFrameName:@"BlackNinja.png"];
        blackNinja.position = ccp(size.width/2-178, 218);
        [blackNinja setScale:0.6];
        [leftHouse addChild:blackNinja z:10];
        
        CCSprite *swordNinja = [[CCSprite alloc] initWithSpriteFrameName:@"SwordNinja.png"];
        swordNinja.position = ccp(size.width/2-110, 32);
        [swordNinja setScale:0.8];
        [leftHouse addChild:swordNinja z:20];
        
        CCSprite *rock = [[CCSprite alloc] initWithSpriteFrameName:@"Rocks.png"];
        rock.position = ccp(size.width/2-180, 0);
        [rock setScale:.7];
        [leftHouse addChild:rock z:10];
        
    
        
        leftHouse.position = ccp(size.width/2-216, 68);
        [leftHouse setScale:0.4];
        [self addChild:leftHouse];
        
        
        CCSprite *ninja = [[CCSprite alloc] initWithSpriteFrameName:@"RobeNinja_1.png"];
        ninja.position = ccp(size.width/2+90,102);
        [ninja setScale:0.3];
        [self addChild:ninja z:10];
        
        
        CCLabelTTF *helpText = [[CCLabelTTF alloc] initWithString:@"Tap the ninja power button as fast as you can before the time runs out." fontName:@"DomoAregato" fontSize:24.0f dimensions:CGSizeMake(200, 200) hAlignment:kCCTextAlignmentLeft];
        helpText.position = ccp(size.width/2 + 130, 160);
        helpText.color = ccBLACK;
        [self addChild:helpText z:1];
        
        CCMenuItemSprite *begin = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"BeginButton.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"BeginButton_selected.png"] block:^(id sender){
            
            [Flurry logEvent:@"Help Play"];
            [[CCDirector sharedDirector] replaceScene:[GameLayer scene]];
        }];
        [begin setScale:0.8f];
        begin.position = ccp(size.width/2 + 150, 140);
        
        CCMenu *buttonMenu = [CCMenu menuWithItems:begin, nil];
        buttonMenu.position = CGPointZero;
        [self addChild:buttonMenu z:10];
        
        CCLabelTTF *aboutText = [[CCLabelTTF alloc] initWithString:@"Programmed by pH and Scrabble.\nBased on the game created by Cajun." fontName:@"DomoAregato" fontSize:20.0f dimensions:CGSizeMake(300, 50) hAlignment:kCCTextAlignmentRight];
        aboutText.position = ccp(size.width/2 + 90, 30);
        aboutText.color = ccBLACK;
        [self addChild:aboutText z:1];
        
        
        [[GameCenter sharedGameCenter] reportAchievementIdentifier:@"help" percentComplete:100.0f];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Instructions.mp3" loop:YES];
        
        
        
    }
    
    return self;
}

@end
