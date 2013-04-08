//
//  MGSplitViewController.h
//  
//  Created by Marina Gray on 2013-03-12.
//  Copyright (c) 2013 Marina Gray. All rights reserved.

/*
 View controller inspired by UISplitViewController with increased flexibility.
 Presents two views side by side, split vertically or horizontally. The left/top view is presented with fixed width, the right/bottom view takes up the remainder of space.
*/

#import <UIKit/UIKit.h>

typedef enum {
    MGSplitViewVertical,
    MGSplitViewHorizontal
} MGSplitViewDirection;

@interface MGSplitViewController : UIViewController

/* 
 Explicitly set both of the below properties to display them in the split view.
 MGSplitViewController has an observer set up on these properties and both controllers will be immediately redrawn when set.
 */
// controller positioned on the left or top
@property (nonatomic, strong) UIViewController *masterViewController;
// controller positioned on the right or bottom
@property (nonatomic, strong) UIViewController *detailViewController;

@property (nonatomic) CGFloat masterWidth;
@property (nonatomic) CGFloat gapWidth;

@property (nonatomic) MGSplitViewDirection splitDirection;

@end
