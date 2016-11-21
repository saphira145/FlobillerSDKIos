//
//  Request.h
//  Flobillersdk
//
//  Created by Do Quoc Lam on 10/30/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderInfo.h"
#import "PayerInfo.h"
#import "MerchantInfo.h"
#import "PaymentMethodInfo.h"
#import "CardInfo.h"

@interface Request : NSObject

@property (strong, nonatomic) OrderInfo *order;
@property (strong, nonatomic) PayerInfo *payer;
@property (strong, nonatomic) MerchantInfo *merchant;
@property (strong, nonatomic) PaymentMethodInfo *payOption;
@property (strong, nonatomic) CardInfo *cardInfo;
- (NSDictionary *)dictionaryByRequest;

@end
