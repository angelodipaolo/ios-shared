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

@end
