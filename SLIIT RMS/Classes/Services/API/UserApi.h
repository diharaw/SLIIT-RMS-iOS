//
//  UserApi.h
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 11/2/16.
//  Copyright © 2016 Dihara Wijetunga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface UserApi : NSObject

-(void) login:(NSString*)email withPassword:(NSString*)password withBlock:(void (^)(NSDictionary* response, NSError *error)) block;

@end
