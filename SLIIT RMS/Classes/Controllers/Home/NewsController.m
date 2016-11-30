//
//  RequestController.m
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 10/21/16.
//  Copyright © 2016 Dihara Wijetunga. All rights reserved.
//

#import <MBProgressHUD.h>
#import <TSMessage.h>
#import "NewsController.h"
#import "NewsItem.h"
#import "NewsSync.h"
#import "NewsItemCell.h"

@interface NewsController () <UITableViewDelegate, UITableViewDataSource, MBProgressHUDDelegate, NewsSyncDelegate>

@end

@implementation NewsController
{
    MBProgressHUD* progressHud;
    NSArray* newsItemList;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
    [self downloadData];
}

#pragma mark - Private

- (void) setupUI
{
    self.tblNews.delegate = self;
    self.tblNews.dataSource = self;
}

- (void) downloadData
{
    newsItemList = [NewsItem all];
    
    if(newsItemList.count == 0)
    {
        progressHud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:progressHud];
        progressHud.delegate = self;
        [progressHud showAnimated:YES];
    }
    else
    {
        [self.tblNews reloadData];
    }
    
    [NewsSync sharedCenter].delegate = self;
    [[NewsSync sharedCenter] startNewsSync];
}

#pragma mark - Table View Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsItemCell* cell = [tableView dequeueReusableCellWithIdentifier:@"NewsItemCell"];
    
    NewsItem* item = [newsItemList objectAtIndex:indexPath.row];
    
    cell.lblTitle.text = item.title;
    cell.lblBody.text = item.news;
    cell.lblDate.text = item.publishedData;
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return newsItemList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

#pragma mark - Delegates

- (void)onNewsSyncComplete:(NSError *)error
{
    [progressHud hideAnimated:YES];
    
    if(error == nil)
    {
        newsItemList = [NewsItem all];
        [self.tblNews reloadData];
    }
    else
    {
        [TSMessage showNotificationInViewController:self title:@"Error!" subtitle:@"Failed to Download Data" type:TSMessageNotificationTypeError duration:3];
    }
}

@end
