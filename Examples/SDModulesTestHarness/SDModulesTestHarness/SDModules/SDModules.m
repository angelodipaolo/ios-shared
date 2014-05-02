//
//  SDModules.m
//  SDModules
//
//  Created by Steven Woolgar on 04/28/2014.
//  Copyright (c) 2014 Wal-mart Stores, Inc. All rights reserved.
//

#import "SDModules.h"

#import "SDModulesCredentials.h"

@implementation SDModules

+ (instancetype)sharedInstance
{
	static dispatch_once_t oncePredicate;
	static id sSharedInstance = nil;
	dispatch_once(&oncePredicate, ^
    {
        sSharedInstance = [[[self class] alloc] init];
    });

	return sSharedInstance;
}

/*
 * Setup a session with the modules server.
 * The application key should be in the form of a reverse dns-like string.
 * com.walmart.market.platform e.g. com.walmart.walmart.ipad or com.walmart.sams.iphone
 */

- (SDModulesCredentials*)credentialsWithApplicationKey:(NSString*)applicationKey
                                         andPrivateKey:(NSString*)privateKey
{
    return nil;
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
                     withCompletionHandler:(SDMCompletionHandler)completionHandler
{
    return nil;
}

@end
