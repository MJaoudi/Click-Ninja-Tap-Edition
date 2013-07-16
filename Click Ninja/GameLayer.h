//
//  GameLayer.h
//  Click Ninja
//
//  Created by Mike Jaoudi on 7/4/12.
//  Copyright 2012 Mike Jaoudi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleAudioEngine.h"
#import "Firework.h"
#import "Ninja.h"

@interface GameLayer : CCLayerColor {

}

+(CCScene *) scene;
-(void)timer:(ccTime)dt;


@end
