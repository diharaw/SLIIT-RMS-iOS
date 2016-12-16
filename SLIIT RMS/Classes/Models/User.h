//
//  User.h
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 11/2/16.
//  Copyright © 2016 Dihara Wijetunga. All rights reserved.
//

#import <OLCModel.h>

@interface User : OLCModel

@property (nonatomic, retain) NSNumber* Id;
@property (nonatomic, retain) NSString* userId;
@property (nonatomic, retain) NSString* email;
@property (nonatomic, retain) NSString* password;
@property (nonatomic, retain) NSString* apiKey;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* pictureUrl;

@end
