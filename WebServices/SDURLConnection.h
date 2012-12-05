//
//  SDURLConnection.h
//  ServiceTest
//
//  Created by Brandon Sneed on 11/3/11.
//  Copyright (c) 2011 SetDirection. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 SDURLConnection is a subclass of NSURLConnection that manages the concurrency and queueing of multiple asynchronous connections.
 Requests are added to the queue using sendAsynchronousRequest:shouldCache:withResponseHandler:.
 
 ### Blocks in use are defined as: ###
    typedef void (^SDURLConnectionResponseBlock)(SDURLConnection *connection, NSURLResponse *response, NSData *responseData, NSError *error);
 */

@class SDURLConnection;
@class SDURLConnectionAsyncDelegate;

typedef void (^SDURLConnectionResponseBlock)(SDURLConnection *connection, NSURLResponse *response, NSData *responseData, NSError *error);

@interface SDURLConnection : NSURLConnection

/**
 Returns the maximum number of concurrent connections allowed.
 */
+ (NSInteger)maxConcurrentAsyncConnections;

/**
 Set the maximum number of concurrent connections allowed to `maxCount`. The default is `4`.
 */
+ (void)setMaxConcurrentAsyncConnections:(NSInteger)maxCount;

/**
 Create a connection for the given request parameters.
 @param request The URL request.
 @param cache Indicates if the URL response should be cached.
 @param handler The block to execute when the response has been received completely.
 */
+ (SDURLConnection *)sendAsynchronousRequest:(NSURLRequest *)request shouldCache:(BOOL)cache withResponseHandler:(SDURLConnectionResponseBlock)handler;

@end
