//
//  FlocashService.m
//  Flobillersdk
//
//  Created by Do Quoc Lam on 11/18/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import "FlocashService.h"
#import "PaymentViewController.h"
#import "OrderInfo.h"

@implementation FlocashService

+ (instancetype)sharedInstance
{
    static FlocashService *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[FlocashService alloc] init];
        
    });
    return sharedInstance;
}

- (void)createOrder:(Request*)request presentCreateOrderViewFrom:(UIViewController *)topViewController{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChangeStatus:) name:kReachabilityChangedNotification object:nil];
    [FlocashService sharedInstance].reachability = [Reachability reachabilityForInternetConnection];
    [[FlocashService sharedInstance].reachability startNotifier];
    [FlocashService sharedInstance].networkStatus = [[FlocashService sharedInstance].reachability currentReachabilityStatus];
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"FBFlobillerSdkStoryboard" bundle:bundle];
    PaymentViewController *paymentVC = [main instantiateViewControllerWithIdentifier:@"paymentVC"];
    paymentVC.request = request;
    paymentVC.phoneCode = request.payer.phoneCode;
    paymentVC.phoneNumber = request.payer.phoneNumber;
    NSLog(@"%@ %@",request.payer.phoneCode,request.payer.phoneNumber);
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:paymentVC];
    [topViewController presentViewController:nav animated:YES completion:nil];
}

#pragma mark - Check network status
-(void)networkChangeStatus:(NSNotification*)notifyObject {
    self.networkStatus = (self.reachability.currentReachabilityStatus != NotReachable);
}
@end
