//
//  CardInfo.h
//  Flobillersdk
//
//  Created by Do Quoc Lam on 10/24/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardInfo : NSObject
@property (copy, nonatomic) NSString *cardHolder;
@property (copy, nonatomic) NSString *cardNumber;
@property (copy, nonatomic) NSString *expireMonth;
@property (copy, nonatomic) NSString *expireYear;
@property (copy, nonatomic) NSString *cvv;

@end
