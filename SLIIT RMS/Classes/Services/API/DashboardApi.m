//
//  DashboardApi.m
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 11/18/16.
//  Copyright © 2016 Dihara Wijetunga. All rights reserved.
//

#import "DashboardApi.h"
#import "Consts.h"

#define API_DASHBOARD_STATS @"statistics/getDashBoardStats"

@implementation DashboardApi
{
    AFHTTPSessionManager *manager;
}

#pragma mark - public

- (id) init
{
    self = [super init];
    manager =[AFHTTPSessionManager manager];
    
    return self;
}

-(void) getDashboard:(void (^)(NSDictionary* response, NSError *error)) block
{
    NSString* url = [NSString stringWithFormat:@"%@/%@", API_BASE_URL, API_DASHBOARD_STATS];
    
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
                 [ud setValue:@"Failed to retrieve Dashboard" forKey:@"NSLocalizedDescription"];
                 error = [NSError errorWithDomain:@"" code:httpResponse.statusCode userInfo:ud];
                 block(nil, error);
             }
             
         }
         else
         {
             NSError* error = [[NSError alloc]init];
             NSMutableDictionary* ud = [[error userInfo] mutableCopy];
             [ud setValue:@"Failed to retrieve Dashboard" forKey:@"NSLocalizedDescription"];
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
