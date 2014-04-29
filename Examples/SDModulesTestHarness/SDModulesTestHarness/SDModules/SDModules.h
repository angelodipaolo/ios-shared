//
//  SDModules.h
//  SDModules
//
//  Created by Steven Woolgar on 04/28/2014.
//  Copyright (c) 2014 Wal-mart Stores, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SDModulesCredentials;

@interface SDModules : NSObject

@property (nonatomic, strong) NSArray* registeredModules;

+ (instancetype)sharedInstance;
- (SDModulesCredentials*)credentialsWithApplicationKey:(NSString*)applicationKey
                                         andPrivateKey:(NSString*)privateKey;

@end
