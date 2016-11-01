//
//  LoginController.m
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 10/21/16.
//  Copyright © 2016 Fidenz. All rights reserved.
//

#import "LoginController.h"

@interface LoginController ()

@end

@implementation LoginController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - UI Events

- (IBAction)onLoginPressed:(id)sender
{
    [self performSegueWithIdentifier:@"LoginToHome" sender:self];
}


@end
