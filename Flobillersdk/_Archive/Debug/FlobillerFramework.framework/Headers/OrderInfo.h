//
//  OrderInfo.h
//  Flobillersdk
//
//  Created by Do Quoc Lam on 10/24/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PayerInfo.h"
#import "AdditionInfo.h"
@interface OrderInfo : NSObject
@property (nonatomic) double amount;
@property (copy, nonatomic) NSDate *orderDate;
@property (copy, nonatomic) NSString *currency;
@property (copy, nonatomic) NSString *custom;
@property (copy, nonatomic) NSString *item_name;
@property (copy, nonatomic) NSString *item_price;
@property (copy, nonatomic) NSString *quantity;
@property (copy, nonatomic) NSString *orderId;
@property (copy, nonatomic) NSString *tracking;
@property (copy, nonatomic) NSString *traceNumber;
@property (copy, nonatomic) NSString *partnerMessage;
@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSString *statusDesc;
@property (copy, nonatomic) NSString *partnerTxn;
@property (copy, nonatomic) NSString *cardNumber;
@property (copy, nonatomic) NSString *expireMonth;
@property (copy, nonatomic) NSString *expireYear;
@property (copy, nonatomic) NSString *cvv;
@property (copy, nonatomic) NSString *otp;
@property (copy, nonatomic) NSString *paymentChannel;
@property (copy, nonatomic) NSString *instruction;
@property (copy, nonatomic) NSString *currencyName;
@property (strong, nonatomic) PayerInfo *payer;
//UrlInfo url
@property (strong, nonatomic) AdditionInfo *additionFields;

- (instancetype)initWithDictionary:(NSDictionary *)JSONDictionary;
@end
