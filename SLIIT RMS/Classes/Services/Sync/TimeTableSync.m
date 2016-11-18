//
//  TimeTableSync.m
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 11/2/16.
//  Copyright © 2016 Dihara Wijetunga. All rights reserved.
//

#import "TimeTableSync.h"
#import "TimeTableApi.h"
#import "TimeTable.h"

@implementation TimeTableSync
{
    TimeTableApi* timeTableAPI;
}

- (id) init
{
    self = [super init];
    timeTableAPI = [[TimeTableApi alloc] init];
    return self;
}

+ (TimeTableSync *) sharedCenter
{
    static dispatch_once_t once;
    static TimeTableSync * sharedInstance;
    dispatch_once(&once, ^{ sharedInstance = [[self alloc] init]; });
    return sharedInstance;
}

#pragma mark - public

- (void) startTimeTableSync:(NSString*)type
               withWeekType:(NSString*)weekType
                     withId:(NSString*)strID
                   withYear:(NSInteger)year
               withSemester:(NSInteger)semester
{
    [timeTableAPI getTimetable:type withWeekType:weekType withId:strID withYear:year withSemester:year withBlock:^(NSDictionary *response, NSError *error)
     {
         [self processTimeTableResponse:response withError:error];
     }];
    
}

#pragma mark - private

- (void)processTimeTableResponse:(NSDictionary*)response withError:(NSError*)error
{
    if(response != nil)
    {
        [self saveTimeTableForDay:response withDay:@"Monday"];
        [self saveTimeTableForDay:response withDay:@"Tuesday"];
        [self saveTimeTableForDay:response withDay:@"Wednesday"];
        [self saveTimeTableForDay:response withDay:@"Thursday"];
        [self saveTimeTableForDay:response withDay:@"Friday"];
        [self saveTimeTableForDay:response withDay:@"Saturday"];
        [self saveTimeTableForDay:response withDay:@"Sunday"];
        
        [self.delegate onTimeTableSyncComplete:nil];
    }
    else
        [self.delegate onTimeTableSyncComplete:error];
}

- (void) saveTimeTableForDay:(NSDictionary*)response withDay:(NSString*)day
{
    NSArray* slots = [response valueForKey:day];
    
    for (NSDictionary* dic in slots)
    {
        TimeTable* timeTable = [[TimeTable alloc] init];
        
        timeTable.subjectCode = [dic valueForKey:@"subjectCode"];
        timeTable.resource = [dic valueForKey:@"resource"];
        timeTable.type = [dic valueForKey:@"type"];
        timeTable.batch = [dic valueForKey:@"batch"];
        NSString* day = [dic valueForKey:@"day"];
        NSInteger dayInt = 0;
        
        if([day isEqualToString:@"Monday"])
            dayInt = 1;
        else if([day isEqualToString:@"Tuesday"])
            dayInt = 2;
        else if([day isEqualToString:@"Wednesday"])
            dayInt = 3;
        else if([day isEqualToString:@"Thursday"])
            dayInt = 4;
        else if([day isEqualToString:@"Friday"])
            dayInt = 5;
        else if([day isEqualToString:@"Saturday"])
            dayInt = 6;
        else if([day isEqualToString:@"Sunday"])
            dayInt = 7;
        
        timeTable.day = [NSNumber numberWithInteger:dayInt];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HHmm"];
        
        timeTable.startTime = [dateFormatter dateFromString:[dic valueForKey:@"startTime"]];
        timeTable.endTime = [dateFormatter dateFromString:[dic valueForKey:@"endTime"]];
        
        [timeTable save];
    }
}

@end

