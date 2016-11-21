//
//  PaymentViewController.h
//  Flobillersdk
//
//  Created by Do Quoc Lam on 10/30/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Request.h"
#import "PaymentMethodInfo.h"
#import "FlobillerBaseViewController.h"
#import "UIImage+Bundle.h"

@interface PaymentViewController : FlobillerBaseViewController <UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *paymentMenthodArray;
    NSInteger       indexPaymentSelected;
    OrderInfo       *orderResult;
    IBOutlet UIView *viewHeader;
    __weak IBOutlet UILabel *costLabel;
    __weak IBOutlet UIView *viewBorder;
    __weak IBOutlet UIView *viewButtonPay;
}
- (id)init;
@property (copy, nonatomic) NSString *phoneCode;
@property (copy, nonatomic) NSString *phoneNumber;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) Request *request;
@end
