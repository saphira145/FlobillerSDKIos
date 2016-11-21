//
//  FlobillerBaseViewController.m
//  Flobillersdk
//
//  Created by Do Quoc Lam on 11/3/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import "FlobillerBaseViewController.h"
#import "UIImage+Bundle.h"
@interface FlobillerBaseViewController () {
    UIView *loadingView;
    UIActivityIndicatorView *activity;
    UILabel *messageLoading;
}

@end

@implementation FlobillerBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0 green:81.0f/255 blue:145.0f/255 alpha:1];
    self.navigationController.navigationBar.translucent = NO;
    // Do any additional setup after loading the view.
    
    CGRect frameimg = CGRectMake(15,5, 25,25);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:[UIImage imageNamedInBundle:@"Icon_Back"] forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(pop)
         forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc]initWithCustomView:someButton];
    self.navigationItem.leftBarButtonItem = barBtnItem;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.title = @"PAYMENT";
    
    [self setUpLoadingView];
    
}
- (void)pop {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setUpLoadingView {
    activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    
    loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.view.frame.size.width, self.navigationController.view.frame.size.height)];
    [loadingView addSubview:activity];
    activity.center = loadingView.center;
    messageLoading = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
    
    messageLoading.textColor = [UIColor whiteColor];
    [loadingView addSubview:messageLoading];
    loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
}
- (void)showLoadingView {
    messageLoading.hidden = YES;
    [activity startAnimating];
    [self.navigationController.view addSubview:loadingView];
}
- (void)showLoadingViewWithMessage:(NSString *)msg {
    messageLoading.hidden = NO;
    messageLoading.text = msg;
    messageLoading.textAlignment = NSTextAlignmentCenter;
    CGPoint centerLabel = loadingView.center;
    centerLabel.y += 30;
    messageLoading.center = centerLabel;
    [activity startAnimating];
    [self.navigationController.view addSubview:loadingView];
}

- (void)dismissLoadingView {
    [activity stopAnimating];
    [loadingView removeFromSuperview];
}

- (void)showAlertError:(NSString *)msg {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
@end
