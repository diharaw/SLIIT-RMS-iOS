//
//  SideDrawerController.m
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 11/18/16.
//  Copyright © 2016 Fidenz. All rights reserved.
//

#import "SideDrawerController.h"
#import "HomeController.h"
#import "UIViewController+MMDrawerController.h"

@interface SideDrawerController () <UITableViewDelegate>
@property(nonatomic) NSInteger currentIndex;
@end

@implementation SideDrawerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.currentIndex = 0;
    self.tableView.delegate = self;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.currentIndex == indexPath.row) {
        [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
        return;
    }
    
    UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
    HomeController* home = (HomeController*)nav.visibleViewController;
    self.currentIndex = indexPath.row;
    
    switch (indexPath.row) {
        case 0:
            [home loadNews];
            break;
        case 1:
            [home loadTimeTable];
            break;
        case 2:
            [home loadSettings];
            break;
            
        default:
            break;
    }
    
    [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    
}


@end
