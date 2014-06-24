//
//  SDModuleLayoutManager.h
//  SDModules
//
//  Created by Steven Woolgar on 05/05/2014.
//  Copyright (c) 2014 Wal-mart Stores, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SDLayoutStyle) {
    SDLayoutStyleVerticalStack
};

@interface SDModuleLayoutManager : NSObject

@property (nonatomic, assign) SDLayoutStyle layoutStyle;
@property (nonatomic, strong) NSArray* modulesViewControllers; // Array of UIViewController<SDModuleLayout>
@property (nonatomic, strong) UIViewController* containerViewController;

+ (instancetype)managerWithJSONFileURL:(NSURL*)defaultLayoutURL;
+ (instancetype)managerWithDictionary:(NSDictionary*)fetchLayoutsResult;

- (void)layout;

@end
