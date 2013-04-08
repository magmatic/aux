//
//  UITableView+Aux.h
//  
//
//  Created by Marina Gray on 2013-03-05.
//  Copyright (c) 2013 Marina Gray. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Aux)

- (CGFloat) getMargin;
- (UIView *)makeFakeCellSeparatorAtHeight:(CGFloat)height withTag:(NSInteger)tag;
- (BOOL) needsScrollingToCellAtIndexPath:(NSIndexPath*)indexPath;

@end
