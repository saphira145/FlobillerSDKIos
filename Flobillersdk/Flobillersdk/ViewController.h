//
//  ViewController.h
//  Flobillersdk
//
//  Created by Do Quoc Lam on 10/24/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "FlocashService.h"
@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

