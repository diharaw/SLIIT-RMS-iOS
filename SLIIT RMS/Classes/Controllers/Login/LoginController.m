//
//  LoginController.m
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 10/21/16.
//  Copyright © 2016 Dihara Wijetunga. All rights reserved.
//

#import "LoginController.h"
#import "UserSync.h"
#import <TSMessage.h>
#import <MBProgressHUD.h>

@interface LoginController () <UserSyncDelegate, MBProgressHUDDelegate>

@end

@implementation LoginController
{
    MBProgressHUD* progressHud;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - UI Events

- (IBAction)onLoginPressed:(id)sender
{
    progressHud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:progressHud];
    progressHud.delegate = self;
    [progressHud showAnimated:YES];
    
    [[UserSync sharedCenter] setDelegate:self];
    [[UserSync sharedCenter] startLoginSync:self.txtEmail.text withPassword:self.txtPassword.text];
}

#pragma mark - Delegates

- (void)onLoginSyncComplete:(NSError *)error
{
    [progressHud hideAnimated:YES];
    
    if(error == nil)
        [self performSegueWithIdentifier:@"LoginToHome" sender:self];
    else
    {
        [TSMessage showNotificationInViewController:self title:@"Error!" subtitle:@"Failed to Login" type:TSMessageNotificationTypeError duration:3];
    }
}

@end
