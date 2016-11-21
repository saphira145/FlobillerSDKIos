//
//  MobiePaymentViewController.m
//  Flobillersdk
//
//  Created by Do Quoc Lam on 10/31/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import "MobiePaymentViewController.h"
#import "FBApiAccess.h"
#import "DoneViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "FBConst.h"
#import "FlocashService.h"

@interface MobiePaymentViewController ()

@end

@implementation MobiePaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    phoneNumberLabel.text = self.phoneNumber;
    postalCodeLabel.text = self.phoneCode;
    labelCost.text = [NSString stringWithFormat:@"%@%.2f",self.order.currencyName,self.order.amount];
    phoneNumberLabel.delegate = self;
    postalCodeLabel.delegate = self;
    scrollView.layer.borderWidth = 1.0f;
    scrollView.layer.cornerRadius = 3.0f;
    [bankImageView sd_setImageWithURL:[NSURL URLWithString:self.paymentInfo.logo]];
    bankName.text = self.paymentInfo.displayName;
    viewButtonPay.layer.cornerRadius = 3.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)payButtonAction:(id)sender {
    
    [phoneNumberLabel resignFirstResponder];
    [postalCodeLabel resignFirstResponder];
    if (![FlocashService sharedInstance].networkStatus) {
        [self showAlertError:FBNoInternet];
        return;
    }
    [self showLoadingView];
    [FBApiAccess updatePaymentOpion:self.order.traceNumber idPayment:self.paymentInfo.idPayment cardInfo:nil completionBlock:^(OrderInfo *order) {
        
        [FBApiAccess updateAdditionField:[NSString stringWithFormat:@"%@%@",postalCodeLabel.text,phoneNumberLabel.text] traceNumber:self.order.traceNumber completionBlock:^(OrderInfo *order) {
            
            [self dismissLoadingView];
            NSBundle *bundle = [NSBundle bundleForClass:[self class]];
            UIStoryboard *main = [UIStoryboard storyboardWithName:@"FBFlobillerSdkStoryboard" bundle:bundle];
            DoneViewController *doneVC = [main instantiateViewControllerWithIdentifier:@"doneVC"];
            doneVC.orderDone = order;
            [self.navigationController pushViewController:doneVC animated:YES];
        } failureBlock:^(NSString *errMsg) {
            
            [self dismissLoadingView];
            [self showAlertError:errMsg];
        }];
    } failureBlock:^(NSString *errMsg) {
        [self dismissLoadingView];
        [self showAlertError:errMsg];
    }];
}
- (BOOL)textFieldShouldReturn:(UITextField*)aTextField
{
    [aTextField resignFirstResponder];
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
