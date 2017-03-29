//
//  FBConst.h
//  Flobillersdk
//
//  Created by Do Quoc Lam on 10/30/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#ifndef FBConst_h
#define FBConst_h

#pragma mark - Detect device
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE6 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 667)
#define IS_IPHONE5 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 568)
#define IS_IPHONE4 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 480)
#define IS_IPHONE6PLUS ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 736)

typedef NS_ENUM(NSInteger, FBPaymentType) {
    typeBank = 0,
    typeBitCoin,
    typeCard,
    typeKeyInCard,
    typemobile
};
typedef NS_ENUM(BOOL, FBEEnvironment) {
    SANDBOX = NO,
    PRODUCTION = YES
};

static NSString * const TEST_URL = @"https://sandbox.flocash.com";
static NSString * const LIVE_URL = @"https://fcms.flocash.com";
static NSString * const ORDER_PATH = @"/rest/v2/orders";
//Status order
static NSString * const STATUS_SUCCESS = @"0000";
static NSString * const STATUS_PENDING = @"0004";
static NSString * const STATUS_DECINE = @"0003";
//Key API Access
static NSString * const FBPaymentOptions        = @"paymentOptions";
static NSString * const FBBanks                 = @"banks";
static NSString * const FBBitcoins              = @"bitcoins";
static NSString * const FBCards                 = @"cards";
static NSString * const FBKeyInCards            = @"keyinCards";
static NSString * const FBmobiles               = @"mobiles";
static NSString * const FBId                    = @"id";
static NSString * const FBLogo                  = @"logo";
static NSString * const FBType                  = @"type";
static NSString * const FBDisplayName           = @"displayName";
static NSString * const FBOrder                 = @"order";
static NSString * const FBAdditionFields        = @"additionFields";
static NSString * const FBFields                = @"fields";
//Message
static NSString * const FBNoInternet            = @"Internet connection problem!";
static NSString * const FBUnknowError           = @"Sever problem!";

#endif /* FBConst_h */
