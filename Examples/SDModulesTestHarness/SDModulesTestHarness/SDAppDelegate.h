//
//  SDAppDelegate.h
//  SDModulesTestHarness
//
//  Created by Steven Woolgar on 04/24/2014.
//  Copyright (c) 2014 Wal-mart Stores, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SDModulesClient;

@interface SDAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow* window;
@property (nonatomic, strong) SDModulesClient* moduleClient;

@end
