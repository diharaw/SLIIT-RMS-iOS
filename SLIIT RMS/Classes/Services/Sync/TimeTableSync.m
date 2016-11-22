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
    [timeTableAPI getTimetable:type withWeekType:weekType withId:strID withYear:year withSemester:semester withBlock:^(NSDictionary *response, NSError *error)
     {
         [self processTimeTableResponse:response withError:error];
     }];
    
}

#pragma mark - private

- (void)processTimeTableResponse:(NSDictionary*)response withError:(NSError*)error
{
    if(response != nil)
    {
        [TimeTable truncate];
        
        [self saveTimeTableForDay:response withDay:@"Monday"];
        [self saveTimeTableForDay:response withDay:@"Tuseday"];
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
    NSMutableArray* temp = [[NSMutableArray alloc] init];
    NSInteger slot = 0;

    NSInteger dayInt = 0;
    
    if([day isEqualToString:@"Monday"])
        dayInt = 1;
    else if([day isEqualToString:@"Tuseday"])
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
    
    for (id object in slots)
    {
        slot++;
        
        if([object isKindOfClass:[NSDictionary class]])
        {
            NSDictionary* dic = (NSDictionary*)object;
            
            TimeTable* timeTable = [[TimeTable alloc] init];
            
            timeTable.subjectCode = [dic valueForKey:@"subjectCode"];
            timeTable.resource = [dic valueForKey:@"resource"];
            timeTable.type = [dic valueForKey:@"type"];
            timeTable.batch = [dic valueForKey:@"batch"];
            
            timeTable.day = [NSNumber numberWithInteger:dayInt];
            timeTable.slot = [NSNumber numberWithInteger:slot];
            timeTable.empty = [NSNumber numberWithInteger:0];
            
            //NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //[dateFormatter setDateFormat:@"HH:mm"];
            
            timeTable.startTime = [dic valueForKey:@"startTime"];
            timeTable.endTime = [dic valueForKey:@"endTime"];
            
            //timeTable.startTime = [dateFormatter dateFromString:[start substringToIndex:[start length]-3]];
            //timeTable.endTime = [dateFormatter dateFromString:[end substringToIndex:[end length]-3]];
            
            TimeTable* lastItem = (TimeTable*)temp.lastObject;
            if([lastItem.subjectCode isEqualToString:timeTable.subjectCode] && [lastItem.type isEqualToString:timeTable.type])
            {
                lastItem.endTime = timeTable.endTime;
            }
            else
            {
                [temp addObject:timeTable];
            }
        }
        else
        {
            TimeTable* timeTable = [[TimeTable alloc] init];
            
            if(slot == 5)
                timeTable.subjectCode = @"INTERVAL";
            
            timeTable.day = [NSNumber numberWithInteger:dayInt];
            timeTable.slot = [NSNumber numberWithInteger:slot];
            timeTable.empty = [NSNumber numberWithInteger:1];
            [temp addObject:timeTable];
        }
    }
    
    for (TimeTable* timetable in temp)
    {
        [timetable save];
    }
}

@end

