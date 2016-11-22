//
//  HomeController.h
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 10/21/16.
//  Copyright © 2016 Dihara Wijetunga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeController : UIViewController <UITabBarDelegate>

@property (strong, nonatomic) IBOutlet UITabBar *tabBar;
@property (strong, nonatomic) IBOutlet UITabBarItem *timeTableItem;
@property (strong, nonatomic) IBOutlet UITabBarItem *requestItem;
@property (strong, nonatomic) IBOutlet UITabBarItem *settingsItem;
@property (strong, nonatomic) IBOutlet UIView *containerView;

- (void)loadDashboard;
- (void)loadTimeTable;
- (void)loadNewsfeed;
- (void)loadSettings;

@end
