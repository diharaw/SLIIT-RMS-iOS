//
//  LoginController.m
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 10/21/16.
//  Copyright © 2016 Dihara Wijetunga. All rights reserved.
//

#import "LoginController.h"
#import "UserSync.h"
#import "SideDrawerController.h"
#import "User.h"
#import <TSMessage.h>
#import <MBProgressHUD.h>
#import <MMDrawerController.h>

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

#pragma mark - Private

- (BOOL) validateEmail:(NSString*) emailString
{
    if([emailString length]==0){
        return NO;
    }
    
    NSString *regExPattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:emailString options:0 range:NSMakeRange(0, [emailString length])];
    
    NSLog(@"%lu", (unsigned long)regExMatches);
    if (regExMatches == 0) {
        return NO;
    } else {
        return YES;
    }
}

#pragma mark - UI Events

- (IBAction)onLoginPressed:(id)sender
{
    //[self performSegueWithIdentifier:@"LoginToDrawerMain" sender:self];
    
    if([self validateEmail:self.txtEmail.text])
    {
        if(![self.txtPassword.text isEqualToString:@""])
        {
            progressHud = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:progressHud];
            progressHud.delegate = self;
            [progressHud showAnimated:YES];
            
            [[UserSync sharedCenter] setDelegate:self];
            [[UserSync sharedCenter] startLoginSync:self.txtEmail.text withPassword:self.txtPassword.text];
        }
        else
        {
            [TSMessage showNotificationInViewController:self title:@"Password empty!" subtitle:@"Please enter password." type:TSMessageNotificationTypeWarning duration:3];
        }
    }
    else
    {
        [TSMessage showNotificationInViewController:self title:@"Invalid Email!" subtitle:@"Please enter a valid email address." type:TSMessageNotificationTypeWarning duration:3];
    }
}

#pragma mark - Delegates

- (void)onLoginSyncComplete:(NSError *)error
{
    if(error == nil)
        [[UserSync sharedCenter] startProfileSync];
    else
    {
        [progressHud hideAnimated:YES];
        [TSMessage showNotificationInViewController:self title:@"Error!" subtitle:@"Failed to Login" type:TSMessageNotificationTypeError duration:3];
    }
}

- (void)onProfileSyncComplete:(NSError *)error
{
    [progressHud hideAnimated:YES];
    
    if(error == nil)
        [self performSegueWithIdentifier:@"LoginToDrawerMain" sender:self];
    else
    {
        [User truncate];
        [TSMessage showNotificationInViewController:self title:@"Error!" subtitle:@"Failed to Login" type:TSMessageNotificationTypeError duration:3];
    }
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"LoginToDrawerMain"])
    {
        MMDrawerController* drawer = (MMDrawerController*)[segue destinationViewController];
        
        UIViewController* center = [self.storyboard instantiateViewControllerWithIdentifier:@"CoreNav"];
        [drawer setCenterViewController:center];
        
        SideDrawerController* left = (SideDrawerController*)[self.storyboard instantiateViewControllerWithIdentifier:@"SideDrawer"];
        [drawer setLeftDrawerViewController:left];
    }
}


@end
