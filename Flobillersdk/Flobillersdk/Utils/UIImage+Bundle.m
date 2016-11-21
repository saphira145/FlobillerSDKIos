//
//  UIImage+Bundle.m
//  Flobillersdk
//
//  Created by Do Quoc Lam on 11/18/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import "UIImage+Bundle.h"
#import "PaymentViewController.h"

@implementation UIImage (Bundle)
+(UIImage *)imageNamedInBundle:(NSString *)name {
    NSBundle *bundle = [NSBundle bundleForClass:[FlobillerBaseViewController class]];
    NSString *imagePath = [bundle pathForResource:name ofType:@"png"];
    return [UIImage imageWithContentsOfFile:imagePath];
}
@end
