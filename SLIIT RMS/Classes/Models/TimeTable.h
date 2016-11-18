//
//  TimeTable.h
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 11/18/16.
//  Copyright © 2016 Dihara Wijetunga. All rights reserved.
//

#import <OLCModel.h>

@interface TimeTable : OLCModel

@property (nonatomic, retain) NSNumber* Id;
@property (nonatomic, retain) NSNumber* day;
@property (nonatomic, retain) NSString* subjectCode;
@property (nonatomic, retain) NSString* resource;
@property (nonatomic, retain) NSString* batch;
@property (nonatomic, retain) NSString* type;
@property (nonatomic, retain) NSDate*   startTime;
@property (nonatomic, retain) NSDate*   endTime;

@end
