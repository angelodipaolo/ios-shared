//
//  SDImageCache.h
//  ios-shared
//
//  Created by Brandon Sneed on 7/10/13.
//  Copyright (c) 2013 SetDirection. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^UIImageViewURLCompletionBlock)(UIImage *image, NSError *error);

@interface SDImageCache : NSObject
{
    NSMutableDictionary *_activeConnections;
    NSMutableDictionary *_memoryCache;
    NSOperationQueue *_decodeQueue;

    NSUInteger _imageCounter;
}

@property (atomic, assign) NSUInteger memoryCacheSize;

+ (SDImageCache *)sharedInstance;

- (NSUInteger)actualMemoryCacheSize;

- (BOOL)isImageURLInProgress:(NSURL *)url;
- (void)fetchImageAtURL:(NSURL *)url completionBlock:(UIImageViewURLCompletionBlock)completionBlock;
- (void)cancelFetchForURL:(NSURL *)url;
- (void)removeImageURLFromCache:(NSURL *)url;
- (void)addImageToMemoryCache:(UIImage *)image withURL:(NSURL *)url;

@end
