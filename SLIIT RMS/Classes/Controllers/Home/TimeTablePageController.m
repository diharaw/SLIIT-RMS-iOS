//
//  TimeTablePageController.m
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 11/2/16.
//  Copyright © 2016 Dihara Wijetunga. All rights reserved.
//

#import "TimeTablePageController.h"
#import "TimeTableEntryCell.h"
#import "IntervalCell.h"
#import "UnallocatedCell.h"
#import "TimeTable.h"

@interface TimeTablePageController ()

@end

@implementation TimeTablePageController
{
    NSArray *timeTableEntries;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
}

- (void)setTimeTableEntries:(NSArray *)_timeTableEntries
{
    timeTableEntries = _timeTableEntries;
    [self.tblTimeTable reloadData];
}

#pragma mark - Private

- (void)setupUI
{
    self.tblTimeTable.delegate = self;
    self.tblTimeTable.dataSource = self;
}

#pragma mark - Table View Delegates

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TimeTable* current = [timeTableEntries objectAtIndex:indexPath.row];
    
    if([current.subjectCode isEqualToString:@"INTERVAL"])
    {
        IntervalCell* cell = (IntervalCell*)[tableView dequeueReusableCellWithIdentifier:@"IntervalCell"];
        return cell;
    }
    else if([current.subjectCode isEqualToString:@""])
    {
        UnallocatedCell* cell = (UnallocatedCell*)[tableView dequeueReusableCellWithIdentifier:@"UnallocatedCell"];
        return cell;
    }
    else
    {
        TimeTableEntryCell* cell = (TimeTableEntryCell*)[tableView dequeueReusableCellWithIdentifier:@"TimeTableEntryCell"];
        
        cell.lblStartTime.text = current.startTime;
        cell.lblEndTime.text = current.endTime;
        cell.lblSubject.text = current.subjectCode;
        cell.lblLocation.text = current.resource;
        
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return timeTableEntries.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TimeTable* current = [timeTableEntries objectAtIndex:indexPath.row];
    
    if([current.subjectCode isEqualToString:@"INTERVAL"] || [current.subjectCode isEqualToString:@""])
        return 80;
    else
        return 150;
}

@end
