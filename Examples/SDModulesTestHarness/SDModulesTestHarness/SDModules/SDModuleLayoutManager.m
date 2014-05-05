//
//  SDModuleLayoutManager.m
//  SDModules
//
//  Created by Steven Woolgar on 05/05/2014.
//  Copyright (c) 2014 Wal-mart Stores, Inc. All rights reserved.
//

#import "SDModuleLayoutManager.h"

@implementation SDModuleLayoutManager

+ (instancetype)managerWithJSONFileURL:(NSURL*)defaultLayoutURL
{
    id model = nil;

//    if (fetchLayoutsResult)
//    {
//        if ([fetchLayoutsResult isKindOfClass:[NSDictionary class]])
//        {
//            model = [[self alloc] init];
//            [model updateWithDictionary:fetchLayoutsResult];
//        }
//        else
//        {
//            NSAssert(NO, @"+[%@ %@] parameter is not dictionary: %@", NSStringFromClass(self), NSStringFromSelector(_cmd), fetchLayoutsResult);
//        }
//    }

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

@end
