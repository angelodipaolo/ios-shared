//
//  SDModuleController.h
//  SDModules
//
//  Created by Steven Woolgar on 05/05/2014.
//  Copyright (c) 2014 Wal-mart Stores, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SDModuleControllerFactory <NSObject>
- (instancetype)moduleWithDictionary:(NSDictionary*)factoryData;
@end
