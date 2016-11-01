//
//  HomeController.m
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 10/21/16.
//  Copyright © 2016 Fidenz. All rights reserved.
//

#import "HomeController.h"
#import "TimeTableController.h"
#import "RequestController.h"
#import "SettingsController.h"

@interface HomeController ()
{
    TimeTableController* timeTableController;
    RequestController* requestController;
    SettingsController* settingsController;
}
@end

@implementation HomeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.tabBar setSelectedItem:self.timeTableItem];
    [self loadTimeTable];
}

#pragma mark - Private

- (void)setupUI
{
    self.tabBar.delegate = self;
}

- (void)resetContainer
{
    for (UIView *view in self.containerView.subviews) {
        [view removeFromSuperview];
    }
    
    UIViewController *vc = [self.childViewControllers lastObject];
    [vc willMoveToParentViewController:nil];
    [vc.view removeFromSuperview];
    [vc removeFromParentViewController];
}

-(void)loadViewIntoContainer:(UIViewController*)vc
{
    [self addChildViewController:vc];
    [vc didMoveToParentViewController:self];
    vc.view.frame = self.containerView.frame;
    [self.view addSubview:vc.view];
}

- (void)loadTimeTable
{
    [self resetContainer];
    timeTableController = (TimeTableController*)[self.storyboard instantiateViewControllerWithIdentifier:@"TimeTable"];
    [self loadViewIntoContainer:timeTableController];
}

- (void)loadRequest
{
    [self resetContainer];
    requestController = (RequestController*)[self.storyboard instantiateViewControllerWithIdentifier:@"Request"];
    [self loadViewIntoContainer:requestController];
}

- (void)loadSettings
{
    [self resetContainer];
    settingsController = (SettingsController*)[self.storyboard instantiateViewControllerWithIdentifier:@"Settings"];
    [self loadViewIntoContainer:settingsController];
}

#pragma mark - UI Events

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    switch (item.tag) {
        case 0:
        {
            [self loadTimeTable];
            break;
        }
        case 1:
        {
            [self loadRequest];
            break;
        }
        case 2:
        {
            [self loadSettings];
            break;
        }
            
        default:
            break;
    }
}

@end
