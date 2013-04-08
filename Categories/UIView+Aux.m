//
//  UIView+Borders.m
//  
//
//  Created by Marina Gray on 2013-02-08.
//  Copyright (c) 2013 Marina Gray. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UIView+Aux.h"

@implementation UIView (Aux)

- (void)drawBorder:(CGFloat)width color:(UIColor *)color {
    if (!color) color = [UIColor blackColor];
    if (width < 0) width = 1;
    if (width < 1) {
        // draw borders bottom and left only
        UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1)];
        bottom.backgroundColor = color;
        UIView *left = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, self.frame.size.height)];
        left.backgroundColor = color;
        
        [self addSubview:bottom];
        [self addSubview:left];
    } else {
        self.layer.borderColor = color.CGColor;
        self.layer.borderWidth = width;
    }
}

- (UIImage *)getImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [[UIScreen mainScreen]scale]);
    [[self layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

- (NSArray *)subviewsWithClassNamePrefix:(NSString *)prefix{
    NSMutableArray *result = [NSMutableArray array];
    
    // Breadth-first population of matching subviews
    // First traverse the next level of subviews, adding matches.
    for (UIView *view in self.subviews) {
        if ([NSStringFromClass([view class]) hasPrefix:prefix]) {
            [result addObject:view];
        }
    }
    
    // Now traverse the subviews of the subviews, adding matches.
    for (UIView *view in self.subviews) {
        NSArray *matchingSubviews = [view subviewsWithClassNamePrefix:prefix];
        [result addObjectsFromArray:matchingSubviews];
    }
    
    return result;
}

- (UIViewController *)getViewController {
    /// Finds the view's view controller.
    
    // Take the view controller class object here and avoid sending the same message iteratively unnecessarily.
    Class vcc = [UIViewController class];
    
    // Traverse responder chain. Return first found view controller, which will be the view's view controller.
    UIResponder *responder = self;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: vcc])
            return (UIViewController *)responder;
    
    // If the view controller isn't found, return nil.
    return nil;
}


@end
