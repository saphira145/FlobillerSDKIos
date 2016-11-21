//
//  CommonUtilities.m
//  Flobillersdk
//
//  Created by Do Quoc Lam on 10/30/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import "CommonUtilities.h"
#import <objc/runtime.h>


@implementation CommonUtilities

+ (NSDictionary *) dictionaryWithPropertiesOfObject:(id)obj {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([obj class], &count);
    
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        if ([obj valueForKey:key]) {
            [dict setObject:[obj valueForKey:key] forKey:key];
        }
        
    }
    
    free(properties);
    
    return [NSDictionary dictionaryWithDictionary:dict];
}

+ (CGFloat)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font
{
    CGFloat result = font.pointSize + 4;
    CGSize size;
    if (text)
    {
        CGSize textSize = { widthValue, CGFLOAT_MAX };       //Width and height of text area
        
        
        //iOS 7
        CGRect frame = [text boundingRectWithSize:textSize
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{ NSFontAttributeName:font }
                                          context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height+1);
    }
    result = MAX(size.height, result);
   
    return result;
}

@end
