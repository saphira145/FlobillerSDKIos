//
//  DoneViewController.h
//  Flobillersdk
//
//  Created by Do Quoc Lam on 11/2/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderInfo.h"
#import "FlobillerBaseViewController.h"

@interface DoneViewController : FlobillerBaseViewController {
    
    __weak IBOutlet UIImageView     *statusImageView;
    __weak IBOutlet UILabel         *costLabel;
    __weak IBOutlet UILabel         *statusLabel;
    
    __weak IBOutlet UILabel         *verificationTitleLabel;
    
    __weak IBOutlet UILabel         *codeValueLabel;
    
    __weak IBOutlet UIButton        *buttonViewRecipt;
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet NSLayoutConstraint *constraintDistance;
    __weak IBOutlet NSLayoutConstraint *constraintHeightTextView;
    
    __weak IBOutlet UIWebView *descriptionTextView;
    __weak IBOutlet UIButton *showMoreButton;
    __weak IBOutlet UIImageView *imageShowMore;

}
@property (strong,nonatomic) OrderInfo *orderDone;
@end
