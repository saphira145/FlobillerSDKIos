//
//  CardInfoViewController.h
//  Flobillersdk
//
//  Created by Do Quoc Lam on 11/4/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentMethodInfo.h"
#import "OrderInfo.h"
#import "FlobillerBaseViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "UIImage+Bundle.h"
@interface CardInfoViewController : FlobillerBaseViewController <UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
    
    __weak IBOutlet UILabel *labelCost;
    __weak IBOutlet UITextField *nameOnCardTextField;
    __weak IBOutlet UITextField *cardNumberTextField;
    __weak IBOutlet UITextField *expireDateLabel;
    __weak IBOutlet UITextField *securityCodeTextField;
   
    __weak IBOutlet TPKeyboardAvoidingScrollView *keyboardAvoiding;
    __weak IBOutlet UIView *viewBorder;
    __weak IBOutlet UIView *payButton;
    __weak IBOutlet NSLayoutConstraint *constraintBottomPickerView;
    __weak IBOutlet UIPickerView *pickerMonth;
    
    __weak IBOutlet UIPickerView *pickerYear;
    __weak IBOutlet UILabel *errorLabelCardNumber;
    
    //expireMonth, expire year
    NSString *expireMonth;
    NSString *expireYear;
    IBOutlet UIView *viewGuide;
    
}

@property (strong, nonatomic) OrderInfo *orderInfo;
@property (strong, nonatomic) PaymentMethodInfo *paymenMethod;

@end
