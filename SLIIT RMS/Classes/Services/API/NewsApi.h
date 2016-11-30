//
//  NewsApi.h
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 11/30/16.
//  Copyright © 2016 Fidenz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface NewsApi : NSObject

-(void) getNews:(void (^)(NSDictionary* response, NSError *error)) block;

@end
