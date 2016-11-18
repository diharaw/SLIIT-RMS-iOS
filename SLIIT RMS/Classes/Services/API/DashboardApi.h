//
//  DashboardApi.h
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 11/18/16.
//  Copyright © 2016 Dihara Wijetunga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface DashboardApi : NSObject

-(void) getDashboard:(void (^)(NSDictionary* response, NSError *error)) block;

@end
