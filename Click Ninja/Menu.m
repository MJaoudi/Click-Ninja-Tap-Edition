//
//  Menu.m
//  Click Ninja
//
//  Created by Mike Jaoudi on 5/26/13.
//  Copyright 2013 Mike Jaoudi. All rights reserved.
//

#import "Menu.h"
#import <SimpleAudioEngine.h>
#import "GameLayer.h"

@implementation Menu

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Menu *layer = [Menu node];
	
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
        
        CCLabelTTF *titleLabel = [[CCLabelTTF alloc] initWithString:@"Click Ninja" fontName:@"DomoAregato" fontSize:56.0f dimensions:CGSizeMake(400, 70) hAlignment:kCCTextAlignmentCenter];
        titleLabel.position = ccp(size.width/2, 270);
        titleLabel.color = ccBLACK;
        [self addChild:titleLabel z:1];
        
        CCLabelTTF *subTitleLabel = [[CCLabelTTF alloc] initWithString:@"Tap Edition" fontName:@"DomoAregato" fontSize:30.0f dimensions:CGSizeMake(400, 70) hAlignment:kCCTextAlignmentCenter];
        subTitleLabel.position = ccp(size.width/2, 220);
        subTitleLabel.color = ccBLACK;
        [self addChild:subTitleLabel z:1];
        
        CCSprite *house = [[CCSprite alloc] initWithSpriteFrameName:@"House.png"];
        house.position = ccp(size.width/2, 100);
        house.scale = 0.8;
        [self addChild:house z:1];
        
        CCSprite *hill = [[CCSprite alloc] initWithSpriteFrameName:@"Hill.png"];
        hill.position = ccp(size.width/2+180, 20);
        [self addChild:hill z:0];
        
        CCSprite *hill2 = [[CCSprite alloc] initWithSpriteFrameName:@"Hill.png"];
        hill2.position = ccp(size.width/2-200, 20);
        [self addChild:hill2 z:0];
        
        CCSprite *grass = [[CCSprite alloc] initWithSpriteFrameName:@"Grass.png"];
        grass.position = ccp(grass.contentSize.width/2, grass.contentSize.height/2);
        [self addChild:grass z:10];
        
        for(int x=grass.contentSize.width; x<size.width; x+=grass.contentSize.width/2){
            grass = [[CCSprite alloc] initWithSpriteFrameName:@"Grass.png"];
            grass.position = ccp(x+grass.contentSize.width/2, grass.contentSize.height/2);
            [self addChild:grass z:10];
        }
        
       CCSprite *tree = [[CCSprite alloc] initWithSpriteFrameName:@"Tree3.png"];
        tree.position = ccp(size.width/2+220, 130);
        [self addChild:tree z:4];
        
        CCSprite *tree2 = [[CCSprite alloc] initWithSpriteFrameName:@"Tree3.png"];
        tree2.position = ccp(size.width/2-240, 120);
        [self addChild:tree2 z:4];
        
        CCSprite *cloud = [[CCSprite alloc] initWithSpriteFrameName:@"Cloud_2.png"];
        cloud.position = ccp(-100, 280);
        cloud.scale = 0.5;
        [self addChild:cloud z:0];
        
        [cloud runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCMoveTo actionWithDuration:30.0 position:CGPointMake(size.width+100, cloud.position.y)], [CCMoveTo actionWithDuration:0.0 position:CGPointMake(-cloud.contentSize.width-100, cloud.position.y)],nil]]];
        
      /*  CCSprite *ninja = [[CCSprite alloc] initWithSpriteFrameName:@"CrawlNinja_1.png"];
        [ninja setScale:0.7];
        ninja.position = ccp(size.width/2, house.position.y+house.contentSize.height/2+ninja.contentSize.height/2);

        [self addChild:ninja];
        ninja.position = ccp(size.width/2-90, house.position.y+house.contentSize.height/2 - ninja.contentSize.height/2+2);
        [ninja runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCMoveTo actionWithDuration:3.0 position:CGPointMake(size.width/2+90, ninja.position.y)],[CCScaleTo actionWithDuration:0 scaleX:-0.7 scaleY:0.7],[CCMoveTo actionWithDuration:3.0 position:CGPointMake(size.width/2-90, ninja.position.y)],[CCScaleTo actionWithDuration:0 scaleX:0.7 scaleY:0.7],nil]]];
        
        CCAnimation *walk = [CCAnimation animationWithSpriteFrames:
                             @[[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"CrawlNinja_1.png"],
                             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"CrawlNinja_2.png"],
                             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"CrawlNinja_3.png"],
                             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"CrawlNinja_4.png"]] delay:0.18f];
        [ninja runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walk]]];*/
        
        
        CCSprite *crouchNinja = [[CCSprite alloc] initWithSpriteFrameName:@"CrouchNinja_1.png"];
        crouchNinja.position = ccp(size.width/2+110, 298);
        [crouchNinja setScale:0.6];
        [self addChild:crouchNinja];
        
        
        CCMenuItemSprite *play = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"Sign.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"Sign.png"] target:self selector:@selector(play)];
        [play setScale:0.8f];
        CCMenu *menu = [CCMenu menuWithItems:play, nil];
        menu.position = ccp(size.width/2, 62);
        [self addChild:menu z:10];
        
        
        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Menu.mp3" loop:YES];
        
        

    }
    
    return self;
}

-(void)play{
    [[CCDirector sharedDirector] replaceScene:[GameLayer scene]];
}

@end
