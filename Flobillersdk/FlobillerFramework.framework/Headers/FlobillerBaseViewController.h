//
//  FlobillerBaseViewController.h
//  Flobillersdk
//
//  Created by Do Quoc Lam on 11/3/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlobillerBaseViewController : UIViewController
- (void)showLoadingView;
- (void)showLoadingViewWithMessage:(NSString *)msg;
- (void)dismissLoadingView;
- (void)showAlertError:(NSString *)msg;
@end
