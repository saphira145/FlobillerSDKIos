//
//  MobiePaymentViewController.h
//  Flobillersdk
//
//  Created by Do Quoc Lam on 10/31/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentMethodInfo.h"
#import "OrderInfo.h"
#import "FlobillerBaseViewController.h"
#import "UIImage+Bundle.h"
@interface MobiePaymentViewController : FlobillerBaseViewController <UITextFieldDelegate>{
    
    __weak IBOutlet UILabel *labelCost;
    __weak IBOutlet UIImageView *bankImageView;
    __weak IBOutlet UILabel *bankName;
    __weak IBOutlet UITextField *postalCodeLabel;
    __weak IBOutlet UITextField *phoneNumberLabel;
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UIView *viewButtonPay;
    
    
    
    
}
@property (copy,nonatomic) NSString *phoneCode;
@property (copy,nonatomic) NSString *phoneNumber;
@property (strong, nonatomic) PaymentMethodInfo *paymentInfo;
@property (strong, nonatomic) OrderInfo *order;

@end
