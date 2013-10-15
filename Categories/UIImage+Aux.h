//
//  UIImage+Aux.h
//  
//
//  Created by Marina Gray on 2013-04-04.
//  Copyright (c) 2013 Marina Gray. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Aux)
- (UIColor *)getColorAtPoint:(CGPoint)p;
- (CGSize)sizeThatFits:(CGSize)size;
@end
