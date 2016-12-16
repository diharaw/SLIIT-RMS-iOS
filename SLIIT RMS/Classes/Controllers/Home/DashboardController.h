//
//  DashboardController.h
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 11/22/16.
//  Copyright © 2016 Fidenz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeController.h"

@interface DashboardController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblBatches;
@property (weak, nonatomic) IBOutlet UILabel *lblHalls;
@property (weak, nonatomic) IBOutlet UILabel *lblLecturers;
@property (weak, nonatomic) IBOutlet UILabel *lblLabs;
@property (weak, nonatomic) IBOutlet UIButton *btnTimeTable;
@property (weak, nonatomic) HomeController *controller;

- (IBAction)btnTimeTablePressed:(id)sender;


@end
