//
//  SideDrawerController.m
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 11/18/16.
//  Copyright © 2016 Dihara Wijetunga. All rights reserved.
//

#import "SideDrawerController.h"
#import "HomeController.h"
#import "User.h"
#import "UIViewController+MMDrawerController.h"
#import <FAKIonIcons.h>

@interface SideDrawerController () <UITableViewDelegate>
@property(nonatomic) NSInteger currentIndex;
@end

@implementation SideDrawerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.currentIndex = 0;
    self.tableView.delegate = self;
    [self setupUI];
}

- (void)viewDidLayoutSubviews
{
    self.imgProfilePicture.layer.cornerRadius = self.imgProfilePicture.frame.size.width / 2;
    self.imgProfilePicture.clipsToBounds = YES;
    
    self.pictureParent.layer.cornerRadius = self.pictureParent.frame.size.width / 2;
    self.pictureParent.clipsToBounds = YES;
}

#pragma mark - Private

- (void) setupUI
{
    FAKIonIcons *dashboardIcon = [FAKIonIcons speedometerIconWithSize:25];
    [dashboardIcon addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]];;
    [self.lblDashboardIcon setAttributedText:[dashboardIcon attributedString]];
    
    FAKIonIcons *timeTableIcon = [FAKIonIcons calendarIconWithSize:25];
    [timeTableIcon addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]];;
    [self.lblTimeTableIcon setAttributedText:[timeTableIcon attributedString]];
    
    FAKIonIcons *newsfeedIcon = [FAKIonIcons chatbubbleIconWithSize:25];
    [newsfeedIcon addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]];;
    [self.lblNewsfeedIcon setAttributedText:[newsfeedIcon attributedString]];
    
    FAKIonIcons *settingsIcon = [FAKIonIcons gearAIconWithSize:25];
    [settingsIcon addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]];;
    [self.lblSettingsIcon setAttributedText:[settingsIcon attributedString]];
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.currentIndex == indexPath.row)
    {
        [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
        return;
    }
    
    UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
    HomeController* home = (HomeController*)nav.visibleViewController;
    self.currentIndex = indexPath.row;
    
    switch (indexPath.row)
    {
        case 1:
            [home loadDashboard];
            break;
        case 2:
            [home loadTimeTable];
            break;
        case 3:
            [home loadNewsfeed];
            break;
        case 4:
            [home loadSettings];
            break;
            
        default:
            break;
    }
    
    [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    
}


@end
