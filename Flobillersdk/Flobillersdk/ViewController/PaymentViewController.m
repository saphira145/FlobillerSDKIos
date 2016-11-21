//
//  PaymentViewController.m
//  Flobillersdk
//
//  Created by Do Quoc Lam on 10/30/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import "PaymentViewController.h"
#import "PaymentHeaderView.h"
#import "PaymentTableViewCell.h"
#import "MobiePaymentViewController.h"
#import "FBApiAccess.h"
#import "FBConst.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "FBApiAccess.h"
#import "DoneViewController.h"
#import "CardInfoViewController.h"
#import "FlocashService.h"


@interface PaymentViewController ()

@end

@implementation PaymentViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    viewBorder.layer.borderWidth = 1;
    viewBorder.layer.cornerRadius = 3;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.clipsToBounds = YES;
    indexPaymentSelected = 0;
    viewButtonPay.layer.cornerRadius = 3.0f;
    [self createOrder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Create order
- (void)createOrder {
    if (![FlocashService sharedInstance].networkStatus) {
        [self showAlertError:FBNoInternet];
        return;
    }
    [self showLoadingViewWithMessage:@"Creating order..."];
    [FBApiAccess createOrderWithRequest:self.request completionBlock:^(OrderInfo *order, NSMutableArray *payments) {
        [self dismissLoadingView];
        paymentMenthodArray = [payments mutableCopy];
        orderResult = order;
        costLabel.text = [NSString stringWithFormat:@"%@%.2f",orderResult.currencyName,orderResult.amount];
        
        [self.tableView reloadData];
        NSIndexPath* selectedCellIndexPath= [NSIndexPath indexPathForRow:0 inSection:0];
        
        [self.tableView selectRowAtIndexPath:selectedCellIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    } failureBlock:^(NSString *errMsg) {
        [self dismissLoadingView];
        [self showAlertError:errMsg];
    }];
}

#pragma mark - CollectionView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PaymentTableViewCell *paymentCell = (PaymentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"paymentCell"];
    PaymentMethodInfo *payment = [paymentMenthodArray objectAtIndex:indexPath.row];
    paymentCell.paymentImage.image = nil;
    [paymentCell.paymentImage sd_setImageWithURL:[NSURL URLWithString:payment.logo]];
    paymentCell.label.text          = payment.displayName;

    
    paymentCell.accessoryType = (indexPath.row == indexPaymentSelected)?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
    
    return paymentCell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return paymentMenthodArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}
- (IBAction)buttonNextAction:(id)sender {
    PaymentMethodInfo *paymentMethodInfo = [paymentMenthodArray objectAtIndex:indexPaymentSelected];
    switch (paymentMethodInfo.type) {
        case typemobile: {
            NSBundle *bundle = [NSBundle bundleForClass:[self class]];
            UIStoryboard *main = [UIStoryboard storyboardWithName:@"FBFlobillerSdkStoryboard" bundle:bundle];
            MobiePaymentViewController *mobileVC = [main instantiateViewControllerWithIdentifier:@"mobilePaymentVC"];
            mobileVC.paymentInfo = paymentMethodInfo;
            mobileVC.order = orderResult;
            mobileVC.phoneNumber = self.phoneNumber;
            mobileVC.phoneCode   = self.phoneCode;
            [self.navigationController pushViewController:mobileVC animated:YES];
            break;
        }
        case typeBank:{
            if (![FlocashService sharedInstance].networkStatus) {
                [self showAlertError:FBNoInternet];
                return;
            }
            [self showLoadingView];
            
            [FBApiAccess updatePaymentOpion:orderResult.traceNumber idPayment:paymentMethodInfo.idPayment cardInfo:nil completionBlock:^(OrderInfo *order) {
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
            break;
        }
        default: {
            NSBundle *bundle = [NSBundle bundleForClass:[self class]];
            UIStoryboard *main = [UIStoryboard storyboardWithName:@"FBFlobillerSdkStoryboard" bundle:bundle];
            CardInfoViewController *cardVC = [main instantiateViewControllerWithIdentifier:@"cardInfoVC"];
            cardVC.orderInfo = orderResult;
            cardVC.paymenMethod = paymentMethodInfo;
            [self.navigationController pushViewController:cardVC animated:YES];
            break;
        }
    }
}

#pragma mark - tableview header

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return viewHeader;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 80;
}
#pragma mark - tableview footer

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
#pragma mark - CollectionView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == indexPaymentSelected) {
        return;
    }
    PaymentTableViewCell *currentCellSelected = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPaymentSelected inSection:0]];
    currentCellSelected.accessoryType = UITableViewCellAccessoryNone;
    indexPaymentSelected = indexPath.row;
    PaymentTableViewCell *newCellSelected = [tableView cellForRowAtIndexPath:indexPath];
    newCellSelected.accessoryType = UITableViewCellAccessoryCheckmark;
}


@end
