//
//  DoneViewController.m
//  Flobillersdk
//
//  Created by Do Quoc Lam on 11/2/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import "DoneViewController.h"
#import "FBConst.h"
#import "CommonUtilities.h"
#import "UIImage+Bundle.h"

@interface DoneViewController () {
    NSString *descriptionString;
    CGFloat descriptionHeight;
    BOOL isShowMore;
}

@end

@implementation DoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
    isShowMore = YES;
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    descriptionHeight = [CommonUtilities findHeightForText:descriptionString havingWidth:descriptionTextView.frame.size.width andFont:[UIFont systemFontOfSize:17.0f]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpView {
    scrollView.layer.borderWidth = 1.0f;
    scrollView.layer.cornerRadius = 3.0f;
    buttonViewRecipt.layer.borderWidth = 1.0f;
    buttonViewRecipt.layer.cornerRadius = 3.0f;

    costLabel.text = [NSString stringWithFormat:@"%@%.2f",self.orderDone.currencyName,self.orderDone.amount];
    if ([self.orderDone.status isEqualToString:STATUS_SUCCESS]) {
        descriptionTextView.hidden = YES;
        showMoreButton.hidden      = YES;
        statusImageView.image = [UIImage imageNamedInBundle:@"ic_success"];
    }else{
        verificationTitleLabel.hidden = YES;
        codeValueLabel.hidden = YES;
        NSData *htmlData = [self.orderDone.instruction dataUsingEncoding:NSUnicodeStringEncoding];
        NSAttributedString *attrString = [[NSAttributedString alloc]
                                          initWithData:htmlData
                                          options:@{
                                                    NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType
                                                    }
                                          documentAttributes:nil
                                          error:nil];
        descriptionString = attrString.string;
//        descriptionTextView.text = descriptionString;
        
        
        NSMutableString *html = [NSMutableString stringWithString: @"<html><head><title></title></head><body style=\"background:transparent;\">"];
        
        //continue building the string
        [html appendString:self.orderDone.instruction?self.orderDone.instruction:@""];
        [html appendString:@"</body></html>"];
        
        
        
        //pass the string to the webview
        [descriptionTextView loadHTMLString:[html description] baseURL:nil];
        if ([self.orderDone.status isEqualToString:STATUS_PENDING]) {
            statusLabel.text = @"PAYMENT IS PENDING!";
            statusImageView.image = [UIImage imageNamedInBundle:@"ic_warning"];
            
        } else {
            statusLabel.text = @"PAYMENT IS DECLINED!";
            statusImageView.image = [UIImage imageNamedInBundle:@"ic_cancel"];
            showMoreButton.hidden = YES;
            constraintDistance.constant = 40.0f;
        }
        statusLabel.textColor = [UIColor redColor];
    }
}
- (IBAction)showMoreButtonAction:(id)sender {
    imageShowMore.image = isShowMore?[UIImage imageNamed:@"up"]:[UIImage imageNamedInBundle:@"down"];
    [UIView animateWithDuration:1.0 animations:^{
        if (isShowMore) {
            constraintHeightTextView.constant = descriptionHeight;
            if (descriptionHeight  >  120) {
                constraintDistance.constant = descriptionHeight  + 20;
            }
        } else {
            constraintDistance.constant  = 140;
        }
        isShowMore = !isShowMore;
        
        
    }];
    
}
- (IBAction)viewReceiptButtonAction:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
@end
