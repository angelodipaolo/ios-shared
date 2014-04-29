//
//  SDModules.h
//  SDModules
//
//  Created by Steven Woolgar on 04/28/2014.
//  Copyright (c) 2014 Wal-mart Stores, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDModulesCredentials : NSObject <NSCopying>

@property (nonatomic, readonly) NSString* applicationKey;
@property (nonatomic, readonly) NSString* privateKey;

@end
