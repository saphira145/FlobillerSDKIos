//
//  PaymentTableViewCell.h
//  Flobillersdk
//
//  Created by Do Quoc Lam on 10/30/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *paymentImage;
@property (weak, nonatomic) IBOutlet UIView *viewHighlight;

@end
