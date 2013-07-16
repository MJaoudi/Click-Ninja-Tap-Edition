//
//  Ninja.h
//  Click Ninja
//
//  Created by Mike Jaoudi on 7/6/12.
//  Copyright 2012 Mike Jaoudi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Ninja : CCSprite {
    CCAnimation *sword;
    CCAnimation *jump;
    CCAnimation *kick;
    CCAnimation *land;
    CCAnimation *start;
        
    BOOL kicking;
}

-(void)robeOff;
-(void)startKicking;
-(void)stopKicking;
@end
