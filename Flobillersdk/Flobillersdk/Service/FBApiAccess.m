    //
//  FBApiAccess.m
//  Flobillersdk
//
//  Created by Do Quoc Lam on 10/30/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import "FBApiAccess.h"
#import <AFNetworking/AFNetworking.h>
#import "OrderInfo.h"
#import "FBConst.h"
#import "PaymentMethodInfo.h"
#import "CustomField.h"
#import "FlocashService.h"

@implementation FBApiAccess

+ (void)createOrderWithRequest:(Request *)request completionBlock:(void(^)(OrderInfo *order,NSMutableArray *payments))completion failureBlock:(void(^)(NSString *msgError))failure {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        NSString *baseUrl = [FlocashService sharedInstance].evironment?LIVE_URL:TEST_URL;
        NSMutableURLRequest *jsonRequest = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@%@",baseUrl,ORDER_PATH] parameters:[request dictionaryByRequest] error:nil];
        
        jsonRequest.timeoutInterval = 60.0f;
        [self setAuthorizationHeader:jsonRequest];
        [jsonRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [[manager dataTaskWithRequest:jsonRequest completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            
            if (!error) {
                if ([self isSuccess:responseObject]) {
                    if (failure) {
                        failure([self isSuccess:responseObject]);
                    }
                    return;
                }
                OrderInfo *order;
                NSMutableArray *result;
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    if (completion) {
                        order = [[OrderInfo alloc] initWithDictionary:[responseObject objectForKey:FBOrder]];
                        result = [self getPaymentMenthodFromDictionary:responseObject];
                        
                        completion(order,result);
                    }
                }
            } else {
                
                if (failure) {
                    [responseObject objectForKey:@"errorId"]?failure([self isSuccess:responseObject]):failure(FBUnknowError);
                    
                }
                
            }
            
            
        }] resume];
    });
}
+ (void)getOrder:(NSString *)traceNumber completionBlock:(void(^)(NSDictionary *respone))completion failureBlock:(void(^)(NSString *msgError))failure {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 60.0f;
        NSString *baseUrl = [FlocashService sharedInstance].evironment?LIVE_URL:TEST_URL;
        
        [manager GET:[NSString stringWithFormat:@"%@%@/%@",baseUrl,ORDER_PATH,traceNumber] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([self isSuccess:responseObject]) {
                if (failure) {
                    failure([self isSuccess:responseObject]);
                }
                return;
            }
            if (completion) {
                completion(responseObject);
            }
        }
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 if (failure) {
                     failure(FBUnknowError);
                 }
             }];
    });
    
}

+ (void)updatePaymentOpion:(NSString *)traceNumber idPayment:(NSInteger)iD cardInfo:(CardInfo *)cardInfo completionBlock:(void(^)(OrderInfo *order))completion failureBlock:(void(^)(NSString *msgError))failure {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        

        NSString *jsonPost;
        if (cardInfo) {
            jsonPost = [NSString stringWithFormat:@"{\"cardInfo\":{\"cardHolder\":\"%@\",\"cardNumber\":\"%@\",\"cvv\":\"%@\",\"expireMonth\":\"%@\",\"expireYear\":\"%@\"},\"order\":{\"traceNumber\":\"%@\"},\"payOption\":{\"id\":%ld}}",cardInfo.cardHolder,cardInfo.cardNumber,cardInfo.cvv,cardInfo.expireMonth,cardInfo.expireYear,traceNumber,(long)iD];
        } else {
            jsonPost = [NSString stringWithFormat:@"{\"order\":{\"traceNumber\":\"%@\"},\"payOption\":{\"id\":%ld}}",traceNumber,(long)iD];
        }
        NSString *baseUrl = [FlocashService sharedInstance].evironment?LIVE_URL:TEST_URL;
        NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"PUT" URLString:[NSString stringWithFormat:@"%@%@",baseUrl,ORDER_PATH] parameters:nil error:nil];
        
        
        [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
       
        [req setHTTPBody:[jsonPost dataUsingEncoding:NSUTF8StringEncoding]];
        req.timeoutInterval = 60.0f;
        
        [self setAuthorizationHeader:req];
        
        [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            
            if (!error) {
                if ([self isSuccess:responseObject]) {
                    if (failure) {
                        failure([self isSuccess:responseObject]);
                    }
                    return;
                }
                OrderInfo *order;
                
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    if (completion) {
                        order = [[OrderInfo alloc] initWithDictionary:[responseObject objectForKey:FBOrder]];
                        NSMutableArray *customFields = [self getCustomFieldsArrayFromDictionary:responseObject];
                        order.additionFields = [[AdditionInfo alloc] init];
                        order.additionFields.fields = customFields;
                        completion(order);
                    }
                }
            } else {
                if (failure) {
                    [responseObject objectForKey:@"errorId"]?failure([self isSuccess:responseObject]):failure(FBUnknowError);
                    
                }
            }
        }] resume];
    });
}
+ (void)updateAdditionField:(NSString *)mobileNumber traceNumber:(NSString *)traceNumber completionBlock:(void(^)(OrderInfo *order))completion failureBlock:(void(^)(NSString *msgError))failure {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        AFHTTPSessionManager *manager =  [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];;
        
        manager.requestSerializer.timeoutInterval = 60.0f;
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        NSLock *arrayLock = [[NSLock alloc] init];
        [arrayLock lock];
        param[@"mobile"] = mobileNumber;
        
        
        [arrayLock unlock];
        
        
        [self setAuthorizationHeaderManager:manager];
        NSString *baseUrl = [FlocashService sharedInstance].evironment?LIVE_URL:TEST_URL;
        [manager POST:[NSString stringWithFormat:@"%@%@/%@",baseUrl,ORDER_PATH,traceNumber] parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([self isSuccess:responseObject]) {
                if (failure) {
                    failure([self isSuccess:responseObject]);
                }
                return;
            }
            OrderInfo *order = [[OrderInfo alloc] initWithDictionary:[responseObject objectForKey:FBOrder]];
            NSMutableArray *customFields = [self getCustomFieldsArrayFromDictionary:responseObject];
            order.additionFields = [[AdditionInfo alloc] init];
            order.additionFields.fields = customFields;
            if (completion) {
                completion(order);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(FBUnknowError);
            }
            
        }];
    });
}
#pragma mark support function
+ (NSMutableArray *)getPaymentMenthodFromDictionary:(NSDictionary *)dictionary {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSDictionary *paymentOptions = [dictionary objectForKey:FBPaymentOptions];
    
    NSArray *allKeys = @[FBBanks,FBCards,FBBitcoins,FBKeyInCards,FBmobiles];
    for (NSString *typePayment in allKeys) {
        if ([paymentOptions objectForKey:typePayment]) {
            NSArray *arr = [paymentOptions objectForKey:typePayment];
            for (NSDictionary *dict in arr) {
                PaymentMethodInfo *pmInfor = [[PaymentMethodInfo alloc] init];
                pmInfor.idPayment = [[dict objectForKey:FBId] integerValue];
                pmInfor.displayName = [dict objectForKey:FBDisplayName];
                pmInfor.logo = [dict objectForKey:FBLogo];
                switch ([allKeys indexOfObject:typePayment]) {
                    case 0:
                        pmInfor.type = typeBank;
                        break;
                    case 1:
                        pmInfor.type = typeCard;
                        break;
                    case 2:
                        pmInfor.type = typeBitCoin;
                        break;
                    case 3:
                        pmInfor.type = typeKeyInCard;
                        break;
                    default:
                        pmInfor.type = typemobile;
                        break;
                }
                [result addObject:pmInfor];
                
            }
        }
    }
    
    return result;
}
+ (NSMutableArray *)getCustomFieldsArrayFromDictionary:(NSDictionary *)dict {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSArray *fieldDictionaryArray = [[[dict objectForKey:FBOrder] objectForKey:FBAdditionFields] objectForKey:FBFields];
    for (int i = 0; i < fieldDictionaryArray.count; i++) {
        CustomField *field = [[CustomField alloc] initWithDictionary:[fieldDictionaryArray objectAtIndex:i]];
        [result addObject:field];
    }
    
    return result;
}
+ (void) setAuthorizationHeader:(NSMutableURLRequest *) request{
    
    
    NSData *plainData = [[NSString stringWithFormat:@"%@:%@",@"flobiller", @"Fl@biller"] dataUsingEncoding:NSUTF8StringEncoding];
    NSString *encodedUsernameAndPassword = [plainData base64EncodedStringWithOptions:0];
    
    [request setValue:[NSString stringWithFormat:@"Basic %@",encodedUsernameAndPassword]  forHTTPHeaderField:@"Authorization"];
}

+ (NSString *)isSuccess:(NSDictionary *)respone {
    if ([respone objectForKey:@"errorId"]) {
        return [NSString stringWithFormat:@"%@ : %@",[respone objectForKey:@"errorCode" ],[respone objectForKey:@"errorMsg" ]];
    }
    return nil;
}

+ (void) setAuthorizationHeaderManager:(AFHTTPSessionManager *)manager {
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:60];
    NSData *plainData = [[NSString stringWithFormat:@"%@:%@",@"flobiller", @"Fl@biller"] dataUsingEncoding:NSUTF8StringEncoding];
    NSString *encodedUsernameAndPassword = [plainData base64EncodedStringWithOptions:0];
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Basic %@", encodedUsernameAndPassword] forHTTPHeaderField:@"Authorization"];
    
}
@end
