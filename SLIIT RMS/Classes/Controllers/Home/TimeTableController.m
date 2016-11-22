//
//  TimeTableController.m
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 10/21/16.
//  Copyright © 2016 Dihara Wijetunga. All rights reserved.
//

#import "TimeTableController.h"
#import "TimeTablePageController.h"
#import "TimeTableSync.h"
#import "TimeTable.h"
#import <MBProgressHUD.h>

@interface TimeTableController () <TimeTableSyncDelegate, MBProgressHUDDelegate>

@end

@implementation TimeTableController
{
    NSMutableArray *controllerArray;
    NSArray* allTimeTables;
    MBProgressHUD* progressHud;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self downloadData];
}

#pragma mark - private

- (void) downloadData
{
    if(allTimeTables.count == 0)
    {
        progressHud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:progressHud];
        progressHud.delegate = self;
        [progressHud showAnimated:YES];
    }
    
    [TimeTableSync sharedCenter].delegate = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[TimeTableSync sharedCenter] startTimeTableSync:@"BATCH" withWeekType:@"Weekday" withId:@"BT_1_1" withYear:2016 withSemester:2];
    });
}

- (NSArray*) getTimeTableForDay:(NSUInteger)day
{
    NSMutableArray* timetables = [[NSMutableArray alloc] init];
    NSNumber* num_day = [NSNumber numberWithInteger:day];
    
    for (TimeTable* current in allTimeTables)
    {
        if([current.day isEqualToNumber:num_day])
            [timetables addObject:current];
    }
    
    NSArray* result = [NSArray arrayWithArray:timetables];
    
    return result;
}

- (void) setupUI
{
    controllerArray = [NSMutableArray array];
    allTimeTables = [TimeTable all];
    
    for (NSInteger i = 0; i < 7; i++)
    {
        TimeTablePageController *controller = (TimeTablePageController*)[self.storyboard instantiateViewControllerWithIdentifier:@"TimeTablePage"];
        
        controller.dayIndex = i;
        [controller setTimeTableEntries:[self getTimeTableForDay:i + 1]];
        
        switch (i)
        {
            case 0:
                controller.title = @"Mon";
                break;
                
            case 1:
                controller.title = @"Tue";
                break;
                
            case 2:
                controller.title = @"Wed";
                break;
                
            case 3:
                controller.title = @"Thu";
                break;
                
            case 4:
                controller.title = @"Fri";
                break;
                
            case 5:
                controller.title = @"Sat";
                break;
                
            case 6:
                controller.title = @"Sun";
                break;
                
            default:
                break;
        }
        
        [controllerArray addObject:controller];
    }
    
    NSDictionary *parameters = @{CAPSPageMenuOptionMenuItemSeparatorWidth: @(4.3),
                                 CAPSPageMenuOptionUseMenuLikeSegmentedControl: @(NO),
                                 CAPSPageMenuOptionMenuItemSeparatorPercentageHeight: @(0.1),
                                 CAPSPageMenuOptionSelectionIndicatorColor: [UIColor blackColor],
                                 CAPSPageMenuOptionSelectedMenuItemLabelColor: [UIColor blackColor],
                                 CAPSPageMenuOptionUnselectedMenuItemLabelColor: [UIColor blackColor],
                                 CAPSPageMenuOptionBottomMenuHairlineColor: [UIColor blackColor],
                                 CAPSPageMenuOptionScrollMenuBackgroundColor: [UIColor whiteColor]
                                 };
    
    self.pagemenu = [[CAPSPageMenu alloc] initWithViewControllers:controllerArray frame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height) options:parameters];
    
    [self.view addSubview:self.pagemenu.view];
}

#pragma mark - Delegates

- (void)onTimeTableSyncComplete:(NSError *)error
{
    [progressHud hideAnimated:YES];
    allTimeTables = [TimeTable all];
    
    if(allTimeTables.count != 0)
    {
        NSInteger day = 0;
        for(TimeTablePageController* controller in controllerArray)
        {
            day++;
            [controller setTimeTableEntries:[self getTimeTableForDay:day]];
        }
    }
}

@end
