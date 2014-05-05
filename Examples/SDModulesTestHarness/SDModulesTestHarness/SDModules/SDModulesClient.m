//
//  SDModulesClient.m
//  SDModules
//
//  Created by Steven Woolgar on 04/28/2014.
//  Copyright (c) 2014 Wal-mart Stores, Inc. All rights reserved.
//

#import "SDModulesClient.h"

#import "SDModuleLayoutManager.h"

@interface SDModulesClient()
@property (nonatomic, strong, readwrite) NSArray* supportedStates;
@property (nonatomic, strong, readwrite) NSDictionary* registeredModules;
@end

@implementation SDModulesClient

/*
 * Setup the default layout to use if we can't find the server or it can't return in time for display requirements.
 */

- (void)setDefaultModuleLayoutsForStates:(NSArray*)applicationStates andRegisteredModules:(NSDictionary*)modules
{
    NSURL* url = [[NSBundle bundleForClass:[self class]] URLForResource:@"SDDefaultModulesLayout" withExtension:@"json"];
    self.moduleLayoutManager = [SDModuleLayoutManager managerWithJSONFileURL:url];
}

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
    if(completionHandler)
        completionHandler(nil);
}

/*
 * Supply a set of states that you support (you will get a layout for each state) as well
 * as a set of modules that you support.
 *
 * This method will fetch the layouts given the constraints supplied in the completion handler
 * from the server.
 */

- (void)moduleLayoutsForStates:(NSArray*)applicationStates
          andRegisteredModules:(NSDictionary*)modules
         withCompletionHandler:(SDMLayoutsCompletionHandler)completionHandler
{
    NSAssert(applicationStates, @"You should probably support at least one application state");
    NSAssert(modules, @"You are required to have at least one registered module");

    self.supportedStates = applicationStates;
    self.registeredModules = modules;

    if(completionHandler)
        completionHandler(@{ @"key" : @"data" }, [NSError errorWithDomain:NSPOSIXErrorDomain code:-1 userInfo:nil]);
}

@end
