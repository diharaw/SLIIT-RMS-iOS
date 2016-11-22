//
//  SplashScreenController.m
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 10/21/16.
//  Copyright © 2016 Dihara Wijetunga. All rights reserved.
//

#import "SplashScreenController.h"
#import "User.h"
#import "SideDrawerController.h"
#import <MMDrawerController.h>

@interface SplashScreenController ()

@end

@implementation SplashScreenController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSArray* profiles = [User all];
    
    if(profiles.count == 0)
        [self performSegueWithIdentifier:@"SplashToLogin" sender:self];
    else
        [self performSegueWithIdentifier:@"SplashToDrawerMain" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"SplashToDrawerMain"])
    {
        MMDrawerController* drawer = (MMDrawerController*)[segue destinationViewController];
        
        UIViewController* center = [self.storyboard instantiateViewControllerWithIdentifier:@"CoreNav"];
        [drawer setCenterViewController:center];
        
        SideDrawerController* left = (SideDrawerController*)[self.storyboard instantiateViewControllerWithIdentifier:@"SideDrawer"];
        [drawer setLeftDrawerViewController:left];
    }
}

@end
