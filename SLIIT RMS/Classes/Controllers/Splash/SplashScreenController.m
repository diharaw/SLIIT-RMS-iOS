//
//  SplashScreenController.m
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 10/21/16.
//  Copyright © 2016 Dihara Wijetunga. All rights reserved.
//

#import "SplashScreenController.h"
#import "User.h"

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
        [self performSegueWithIdentifier:@"SplashToHome" sender:self];
}

@end
