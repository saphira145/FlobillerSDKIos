//
//  FlocashService.h
//  Flobillersdk
//
//  Created by Do Quoc Lam on 11/18/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import <Foundation/Foundation.h> 
#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "FBConst.h"
#import "Request.h"

@interface FlocashService : NSObject

@property (nonatomic) FBEEnvironment evironment;
@property (nonatomic) BOOL networkStatus;
@property (strong, nonatomic) Reachability *reachability;

+ (instancetype)sharedInstance;

- (void)createOrder:(Request*)request presentCreateOrderViewFrom:(UIViewController *)topViewController;

@end
