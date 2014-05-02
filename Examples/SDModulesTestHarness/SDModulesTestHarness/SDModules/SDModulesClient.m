//
//  SDModulesClient.m
//  SDModules
//
//  Created by Steven Woolgar on 04/28/2014.
//  Copyright (c) 2014 Wal-mart Stores, Inc. All rights reserved.
//

#import "SDModulesClient.h"

#import "SDModulesCredentials.h"

@implementation SDModulesClient

/*
 * Setup a session with the modules server.
 *
 * The application key should be in the form of a reverse dns-like string.
 * com.walmart.market.platform e.g. com.walmart.walmart.ipad or com.walmart.sams.iphone
 */

- (void)connectWithApplicationKey:(NSString*)applicationKey
                    andPrivateKey:(NSString*)privateKey
            withCompletionHandler:(SDMConnectCompletionHandler)completionHandler
{
}

/*
 * Supply a set of states that you support (you will get a layout for each state) as well
 * as a set of modules that you support.
 *
 * This method will return the default layouts to use until the completion handler
 * returns the layouts from the server.
 */

- (SDModuleLayouts*)moduleLayoutsForStates:(NSSet*)applicationStates
                      andRegisteredModules:(NSSet*)modules
                     withCompletionHandler:(SDMLayoutsCompletionHandler)completionHandler
{
    return nil;
}

@end
