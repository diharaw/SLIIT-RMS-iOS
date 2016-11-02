//
//  UserSync.m
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 11/2/16.
//  Copyright © 2016 Dihara Wijetunga. All rights reserved.
//

#import "UserSync.h"
#import "UserApi.h"
#import "User.h"

@implementation UserSync
{
    UserApi* userAPI;
}

- (id) init
{
    self = [super init];
    userAPI = [[UserApi alloc] init];
    return self;
}

+ (UserSync *) sharedCenter
{
    static dispatch_once_t once;
    static UserSync * sharedInstance;
    dispatch_once(&once, ^{ sharedInstance = [[self alloc] init]; });
    return sharedInstance;
}

#pragma mark - public

- (void) startLoginSync: (NSString*)email withPassword:(NSString*)password
{
    [userAPI login:email withPassword:password withBlock:^(NSDictionary *response, NSError *error)
     {
         [self processLoginResponse:response withEmail:email withPassword:password withError:error];
     }];
}

#pragma mark - private

- (void)processLoginResponse:(NSDictionary*)response  withEmail:(NSString*)email withPassword:(NSString*)password withError:(NSError*)error
{
    if(response != nil)
    {
        [User truncate];
        
        User* user = [[User alloc] init];
        user.email = email;
        user.password = password;
        
        user.apiKey = [response valueForKey:@"data"];
        
        [user save];
        
        [self.delegate onLoginSyncComplete:nil];
    }
    else
        [self.delegate onLoginSyncComplete:error];
}

@end
