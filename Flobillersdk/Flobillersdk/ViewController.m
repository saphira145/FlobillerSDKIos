//
//  ViewController.m
//  Flobillersdk
//
//  Created by Do Quoc Lam on 10/24/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import "ViewController.h"
#import "CardInfo.h"
#import "CommonUtilities.h"
#import "OrderInfo.h"
#import "PayerInfo.h"
#import "MerchantInfo.h"
#import "Request.h"
#import "PaymentViewController.h"
#import "CheckOutTableViewCell.h"
#import "FlocashService.h"

@interface ViewController () {
    
    NSMutableArray *requestArray;
    NSInteger indexCheckOutSelected;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    indexCheckOutSelected = 0;
    Request *request1;
    requestArray = [[NSMutableArray alloc] init];
    CardInfo *card = [[CardInfo alloc] init];
    card.cardHolder = @"1";
    card.cardNumber = @"2";
    card.expireMonth = @"12";
    
    
    OrderInfo *order1 = [[OrderInfo alloc] init];
    PayerInfo *payer1 = [[PayerInfo alloc] init];
    order1.amount = 1.0;
    order1.currency = @"GHS";
    order1.item_name =  @"DSTV";
    order1.item_price = @"1";
    order1.orderId = @"645";
    order1.quantity = @"1";
    payer1.country = @"GH";
    payer1.firstName = @"pham";
    payer1.lastName = @"binh";
    payer1.email = @"binhpd1@gmail.com";
    payer1.phoneCode = @"+233";
    payer1.phoneNumber = @"87016637251";
    payer1.mobile = [NSString stringWithFormat:@"%@%@",payer1.phoneCode,payer1.phoneNumber];
    
    MerchantInfo *merchant1 = [[MerchantInfo alloc] init];
    request1 = [[Request alloc] init];
    request1.order = order1;
    request1.payer = payer1;
    request1.merchant = merchant1;
    merchant1.merchantAccount = @"flobiller@flocash.com";
    
    
    OrderInfo *order2 = [[OrderInfo alloc] init];
    PayerInfo *payer2 = [[PayerInfo alloc] init];
    order2.amount = 1.0;
    order2.currency = @"ETB";
    order2.item_name =  @"Sky Bus";
    order2.item_price = @"3";
    order2.orderId = @"648";
    order2.quantity = @"1";
    payer2.country = @"ET";
    payer2.firstName = @"pham";
    payer2.lastName = @"binh";
    payer2.email = @"binhpd1@gmail.com";
    payer2.phoneCode = @"+251";
    payer2.phoneNumber = @"87016637251";
    payer2.mobile = [NSString stringWithFormat:@"%@%@",payer2.phoneCode,payer2.phoneNumber];
    
    MerchantInfo *merchant2 = [[MerchantInfo alloc] init];
    Request *request2 = [[Request alloc] init];
    request2.order = order2;
    request2.payer = payer2;
    request2.merchant = merchant2;
    merchant2.merchantAccount = @"flobiller@flocash.com";
    
    [requestArray addObject:request1];
    [requestArray addObject:request2];
    NSIndexPath* selectedCellIndexPath= [NSIndexPath indexPathForRow:0 inSection:0];
    
    [self.tableView selectRowAtIndexPath:selectedCellIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];

    
}
- (IBAction)buttonNextAction:(id)sender {
    [[FlocashService sharedInstance] createOrder:[requestArray firstObject] presentCreateOrderViewFrom:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return requestArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CheckOutTableViewCell *cell = (CheckOutTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"checkOutCell"];
    Request *request = [requestArray objectAtIndex:indexPath.row];
    cell.accessoryType = (indexPath.row == indexCheckOutSelected)? UITableViewCellAccessoryCheckmark: UITableViewCellAccessoryNone;
     
    cell.nameLabel.text = request.order.item_name;
    NSString *price = [NSString stringWithFormat:@"%.2f",request.order.amount*[request.order.quantity integerValue]*[request.order.item_price integerValue]];
    cell.priceLabel.text = [NSString stringWithFormat:@"Price : %@",price];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == indexCheckOutSelected) {
        return;
    }
    CheckOutTableViewCell *currentCellSelected = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexCheckOutSelected inSection:0]];
    currentCellSelected.accessoryType = UITableViewCellAccessoryNone;
    indexCheckOutSelected = indexPath.row;
    CheckOutTableViewCell *newCellSelected = [tableView cellForRowAtIndexPath:indexPath];
    newCellSelected.accessoryType = UITableViewCellAccessoryCheckmark;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController *naviVC = (UINavigationController *)segue.destinationViewController;
    PaymentViewController *paymentVC =  [naviVC.viewControllers firstObject];
    Request *request = [requestArray objectAtIndex:indexCheckOutSelected];
    paymentVC.request = request;
    paymentVC.phoneCode = request.payer.phoneCode;
    paymentVC.phoneNumber = request.payer.phoneNumber;
}

@end
