//
//  NewsItem.h
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 11/30/16.
//  Copyright © 2016 Fidenz. All rights reserved.
//

#import <OLCModel.h>

@interface NewsItem : OLCModel

@property (nonatomic, retain) NSNumber* Id;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* news;
@property (nonatomic, retain) NSString* publishedData;

@end
