//
//  DashboardController.m
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 11/22/16.
//  Copyright © 2016 Fidenz. All rights reserved.
//

#import <MBProgressHUD.h>
#import <TSMessage.h>
#import "DashboardController.h"
#import "DashboardStat.h"
#import "DashboardSync.h"

@interface DashboardController () <DashboardSyncDelegate, MBProgressHUDDelegate>

@end

@implementation DashboardController
{
    DashboardStat* dashboardData;
    MBProgressHUD* progressHud;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self downloadData];
}

#pragma mark - Private

- (void) setupUI
{
    self.lblLabs.text = [NSString stringWithFormat:@"%@", dashboardData.lab];
    self.lblHalls.text = [NSString stringWithFormat:@"%@", dashboardData.hall];
    self.lblBatches.text = [NSString stringWithFormat:@"%@", dashboardData.batch];
    self.lblLecturers.text = [NSString stringWithFormat:@"%@", dashboardData.lecturer];
}

- (void) downloadData
{
    NSArray* allData = [DashboardStat all];
    
    if(allData.count == 0)
    {
        progressHud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:progressHud];
        progressHud.delegate = self;
        [progressHud showAnimated:YES];
    }
    else
    {
        dashboardData = (DashboardStat*)allData.firstObject;
        [self setupUI];
    }
    
    [DashboardSync sharedCenter].delegate = self;
    [[DashboardSync sharedCenter] startDashboardSync];
}

#pragma mark - Delegates

- (void)onDashboardSyncComplete:(NSError *)error
{
    [progressHud hideAnimated:YES];
    
    if(error == nil)
    {
        dashboardData = (DashboardStat*)[DashboardStat all].firstObject;
        [self setupUI];
    }
    else
    {
        [TSMessage showNotificationInViewController:self title:@"Error!" subtitle:@"Failed to Download Data" type:TSMessageNotificationTypeError duration:3];
    }
}

@end
