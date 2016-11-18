//
//  DashboardSync.h
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 11/18/16.
//  Copyright © 2016 Fidenz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DashboardSyncDelegate <NSObject>
@optional
- (void) onDashboardSyncComplete:(NSError*) error;
@end

@interface DashboardSync : NSObject

@property (nonatomic, weak) id <DashboardSyncDelegate> delegate;

+ (DashboardSync *) sharedCenter;
- (void) startDashboardSync;

@end
