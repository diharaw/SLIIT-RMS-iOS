//
//  SplashScreenController.m
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 10/21/16.
//  Copyright © 2016 Fidenz. All rights reserved.
//

#import "SplashScreenController.h"

@interface SplashScreenController ()

@end

@implementation SplashScreenController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self performSegueWithIdentifier:@"SplashToLogin" sender:self];
}

@end
