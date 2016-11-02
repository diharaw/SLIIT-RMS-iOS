//
//  TimeTableController.m
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 10/21/16.
//  Copyright © 2016 Dihara Wijetunga. All rights reserved.
//

#import "TimeTableController.h"
#import "TimeTablePageController.h"

@interface TimeTableController ()

@end

@implementation TimeTableController
{
    NSMutableArray *controllerArray;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - private

- (void) setupUI
{
    controllerArray = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 7; i++)
    {
        TimeTablePageController *controller = (TimeTablePageController*)[self.storyboard instantiateViewControllerWithIdentifier:@"TimeTablePage"];
        
        controller.dayIndex = i;
        
        switch (i)
        {
            case 0:
                controller.title = @"Mon";
                break;
                
            case 1:
                controller.title = @"Tue";
                break;
                
            case 2:
                controller.title = @"Wed";
                break;
                
            case 3:
                controller.title = @"Thu";
                break;
                
            case 4:
                controller.title = @"Fri";
                break;
                
            case 5:
                controller.title = @"Sat";
                break;
                
            case 6:
                controller.title = @"Sun";
                break;
                
            default:
                break;
        }
        
        [controllerArray addObject:controller];
    }
    
    NSDictionary *parameters = @{CAPSPageMenuOptionMenuItemSeparatorWidth: @(4.3),
                                 CAPSPageMenuOptionUseMenuLikeSegmentedControl: @(NO),
                                 CAPSPageMenuOptionMenuItemSeparatorPercentageHeight: @(0.1),
                                 CAPSPageMenuOptionSelectionIndicatorColor: [UIColor blackColor],
                                 CAPSPageMenuOptionSelectedMenuItemLabelColor: [UIColor blackColor],
                                 CAPSPageMenuOptionUnselectedMenuItemLabelColor: [UIColor blackColor],
                                 CAPSPageMenuOptionBottomMenuHairlineColor: [UIColor blackColor],
                                 CAPSPageMenuOptionScrollMenuBackgroundColor: [UIColor whiteColor]
                                 };
    
    self.pagemenu = [[CAPSPageMenu alloc] initWithViewControllers:controllerArray frame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height) options:parameters];
    
    [self.view addSubview:self.pagemenu.view];
}



@end
