//
//  AppDelegate.h
//  qxReachability
//
//  Created by Dynamiter on 6/29/13.
//  Copyright (c) 2013 Dynamiter. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Reachability;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    Reachability *internetReach;
}

@property (strong, nonatomic) UIWindow *window;

@end
