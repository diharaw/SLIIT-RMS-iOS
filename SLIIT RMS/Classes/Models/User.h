//
//  User.h
//  SLIIT RMS
//
//  Created by Fidenz on 11/2/16.
//  Copyright © 2016 Fidenz. All rights reserved.
//

#import <OLCModel.h>

@interface User : OLCModel

@property (nonatomic, retain) NSNumber* Id;
@property (nonatomic, retain) NSString* email;
@property (nonatomic, retain) NSString* password;
@property (nonatomic, retain) NSString* apiKey;

@end
