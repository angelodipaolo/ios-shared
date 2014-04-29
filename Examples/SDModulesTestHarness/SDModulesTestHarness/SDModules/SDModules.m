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

- (SDModulesCredentials*)credentialsWithApplicationKey:(NSString*)applicationKey
                                         andPrivateKey:(NSString*)privateKey
{
    return nil;
}

@end
