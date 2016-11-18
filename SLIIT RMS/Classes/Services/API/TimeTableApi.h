//
//  TimeTableApi.h
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 11/2/16.
//  Copyright © 2016 Dihara Wijetunga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface TimeTableApi : NSObject

-(void) getTimetable:(NSString*)type withWeekType:(NSString*)weekType withId:(NSString*)strID withYear:(NSInteger)year withSemester:(NSInteger)semester withBlock:(void (^)(NSDictionary* response, NSError *error)) block;

@end
