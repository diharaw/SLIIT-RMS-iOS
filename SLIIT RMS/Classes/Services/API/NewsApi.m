//
//  NewsApi.m
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 11/30/16.
//  Copyright © 2016 Fidenz. All rights reserved.
//

#import "NewsApi.h"
#import "Consts.h"

#define API_NEWS @"statistics/getNewsAndNotices"

@implementation NewsApi
{
    AFHTTPSessionManager *manager;
}

#pragma mark - Public

- (id) init
{
    self = [super init];
    manager =[AFHTTPSessionManager manager];
    
    return self;
}

-(void) getNews:(void (^)(NSDictionary* response, NSError *error)) block
{
    NSString* url = [NSString stringWithFormat:@"%@/%@", API_BASE_URL, API_NEWS];
    
    [manager POST:url parameters:nil progress:nil
          success:
     ^(NSURLSessionTask *task, id responseObject)
     {
         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
         
         if(httpResponse.statusCode == 200)
         {
             if(responseObject != nil)
             {
                 block(responseObject, nil);
             }
             else
             {
                 NSError* error = [[NSError alloc]init];
                 NSMutableDictionary* ud = [[error userInfo] mutableCopy];
                 [ud setValue:@"Failed to retrieve News" forKey:@"NSLocalizedDescription"];
                 error = [NSError errorWithDomain:@"" code:httpResponse.statusCode userInfo:ud];
                 block(nil, error);
             }
             
         }
         else
         {
             NSError* error = [[NSError alloc]init];
             NSMutableDictionary* ud = [[error userInfo] mutableCopy];
             [ud setValue:@"Failed to retrieve News" forKey:@"NSLocalizedDescription"];
             error = [NSError errorWithDomain:@"" code:httpResponse.statusCode userInfo:ud];
             
             block(nil, error);
         }
     }
          failure:
     ^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error : %@", error);
         block(nil, error);
     }];
}

@end
