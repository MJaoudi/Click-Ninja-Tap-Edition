//
//  Firework.h
//  Click Ninja
//
//  Created by Michael Jaoudi on 7/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum{
  kBlueFirework = 62,
  kRedFirekork = 56,
  kGreenFirework = 49
}FireworkColor;

@interface Firework : CCSpriteBatchNode {
  CCAnimation *redExplosion;
  CCAnimation *blueExplosion;
  CCAnimation *greenExplosion;
  NSMutableArray *fireworks;
  int index;
}

-(void)fire;

@end
