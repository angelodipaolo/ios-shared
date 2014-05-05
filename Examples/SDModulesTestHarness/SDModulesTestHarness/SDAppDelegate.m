//
//  SDAppDelegate.m
//  SDModulesTestHarness
//
//  Created by Steven Woolgar on 04/24/2014.
//  Copyright (c) 2014 Wal-mart Stores, Inc. All rights reserved.
//

#import "SDAppDelegate.h"

#import "SDModulesClient.h"
#import "SDModuleLayoutManager.h"

@implementation SDAppDelegate

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    // Setup and SDModulesClient and fetch layouts

    NSArray* supportedStates = @[@"signedin|signedout", @"instoremode|online-shopping"];
    NSArray* supportedModules = @[@"com.walmart.sdmodulestestharness.ipad.product-feeds",
                                  @"com.walmart.sdmodulestestharness.ipad.merchandising",
                                  @"com.walmart.sdmodulestestharness.ipad.store-information"];

    // Intialize our global copy of the modules client.
    self.moduleClient = [[SDModulesClient alloc] init];

    // Get a default layout to use until the server returns the configured layouts.

    [self.moduleClient setDefaultModuleLayoutsForStates:supportedStates andRegisteredModules:supportedModules];

    // Connect to the server
    [self.moduleClient connectWithApplicationKey:@"com.walmart.sdmodulestestharness.ipad"
                                   andPrivateKey:@"private-key"
                           withCompletionHandler:^(NSError* error)
    {
        if(error == nil)
        {
            // If connection worked, fetch the layouts for our supported states and modules.

            [self.moduleClient moduleLayoutsForStates:supportedStates
                                 andRegisteredModules:supportedModules
                                withCompletionHandler:^(NSDictionary* fetchLayoutsResult, NSError* fetchLayoutsError)
            {
                if(fetchLayoutsError)
                {
                    SDAlertView* errorAlert = [SDAlertView showAlertWithTitle:NSLocalizedString(@"Failed to load module layouts", @"Failed to load module layouts")];
                    [errorAlert show];
                }
                else
                {
                    self.moduleClient.moduleLayoutManager = [SDModuleLayoutManager managerWithDictionary:fetchLayoutsResult];
                }
            }];
        }
    }];

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication*)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication*)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication*)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication*)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication*)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
