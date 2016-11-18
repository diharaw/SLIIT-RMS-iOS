//
//  DashboardStat.h
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 11/18/16.
//  Copyright © 2016 Dihara Wijetunga. All rights reserved.
//

#import <OLCModel.h>

@interface DashboardStat : OLCModel

@property (nonatomic, retain) NSNumber* Id;
@property (nonatomic, retain) NSNumber* batch;
@property (nonatomic, retain) NSNumber* lecturer;
@property (nonatomic, retain) NSNumber* hall;
@property (nonatomic, retain) NSNumber* lab;

@end
