//
//  TimeTableEntryCell.h
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 11/19/16.
//  Copyright © 2016 Fidenz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeTableEntryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblStartTime;
@property (weak, nonatomic) IBOutlet UILabel *lblEndTime;
@property (weak, nonatomic) IBOutlet UILabel *lblSubject;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;

@end
