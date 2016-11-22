//
//  TimeTableApi.m
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 11/2/16.
//  Copyright © 2016 Dihara Wijetunga. All rights reserved.
//

#import "TimeTableApi.h"
#import "Consts.h"

#define API_TIMETABLE @"timetable/getTimeTableJson"

@implementation TimeTableApi
{
    AFHTTPSessionManager *manager;
}

#pragma mark - public

- (id) init
{
    self = [super init];
    manager =[AFHTTPSessionManager manager];
    
    return self;
}

-(void) getTimetable:(NSString*)type withWeekType:(NSString*)weekType withId:(NSString*)strID withYear:(NSInteger)year withSemester:(NSInteger)semester withBlock:(void (^)(NSDictionary* response, NSError *error)) block
{
    NSDictionary* requestParameters = @{
                                        @"type": type,
                                        @"week_type" : weekType,
                                        @"id" : strID,
                                        @"year" :  [NSNumber numberWithInteger:year],
                                        @"semester" : [NSNumber numberWithInteger:semester]
                                        };
    
    NSString* url = [NSString stringWithFormat:@"%@/%@", API_BASE_URL, API_TIMETABLE];
    
    [manager POST:url parameters:requestParameters progress:nil
          success:
     ^(NSURLSessionTask *task, id responseObject)
     {
         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
         
         if(httpResponse.statusCode == 200)
         {
             if(responseObject != nil)
             {
                block(responseObject, nil);
             }
             else
             {
                 NSError* error = [[NSError alloc]init];
                 NSMutableDictionary* ud = [[error userInfo] mutableCopy];
                 [ud setValue:@"Failed to retrieve TimeTable" forKey:@"NSLocalizedDescription"];
                 error = [NSError errorWithDomain:@"" code:httpResponse.statusCode userInfo:ud];
                 block(nil, error);
             }
             
         }
         else
         {
             NSError* error = [[NSError alloc]init];
             NSMutableDictionary* ud = [[error userInfo] mutableCopy];
             [ud setValue:@"Failed to retrieve TimeTable" forKey:@"NSLocalizedDescription"];
             error = [NSError errorWithDomain:@"" code:httpResponse.statusCode userInfo:ud];
             
             block(nil, error);
         }
     }
          failure:
     ^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error : %@", error);
         block(nil, error);
     }];
}

@end
