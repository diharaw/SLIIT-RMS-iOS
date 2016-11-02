//
//  UserApi.m
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 11/2/16.
//  Copyright © 2016 Dihara Wijetunga. All rights reserved.
//

#import "UserApi.h"
#import "Consts.h"

#define API_AUTH @"auth/token"

@implementation UserApi
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

-(void) login:(NSString*)email withPassword:(NSString*)password withBlock:(void (^)(NSDictionary* response, NSError *error)) block
{
    NSDictionary* requestParameters = @{
                                        @"email": email,
                                        @"password" : password
                                        };
    
    NSString* url = [NSString stringWithFormat:@"%@/%@", API_BASE_URL, API_AUTH];
    
    [manager POST:url parameters:requestParameters progress:nil
          success:
     ^(NSURLSessionTask *task, id responseObject)
     {
         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
         
         if(httpResponse.statusCode == 200)
         {
             if(responseObject != nil)
             {
                 NSInteger code = [[responseObject valueForKey:@"code"] integerValue];
                 
                 if(code == 200)
                     block(responseObject, nil);
                 else
                 {
                     NSError* error = [[NSError alloc]init];
                     NSMutableDictionary* ud = [[error userInfo] mutableCopy];
                     [ud setValue:@"Failed to Login" forKey:@"NSLocalizedDescription"];
                     error = [NSError errorWithDomain:@"" code:code userInfo:ud];
                     block(nil, error);
                 }
             }
             else
             {
                 NSError* error = [[NSError alloc]init];
                 NSMutableDictionary* ud = [[error userInfo] mutableCopy];
                 [ud setValue:@"Failed to Login" forKey:@"NSLocalizedDescription"];
                 error = [NSError errorWithDomain:@"" code:httpResponse.statusCode userInfo:ud];
                 block(nil, error);
             }
             
         }
         else
         {
             NSError* error = [[NSError alloc]init];
             NSMutableDictionary* ud = [[error userInfo] mutableCopy];
             [ud setValue:@"Failed to Login" forKey:@"NSLocalizedDescription"];
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
