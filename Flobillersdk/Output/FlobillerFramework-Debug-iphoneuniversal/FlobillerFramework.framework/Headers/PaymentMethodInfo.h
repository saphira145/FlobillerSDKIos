//
//  PaymentMethodInfo.h
//  Flobillersdk
//
//  Created by Do Quoc Lam on 10/30/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaymentMethodInfo : NSObject
@property (nonatomic) NSInteger         idPayment;
@property (copy, nonatomic) NSString    *displayName;
@property (nonatomic) NSInteger        type;
@property (copy, nonatomic) NSString    *logo;
@end
