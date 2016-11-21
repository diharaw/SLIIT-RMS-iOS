//
//  HomeController.m
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 10/21/16.
//  Copyright © 2016 Dihara Wijetunga. All rights reserved.
//

#import "HomeController.h"
#import "TimeTableController.h"
#import "NewsController.h"
#import "MMDrawerBarButtonItem.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "SettingsController.h"

@interface HomeController ()
{
    TimeTableController* timeTableController;
    NewsController* newsController;
    SettingsController* settingsController;
}
@end

@implementation HomeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
    [self setupLeftMenuButton];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self loadTimeTable];
}

#pragma mark - Private

- (void)setupUI
{
    //self.tabBar.delegate = self;
}

- (void)setupLeftMenuButton
{
    MMDrawerBarButtonItem *leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton];
}

- (void)leftDrawerButtonPress:(id)leftDrawerButtonPress
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
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
    [self setTitle:@"Time Table"];
}

- (void)loadNews
{
    [self resetContainer];
    newsController = (NewsController*)[self.storyboard instantiateViewControllerWithIdentifier:@"News"];
    [self loadViewIntoContainer:newsController];
    [self setTitle:@"Dashboard"];
}

- (void)loadSettings
{
    [self resetContainer];
    settingsController = (SettingsController*)[self.storyboard instantiateViewControllerWithIdentifier:@"Settings"];
    [self loadViewIntoContainer:settingsController];
    [self setTitle:@"Settings"];
}


@end
