//
//  Ninja.h
//  Click Ninja
//
//  Created by Michael Jaoudi on 7/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Ninja : CCSpriteBatchNode {
  CCAnimation *sword;
  CCAnimation *jump;
  CCAnimation *kick;
  CCAnimation *land;
  
  CCSprite *ninja;
  
  BOOL kicking;
}

-(void)startKicking;
-(void)stopKicking;
@end
