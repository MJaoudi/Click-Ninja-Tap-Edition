//
//  GameLayer.h
//  Click Ninja
//
//  Created by Michael Jaoudi on 7/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Firework.h"
#import "Ninja.h"

@interface GameLayer : CCLayer {
  Firework *firework;
  Ninja *ninja;
}

+(CCScene *) scene;


@end
