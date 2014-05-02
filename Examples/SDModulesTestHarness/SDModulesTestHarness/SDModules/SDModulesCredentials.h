//
//  SDModules.h
//  SDModules
//
//  Created by Steven Woolgar on 04/28/2014.
//  Copyright (c) 2014 Wal-mart Stores, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SDModulesClientCredentials <NSObject, NSCopying>

/**
 * Provides the application key.
 * @returns The application key.
 */
@required
@property (nonatomic, readonly) NSString* applicationKey;

/**
 * Provides the private key.
 * @returns The private key.
 */
@required
@property (nonatomic, readonly) NSString* privateKey;

@end
