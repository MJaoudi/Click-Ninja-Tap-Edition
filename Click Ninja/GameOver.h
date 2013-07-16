//
//  GameOver.h
//  Click Ninja
//
//  Created by Mike Jaoudi on 7/9/12.
//  Copyright 2012 Mike Jaoudi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AdMob/GADBannerView.h>
#import "cocos2d.h"

@interface GameOver : CCLayerColor {
    GADBannerView *_banner;

}

+(CCScene *) scene;

@end
