//
//  TimeTableSync.h
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 11/2/16.
//  Copyright © 2016 Dihara Wijetunga. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TimeTableSyncDelegate<NSObject>
@optional
- (void) onTimeTableSyncComplete:(NSError*) error;
@end

@interface TimeTableSync : NSObject

@property (nonatomic, weak) id <TimeTableSyncDelegate> delegate;

+ (TimeTableSync *) sharedCenter;
- (void) startTimeTableSync:(NSString*)type
               withWeekType:(NSString*)weekType
                     withId:(NSString*)strID
                   withYear:(NSInteger)year
               withSemester:(NSInteger)semester;

@end
