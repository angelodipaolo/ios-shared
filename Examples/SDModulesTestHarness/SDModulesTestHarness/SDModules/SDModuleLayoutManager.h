//
//  SDModuleLayoutManager.h
//  SDModules
//
//  Created by Steven Woolgar on 05/05/2014.
//  Copyright (c) 2014 Wal-mart Stores, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SDModuleContainer;

@interface SDModuleLayoutManager : NSObject

@property (nonatomic, strong) SDModuleContainer* moduleLayoutContainer;

+ (instancetype)managerWithJSONFileURL:(NSURL*)defaultLayoutURL;
+ (instancetype)managerWithDictionary:(NSDictionary*)fetchLayoutsResult;

@end
