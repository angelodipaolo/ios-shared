//
//  SDModuleLayoutManager.m
//  SDModules
//
//  Created by Steven Woolgar on 05/05/2014.
//  Copyright (c) 2014 Wal-mart Stores, Inc. All rights reserved.
//

#import "SDModuleLayoutManager.h"

@implementation SDModuleLayoutManager

- (id)init
{
    self = [super init];
    if (self)
    {
        self.layoutStyle = SDLayoutStyleVerticalStack;
    }
    return self;
}

+ (instancetype)managerWithJSONFileURL:(NSURL*)defaultLayoutURL
{
    NSAssert(defaultLayoutURL, @"Must provide URL for the layout JSON file to be used as a default.");

    id model = nil;

    NSError* jsonParserError = nil;
    NSData* jsonData = [NSData dataWithContentsOfURL:defaultLayoutURL];
    id layoutJSON = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&jsonParserError];

    if (jsonParserError == nil)
    {
        if ([layoutJSON isKindOfClass:[NSDictionary class]])
        {
            model = [[self alloc] init];
            [model updateWithDictionary:layoutJSON];
        }
        else
        {
            NSAssert(NO, @"+[%@ %@] parameter is not dictionary: %@", NSStringFromClass(self), NSStringFromSelector(_cmd), layoutJSON);
        }
    }

    return model;
}

+ (instancetype)managerWithDictionary:(NSDictionary*)fetchLayoutsResult
{
    id model = nil;

    if (fetchLayoutsResult)
    {
        if ([fetchLayoutsResult isKindOfClass:[NSDictionary class]])
        {
            model = [[self alloc] init];
            [model updateWithDictionary:fetchLayoutsResult];
        }
        else
        {
            NSAssert(NO, @"+[%@ %@] parameter is not dictionary: %@", NSStringFromClass(self), NSStringFromSelector(_cmd), fetchLayoutsResult);
        }
    }

    return model;
}

- (void)updateWithDictionary:(NSDictionary*)dictionary
{
}

+ (NSURL*)urlForResource:(NSString *)resource ofType:(NSString *)type andClass:(Class)aClass
{
    NSURL *url = [[NSBundle bundleForClass:aClass] URLForResource:resource withExtension:type];

    return url;
}

+ (NSData *)dataForResource:(NSString *)resource ofType:(NSString *)type andClass:(Class)aClass
{
    NSURL *url = [self urlForResource:resource ofType:type andClass:aClass];

    return [NSData dataWithContentsOfURL:url];
}

+ (id)jsonObjectForResource:(NSString *)resource andClass:(Class)aClass
{
    NSData *data = [self dataForResource:resource ofType:@"json" andClass:aClass];
    NSError *error = nil;

    return [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
}

- (void)layout
{
    if (self.modulesViewControllers.count == 0)
    {
        return;
    }
    
    // First remove any existing child VCs.
    // TODO: Keep the ones that are in the incoming array.
    NSArray* children = [NSArray arrayWithArray:self.containerViewController.childViewControllers];
    [children enumerateObjectsUsingBlock:^(UIViewController* aChildVC, NSUInteger idx, BOOL *stop)
     {
         [aChildVC.view removeFromSuperview];
         [aChildVC removeFromParentViewController];
     }];
    
    // Remove any other views, such as the backing scroll view
    [self.containerViewController.view.subviews enumerateObjectsUsingBlock:^(UIView* aSubview, NSUInteger idx, BOOL *stop)
    {
        [aSubview removeFromSuperview];
    }];
    
    NSAssert(self.containerViewController.childViewControllers != 0, @"Container still has children!");
    
    if (self.layoutStyle == SDLayoutStyleVerticalStack)
    {
        UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:self.containerViewController.view.bounds];
        [self.containerViewController.view addSubview:scrollView];
        CGFloat heightPerView = 300.0f;
        [self.modulesViewControllers enumerateObjectsUsingBlock:^(UIViewController* aVC, NSUInteger idx, BOOL *stop)
        {
            [aVC willMoveToParentViewController:self.containerViewController];
            [self.containerViewController addChildViewController:aVC];
            [aVC didMoveToParentViewController:self.containerViewController];
            aVC.view.frame = CGRectMake(0.0f, heightPerView * idx, self.containerViewController.view.bounds.size.width, heightPerView);
            [scrollView addSubview:aVC.view];
        }];
        scrollView.contentSize = CGSizeMake(scrollView.bounds.size.width, heightPerView * self.modulesViewControllers.count);
    }
}

@end
