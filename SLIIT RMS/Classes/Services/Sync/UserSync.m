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

- (void) startProfileSync
{
    [userAPI profile:^(NSDictionary *response, NSError *error)
     {
         [self processProfileResponse:response withError:error];
     }];
}

#pragma mark - private

- (void)processProfileResponse:(NSDictionary*)response withError:(NSError*)error
{
    if(error.code == 403)
    {
        User* initialUser = (User*)[User all].firstObject;
        [userAPI login:initialUser.email withPassword:initialUser.password withBlock:^(NSDictionary *response, NSError *error)
         {
             if(error == nil)
             {
                 if(response != nil)
                 {
                     User* user = [[User alloc] init];
                     user.email = initialUser.email;
                     user.password = initialUser.password;
                     user.apiKey = [response valueForKey:@"data"];
                     
                     [User truncate];
                     [user save];
                     
                     [self startProfileSync];
                 }
                 else
                     [self.delegate onProfileSyncComplete:error];
             }
             else
                 [self.delegate onProfileSyncComplete:error];
         }];
    }
    else
    {
        if(response != nil)
        {
            User* user = (User*)[User all].firstObject;
            
            user.name = [NSString stringWithFormat:@"%@ %@", [response valueForKey:@"fname"], [response valueForKey:@"lname"]];
            user.pictureUrl = [response valueForKey:@"profilePicture"];
            
            [user update];
            
            [self.delegate onProfileSyncComplete:nil];
        }
        else
            [self.delegate onProfileSyncComplete:error];
        
    }
}

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
