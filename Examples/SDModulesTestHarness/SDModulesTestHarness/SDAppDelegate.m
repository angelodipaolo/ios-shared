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

#import "SDPullNavigation.h"
#import "SDPullNavigationBar.h"
#import "CustomPullNavigationBarTabButton.h"
#import "SDHomeScreenViewController.h"
#import "SDOrderHistoryViewController.h"

#import "SDMTProductFeedModuleController.h"
#import "SDMTMerchandisingModuleController.h"
#import "SDMTStoreInformationModuleController.h"

@interface SDAppDelegate()<SDPullNavigationSetupProtocol>
@property (nonatomic, strong) SDHomeScreenViewController* homeScreenViewController;
@property (nonatomic, strong) SDOrderHistoryViewController* orderHistoryController;
@end

@implementation SDAppDelegate

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    // Apply global menu appearance

    [SDPullNavigationBar setupDefaults];

    [[NSBundle bundleForClass:[self class]] loadNibNamed:@"MainWindow" owner:self options:nil];
    [SDPullNavigationManager sharedInstance].delegate = self;

    self.window.rootViewController = [SDPullNavigationManager sharedInstance].globalPullNavController;
    [self.window addSubview:[SDPullNavigationManager sharedInstance].globalPullNavController.view];
    [self.window makeKeyAndVisible];
    
    // Setup and SDModulesClient and fetch layouts

    NSArray* supportedStates = @[ @"signedin|signedout", @"instoremode|online-shopping" ];
    NSDictionary* supportedModules = @{ @"product-feeds"     : [SDMTProductFeedModuleController class],
                                        @"merchandising"     : [SDMTMerchandisingModuleController class],
                                        @"store-information" : [SDMTStoreInformationModuleController class] };

    // Intialize our global copy of the modules client.

    self.moduleClient = [[SDModulesClient alloc] init];

    // Get a default layout to use until the server returns the configured layouts.

    [self.moduleClient setDefaultModuleLayoutsForStates:supportedStates andRegisteredModules:supportedModules];

    // Connect to the server.

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
}

- (void)applicationDidEnterBackground:(UIApplication*)application
{
}

- (void)applicationWillEnterForeground:(UIApplication*)application
{
}

- (void)applicationDidBecomeActive:(UIApplication*)application
{
}

- (void)applicationWillTerminate:(UIApplication*)application
{
}

#pragma mark - SDPullNavigationSetup methods

- (void)setupNavigationBar
{
    // Todo, chop this asset up and make it stretchable so that we can have variable sized adornments.

    UIImage* stretchImage = [[UIImage imageNamed:@"global-menu-adornment-shelf"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,9,0,9)];
    UIImage* tabImage = [UIImage imageNamed:@"global-menu-adornment-tab"];
    UIImage* globalMenuAdornment = [UIImage stretchImage:stretchImage
                                                  toSize:(CGSize){ 320.0f, stretchImage.size.height }
                                         andOverlayImage:tabImage
                                             withOptions:SDImageCompositeOptionsPinSourceToTop |
                                    SDImageCompositeOptionsCenterXOverlay |
                                    SDImageCompositeOptionsPinOverlayToBottom];

    [SDPullNavigationManager sharedInstance].pullNavigationBarViewClass = [SDPullNavigationBarControlsView class];
    [SDPullNavigationManager sharedInstance].pullNavigationBarTabButtonClass = [CustomPullNavigationBarTabButton class];
    [SDPullNavigationManager sharedInstance].globalMenuStoryboardId = @"SDGlobalNavMenu";
    [SDPullNavigationManager sharedInstance].menuAdornmentImageOverlapHeight = stretchImage.size.height;
    [SDPullNavigationManager sharedInstance].menuAdornmentBottomGap = 64.0f;

    // Either use the globalMenuAdornment image or the three part one if you need it to stretch to fit a variable width adornment view.


    if(1)
    {
        [[SDPullNavigationManager sharedInstance] menuAdornmentImageWithStretchImage:stretchImage
                                                                      andCenterImage:tabImage
                                                                  compositionOptions:SDImageCompositeOptionsPinSourceToTop |
         SDImageCompositeOptionsCenterXOverlay |
         SDImageCompositeOptionsPinOverlayToBottom];
    }
    else
    {
        [SDPullNavigationManager sharedInstance].menuAdornmentImage = globalMenuAdornment;
    }
}

- (void)setupNavigationBarItems
{
    SDPullNavigationBarControlsView* leftBar = (SDPullNavigationBarControlsView*)[[SDPullNavigationManager sharedInstance] leftBarItemsView];
    SDPullNavigationBarControlsView* rightBar = (SDPullNavigationBarControlsView*)[[SDPullNavigationManager sharedInstance] rightBarItemsView];

    UIButton* leftTestButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [leftTestButton addTarget:self action:@selector(leftTestPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIButton* rightTestButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [rightTestButton addTarget:self action:@selector(rightTestPressed:) forControlEvents:UIControlEventTouchUpInside];

    [leftBar addBarItem:leftTestButton];
    [rightBar addBarItem:rightTestButton];
}

- (SDContainerViewController*)setupGlobalContainerViewController
{
    SDContainerViewController* globalPullNavController = [[SDContainerViewController alloc] initWithNibName:nil bundle:nil];

    self.homeScreenViewController  = [SDHomeScreenViewController loadFromStoryboardNamed:@"HomeScreen" identifier:@"SDHomeScreenViewController"];
	self.orderHistoryController = [SDOrderHistoryViewController loadFromStoryboardNamed:@"OrderHistory" identifier:@"SDOrderHistoryViewController"];

    globalPullNavController.viewControllers = @[ [SDPullNavigationBar navControllerWithViewController:self.homeScreenViewController],
												 [SDPullNavigationBar navControllerWithViewController:self.orderHistoryController]];

    return globalPullNavController;
}

- (void)leftTestPressed:(id)sender
{
    SDLog(@"Hit left nav button");
}

- (void)rightTestPressed:(id)sender
{
    SDLog(@"Hit right nav button");
}

@end
