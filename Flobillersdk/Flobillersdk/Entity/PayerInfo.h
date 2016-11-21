//
//  PayerInfo.h
//  Flobillersdk
//
//  Created by Do Quoc Lam on 10/24/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayerInfo : NSObject
@property (copy, nonatomic) NSString *firstName;
@property (copy, nonatomic) NSString *lastName;
@property (copy, nonatomic) NSString *address;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *state;
@property (copy, nonatomic) NSString *postalCode;
@property (copy, nonatomic) NSString *country;
@property (copy, nonatomic) NSString *email;
@property (copy, nonatomic) NSString *mobile;
@property (copy, nonatomic) NSString *otp;
@property (copy, nonatomic) NSString *phoneCode;
@property (copy, nonatomic) NSString *phoneNumber;

@end
