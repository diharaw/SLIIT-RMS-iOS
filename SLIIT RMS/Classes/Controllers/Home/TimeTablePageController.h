//
//  TimeTablePageController.h
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 11/2/16.
//  Copyright © 2016 Dihara Wijetunga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeTablePageController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) NSInteger dayIndex;

@property (weak, nonatomic) IBOutlet UITableView *tblTimeTable;

- (void) setTimeTableEntries:(NSArray *)_timeTableEntries;

@end
