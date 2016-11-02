//
//  UserSync.h
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 11/2/16.
//  Copyright © 2016 Dihara Wijetunga. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UserSyncDelegate <NSObject>
@optional
- (void) onLoginSyncComplete:(NSError*) error;
@end

@interface UserSync : NSObject

@property (nonatomic, weak) id <UserSyncDelegate> delegate;

+ (UserSync *) sharedCenter;
- (void) startLoginSync: (NSString*)email withPassword:(NSString*)password;

@end
