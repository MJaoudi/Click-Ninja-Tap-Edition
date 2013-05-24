//
//  GameLayer.h
//  Click Ninja
//
//  Created by Michael Jaoudi on 7/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleAudioEngine.h"
#import "Firework.h"
#import "Ninja.h"

@interface GameLayer : CCLayerColor {
  Firework *firework;
  Ninja *ninja;
  
  int delay;
  
  float timer;
  
  int score;
  
  CCLabelTTF *timerLabel;
  CCLabelTTF *scoreLabel;
  
  CCSprite *button;
}

+(CCScene *) scene;
-(void)timer:(ccTime)dt;


@end
