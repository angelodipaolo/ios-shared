//
//  SDModuleLayout.h
//  Glimpse
//
//  Created by Sam Grover on 6/23/14.
//  Copyright (c) 2014 Walmart. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SDModuleLayout <NSObject>

@property (nonatomic, copy, readonly) NSString* moduleId;
@property (nonatomic, readonly) NSUInteger version;
@property (nonatomic, readonly) NSUInteger contentZone;

@end
