//
//  MerchantInfo.h
//  Flobillersdk
//
//  Created by Do Quoc Lam on 10/24/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MerchantInfo : NSObject
@property (copy, nonatomic) NSString *urlReturn;
@property (copy, nonatomic) NSString *urlCancel;
@property (copy, nonatomic) NSString *urlLogo;
@property (copy, nonatomic) NSString *merchantName;
@property (copy, nonatomic) NSString *merchantAccount;


@end
