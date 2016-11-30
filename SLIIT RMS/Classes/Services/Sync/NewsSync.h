//
//  NewsSync.h
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 11/30/16.
//  Copyright © 2016 Fidenz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NewsSyncDelegate <NSObject>
@optional
- (void) onNewsSyncComplete:(NSError*) error;
@end

@interface NewsSync : NSObject

@property (nonatomic, weak) id <NewsSyncDelegate> delegate;

+ (NewsSync *) sharedCenter;
- (void) startNewsSync;

@end
