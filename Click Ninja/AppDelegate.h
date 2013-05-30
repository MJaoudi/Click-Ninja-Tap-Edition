//
//  AppDelegate.h
//  Click Ninja
//
//  Created by Mike Jaoudi on 7/4/12.
//  Copyright Mike Jaoudi 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate>
{
	UIWindow *window_;
	UINavigationController *navController_;
  
	CCDirectorIOS	*__unsafe_unretained director_;							// weak ref
}

@property (nonatomic, strong) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (unsafe_unretained, readonly) CCDirectorIOS *director;

@end
