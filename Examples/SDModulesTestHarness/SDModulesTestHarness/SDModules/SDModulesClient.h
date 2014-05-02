//
//  SDModulesClient.h
//  SDModules
//
//  Created by Steven Woolgar on 04/28/2014.
//  Copyright (c) 2014 Wal-mart Stores, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SDModulesCredentials;
@class SDModuleLayouts;

typedef void (^SDMLayoutsCompletionHandler)(SDModuleLayouts*, NSError*);
typedef void (^SDMConnectCompletionHandler)(NSError*);

@interface SDModulesClient : NSObject

@property (nonatomic, strong) NSArray* registeredModules;

- (void)connectWithApplicationKey:(NSString*)applicationKey andPrivateKey:(NSString*)privateKey withCompletionHandler:(SDMConnectCompletionHandler)completionHandler;
- (SDModuleLayouts*)moduleLayoutsForStates:(NSSet*)applicationStates andRegisteredModules:(NSSet*)modules withCompletionHandler:(SDMLayoutsCompletionHandler)completionHandler;

@end
