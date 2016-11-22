//
//  SideDrawerController.h
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 11/18/16.
//  Copyright © 2016 Fidenz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideDrawerController : UITableViewController

@property (weak, nonatomic) IBOutlet UIView *pictureParent;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfilePicture;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblDashboardIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblTimeTableIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblNewsfeedIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblSettingsIcon;

@end
