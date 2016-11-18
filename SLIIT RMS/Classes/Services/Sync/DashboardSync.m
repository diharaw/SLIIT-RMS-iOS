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

@end
