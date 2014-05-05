//
//  SDModulesClient.h
//  SDModules
//
//  Created by Steven Woolgar on 04/28/2014.
//  Copyright (c) 2014 Wal-mart Stores, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SDModulesCredentials;
@class SDModuleLayoutManager;

typedef void (^SDMLayoutsCompletionHandler)(NSDictionary*, NSError*);
typedef void (^SDMConnectCompletionHandler)(NSError*);

/*
 * Instantiate this and keep a strong reference to it in a global place. Like your application delegate.
 */

@interface SDModulesClient : NSObject

@property (nonatomic, strong, readonly) NSArray* supportedStates;
@property (nonatomic, strong, readonly) NSArray* registeredModules;
@property (nonatomic, strong) SDModuleLayoutManager* moduleLayoutManager;

/*
 * Get the default layout to use if we can't find the server or it can't return in time for display requirements.
 */

- (void)setDefaultModuleLayoutsForStates:(NSArray*)applicationStates andRegisteredModules:(NSArray*)modules;

/*
 * Setup a session with the modules server.
 *
 * The application key should be in the form of a reverse dns-like string.
 * com.walmart.market.platform e.g. com.walmart.walmart.ipad or com.walmart.sams.iphone
 */

- (void)connectWithApplicationKey:(NSString*)applicationKey andPrivateKey:(NSString*)privateKey withCompletionHandler:(SDMConnectCompletionHandler)completionHandler;

/*
 * Supply a set of states that you support (you will get a layout for each state) as well
 * as a set of modules that you support (registered modules).
 *
 * This method will fetch the layouts given the constraints supplied and return the results from the server in the completion handler.
 */

- (void)moduleLayoutsForStates:(NSArray*)applicationStates andRegisteredModules:(NSArray*)modules withCompletionHandler:(SDMLayoutsCompletionHandler)completionHandler;

@end
