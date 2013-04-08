//
//  UITableView+Aux.m
//  
//
//  Created by Marina Gray on 2013-03-05.
//  Copyright (c) 2013 Marina Gray. All rights reserved.
//

#import "UITableView+Aux.h"

@implementation UITableView (Aux)

- (CGFloat)getMargin {
    CGFloat marginWidth; // margin b/w view edge and cell
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        // margins are variable
        if (self.bounds.size.width < 400) {
            marginWidth = 10;
        } else marginWidth = MAX(31, MIN(45, self.bounds.size.width*0.06));
    } else marginWidth = 10;
    return marginWidth;
}

- (UIView *)makeFakeCellSeparatorAtHeight:(CGFloat)height withTag:(NSInteger)tag {
    // creates a view that looks like a cell separator in a grouped tableView
    // matches the width of cells of the receiver
    // frame.origin.y set to the height provided
    
    CGFloat width = self.frame.size.width - [self getMargin]*2;
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, height, width, 2)];
    
    UIColor *grayColor = [UIColor colorWithWhite:202.0/255.0 alpha:1];
    UIColor *highlightColor = [UIColor colorWithWhite:253.0/255.0 alpha:1];
    v.backgroundColor = grayColor;
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 1, width, 1)];
    line2.backgroundColor = highlightColor;
    [v addSubview:line2];
    
    v.tag = tag;
    return v;
}

- (BOOL)needsScrollingToCellAtIndexPath:(NSIndexPath *)indexPath {
    // determines if the cell at indexPath is visible and scrolls to it if needed
    // cells above the visible area get aligned to top of view
    // cells below get aligned to bottom
    
    // return YES if scrolling was initiated to ensure the cell is visible
    
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
    
    CGFloat origin = cell.frame.origin.y;
    CGFloat height = cell.frame.size.height;
    if (!cell) {
        height = self.rowHeight;
        origin = 2 + height*(indexPath.row - 1) + [self.delegate tableView:self heightForHeaderInSection:indexPath.section];
    }

    // check if the cell is within the visible area
    if (origin + height > self.frame.size.height + self.bounds.origin.y) {
        // the cell is below the visible area
        [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        return YES;
    } else if (origin < self.bounds.origin.y) {
        // the cell is above the visible area
        [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        return YES;
    }
    return NO;
}
@end
