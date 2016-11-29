//
//  DashboardSync.m
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 11/18/16.
//  Copyright © 2016 Dihara Wijetunga. All rights reserved.
//

#import "DashboardSync.h"
#import "DashboardApi.h"
#import "DashboardStat.h"
#import "UserApi.h"
#import "User.h"

@implementation DashboardSync
{
    DashboardApi* dashboardAPI;
}

- (id) init
{
    self = [super init];
    dashboardAPI = [[DashboardApi alloc] init];
    return self;
}

+ (DashboardSync *) sharedCenter
{
    static dispatch_once_t once;
    static DashboardSync * sharedInstance;
    dispatch_once(&once, ^{ sharedInstance = [[self alloc] init]; });
    return sharedInstance;
}

#pragma mark - public

- (void) startDashboardSync
{
    [dashboardAPI getDashboard:^(NSDictionary *response, NSError *error)
     {
         [self processDashboardResponse:response withError:error];
     }];
    
}

#pragma mark - private

- (void)processDashboardResponse:(NSDictionary*)response withError:(NSError*)error
{
    if(error.code == 403)
    {
        UserApi* userAPI = [[UserApi alloc] init];
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
                     
                     [self startDashboardSync];
                 }
                 else
                     [self.delegate onDashboardSyncComplete:error];
             }
             else
             {
                 [self.delegate onDashboardSyncComplete:error];
             }
         }];
    }
    else
    {
        if(response != nil)
        {
            [DashboardStat truncate];
            
            DashboardStat* stats = [[DashboardStat alloc] init];
            
            stats.batch = [response valueForKey:@"batch"];
            stats.lecturer = [response valueForKey:@"lecturer"];
            stats.hall = [response valueForKey:@"hall"];
            stats.lab = [response valueForKey:@"lab"];
            
            [stats save];
            
            [self.delegate onDashboardSyncComplete:nil];
        }
        else
            [self.delegate onDashboardSyncComplete:error];
    }
}

@end
