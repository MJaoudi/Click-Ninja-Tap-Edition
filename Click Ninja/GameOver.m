//
//  GameLayer.m
//  Click Ninja
//
//  Created by Mike Jaoudi on 7/4/12.
//  Copyright 2012 Mike Jaoudi. All rights reserved.
//

#import "GameOver.h"
#import "GameLayer.h"

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
	if( (self=[super init]) ) {
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        [CCMenuItemFont setFontName:@"DomoAregato"];
        CCMenuItem *item = [CCMenuItemFont itemWithString:@"Play Again!" block:^(id sender) {
            [[CCDirector sharedDirector] replaceScene:[GameLayer scene]];
        }];
        CCMenu *menu = [CCMenu menuWithItems:item, nil];
		[menu setPosition:ccp(size.width/2, 60)];
        [self addChild:menu];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"HighscoreMusic.wav" loop:YES];
        
        
    }
	return self;
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
