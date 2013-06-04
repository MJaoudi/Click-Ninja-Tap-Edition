//
//  AppDelegate.h
//  Click Ninja
//
//  Created by Mike Jaoudi on 7/4/12.
//  Copyright Mike Jaoudi 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TargetConditionals.h>
#import "cocos2d.h"

@interface AppDelegate : NSObject <UIApplicationDelegate, CCDirectorDelegate>
{
	UIWindow *window_;
	UINavigationController *navController_;
  
	CCDirectorIOS	*__unsafe_unretained director_;							// weak ref
}

@property (nonatomic, strong) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (unsafe_unretained, readonly) CCDirectorIOS *director;
@property (nonatomic) NSUInteger score;

@end
