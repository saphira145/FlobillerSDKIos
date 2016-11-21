//
//  CustomField.h
//  Flobillersdk
//
//  Created by Do Quoc Lam on 10/24/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomField : NSObject
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *displayName;
@property (copy,nonatomic) NSString *type;
@property (copy,nonatomic) NSNumber *maxLength;
@property (copy,nonatomic) NSNumber *minLength;
- (instancetype)initWithDictionary:(NSDictionary *)JSONDictionary;
@end
