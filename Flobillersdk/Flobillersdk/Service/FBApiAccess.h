//
//  FBApiAccess.h
//  Flobillersdk
//
//  Created by Do Quoc Lam on 10/30/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Request.h"//

@interface FBApiAccess : NSObject

+ (void)createOrderWithRequest:(Request *)request byUrlString:(NSString *)urlStr completionBlock:(void(^)(OrderInfo *order,NSMutableArray *payments))completion failureBlock:(void(^)(NSString *msgError))failure;

+ (void)updatePaymentOpion:(NSString *)traceNumber idPayment:(NSInteger)iD cardInfo:(CardInfo *)cardInfo byUrlString:(NSString *)urlStr completionBlock:(void(^)(OrderInfo *order))completion failureBlock:(void(^)(NSString *msgError))failure;

+ (void)updateAdditionField:(NSString *)mobileNumber traceNumber:(NSString *)traceNumber byUrlString:(NSString *)urlStr completionBlock:(void(^)(OrderInfo *order))completion failureBlock:(void(^)(NSString *msgError))failure;

+ (void)getOrder:(NSString *)traceNumber byUrlString:(NSString *)urlStr completionBlock:(void(^)(NSDictionary *respone))completion failureBlock:(void(^)(NSString *msgError))failure;
@end
