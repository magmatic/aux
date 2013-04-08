//
//  UIView+Borders.h
//  
//
//  Created by Marina Gray on 2013-02-08.
//  Copyright (c) 2013 Marina Gray. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Aux)

- (void) drawBorder:(CGFloat)width color:(UIColor*)color;
- (UIImage *)getImage;
- (NSArray *)subviewsWithClassNamePrefix:(NSString *)prefix;
- (UIViewController *)getViewController;

@end
