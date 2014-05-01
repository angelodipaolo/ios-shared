//
//  SDModules.h
//  SDModules
//
//  Created by Steven Woolgar on 04/28/2014.
//  Copyright (c) 2014 Wal-mart Stores, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SDModulesCredentials;
@class SDModuleLayouts;

typedef void (^SDMCompletionHandler)(SDModuleLayouts*, NSError*);

@interface SDModules : NSObject

@property (nonatomic, strong) NSArray* registeredModules;

+ (instancetype)sharedInstance;
- (SDModulesCredentials*)credentialsWithApplicationKey:(NSString*)applicationKey andPrivateKey:(NSString*)privateKey;
- (SDModuleLayouts*)moduleLayoutsForStates:(NSSet*)applicationStates andRegisteredModules:(NSSet*)modules withCompletionHandler:(SDMCompletionHandler)completionHandler;

@end
