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
#import "DashboardController.h"
#import "MMDrawerBarButtonItem.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "SettingsController.h"
#import "User.h"

@interface HomeController ()
{
    TimeTableController* timeTableController;
    NewsController* newsController;
    SettingsController* settingsController;
    DashboardController* dashboardController;
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
    [self loadDashboard];
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

- (void)loadNewsfeed
{
    [self resetContainer];
    newsController = (NewsController*)[self.storyboard instantiateViewControllerWithIdentifier:@"News"];
    [self loadViewIntoContainer:newsController];
    [self setTitle:@"Newsfeed"];
}

- (void)loadDashboard
{
    [self resetContainer];
    dashboardController = (DashboardController*)[self.storyboard instantiateViewControllerWithIdentifier:@"Dashboard"];
    dashboardController.controller = self;
    [self loadViewIntoContainer:dashboardController];
    [self setTitle:@"Dashboard"];
}

- (void)loadSettings
{
    [self resetContainer];
    settingsController = (SettingsController*)[self.storyboard instantiateViewControllerWithIdentifier:@"Settings"];
    [self loadViewIntoContainer:settingsController];
    [self setTitle:@"Settings"];
}

- (void)promptLogout
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Info"
                                  message:@"Are you sure you want to Log Out?"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Yes"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [User truncate];
                             [self performSegueWithIdentifier:@"HomeToSplash" sender:self];
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Segues

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
}


@end
