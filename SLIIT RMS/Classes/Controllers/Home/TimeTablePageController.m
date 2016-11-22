//
//  TimeTablePageController.m
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 11/2/16.
//  Copyright © 2016 Dihara Wijetunga. All rights reserved.
//

#import "TimeTablePageController.h"
#import "TimeTableEntryCell.h"

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
    TimeTableEntryCell* cell = (TimeTableEntryCell*)[tableView dequeueReusableCellWithIdentifier:@"TimeTableEntryCell"];
    return cell;
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
    return 150;
}

@end
