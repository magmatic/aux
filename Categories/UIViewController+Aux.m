//
//  UIViewController+Aux.m
//  
//
//  Created by Marina Gray on 2013-02-22.
//  Copyright (c) 2013 Marina Gray. All rights reserved.
//

#import "UIViewController+Aux.h"

@implementation UIViewController (Aux)

- (UIBarButtonItem *)makeBarButtonWithAction:(SEL)action onImageName:(NSString *)on offImageName:(NSString *)off {
    // returns a button with images taken from files with names specified
    // with action specified and target:self

    return [self makeBarButtonWithAction:action onImageName:on offImageName:off shiftDown:0];
}

- (UIBarButtonItem *)makeBarButtonWithAction:(SEL)action onImageName:(NSString *)on offImageName:(NSString *)off shiftDown:(NSUInteger)y {
    // returns a button with images taken from files with names specified
    // with action specified and target:self
    
    UIImageView *ivOff = [[UIImageView alloc] initWithImage:[UIImage imageNamed:off]];
    UIImageView *ivOn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:on]];
    
    CGRect f = ivOff.frame;
    UIView *tmp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, f.size.width, f.size.height + y)];
    
    f.origin.y = y;
    ivOff.frame = f;
    [tmp addSubview:ivOff];
    UIImage *imgOff = [tmp getImage];
    [ivOff removeFromSuperview];
    
    ivOn.frame = f;
    [tmp addSubview:ivOn];
    UIImage *imgOn = [tmp getImage];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:tmp.bounds];
    [btn setBackgroundImage:imgOff forState:UIControlStateNormal];
    [btn setBackgroundImage:imgOn forState:UIControlStateHighlighted];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (UIBarButtonItem *)makeBackBarButtonWithImageName:(NSString *)on offImageName:(NSString *)off {
    return [self makeBarButtonWithAction:@selector(act_popNavigation) onImageName:on offImageName:off shiftDown:0];
}

- (UIBarButtonItem *)makeBackBarButtonWithImageName:(NSString *)on offImageName:(NSString *)off shiftDown:(NSUInteger)y {
    return [self makeBarButtonWithAction:@selector(act_popNavigation) onImageName:on offImageName:off shiftDown:y];
}


- (UIBarButtonItem *)makeBackBarButtonWithImageName:(NSString *)on offImageName:(NSString *)off longPressGoesBack:(NSUInteger)level{
    return [self makeBackBarButtonWithImageName:on offImageName:off longPressGoesBack:level shiftDown:0];
}

- (UIBarButtonItem *)makeBackBarButtonWithImageName:(NSString *)on offImageName:(NSString *)off longPressGoesBack:(NSUInteger)level shiftDown:(NSUInteger)y {
    UIImageView *ivOff = [[UIImageView alloc] initWithImage:[UIImage imageNamed:off]];
    UIImageView *ivOn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:on]];
    
    CGRect f = ivOff.frame;
    UIView *tmp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, f.size.width, f.size.height + y)];
    
    f.origin.y = y;
    ivOff.frame = f;
    [tmp addSubview:ivOff];
    UIImage *imgOff = [tmp getImage];
    [ivOff removeFromSuperview];
    
    ivOn.frame = f;
    [tmp addSubview:ivOn];
    UIImage *imgOn = [tmp getImage];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:tmp.bounds];
    [btn setBackgroundImage:imgOff forState:UIControlStateNormal];
    [btn setBackgroundImage:imgOn forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(act_popNavigation) forControlEvents:UIControlEventTouchUpInside];
    
    UILongPressGestureRecognizer *g = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(act_popNestedNavigation:)];
    btn.tag = level;
    g.minimumPressDuration = 0.7;
    [btn addGestureRecognizer:g];

    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (UIButton *)makeButtonWithAction:(SEL)action onImageName:(NSString *)on offImageName:(NSString *)off {
    UIImage *imgOff = [UIImage imageNamed:off];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, imgOff.size.width, imgOff.size.height)];
    [btn setBackgroundImage:imgOff forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:on] forState:UIControlStateHighlighted];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];

    return btn;
}

- (void) act_popNestedNavigation: (UIGestureRecognizer *)sender {
    NSUInteger level = sender.view.tag;
    NSInteger last = self.navigationController.viewControllers.count - 1;
    if (level > last) [self.navigationController popViewControllerAnimated:YES];
    else {
        UIViewController *vc = self.navigationController.viewControllers[last-level];
        [self.navigationController popToViewController:vc animated:YES];
    }
}

- (void) act_popNavigation {
    // helper method for custom back buttons
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setNavigationTitleView:(NSString *)title {
    CGFloat size = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 20 : 18;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:size];
    label.shadowColor = [UIColor blackColor];
    label.shadowOffset = CGSizeMake(0, -1);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.text = title;
    [label sizeToFit];
    
    self.navigationItem.titleView = label;
}

- (UIBarButtonItem *)makePrevNextButtonsWithAction:(SEL)action tag:(NSUInteger)tag minIndex:(NSUInteger)min maxIndex:(NSUInteger)max{
    UISegmentedControl *segControl = [[UISegmentedControl alloc] initWithItems:@[@"Previous", @"Next"]];
    [segControl addTarget:self action:@selector(switchTextField:) forControlEvents:UIControlEventValueChanged];
    segControl.segmentedControlStyle = UISegmentedControlStyleBar;
    segControl.tintColor = [UIColor colorWithWhite:0.1 alpha:1];
    segControl.tag = tag;
    [segControl setWidth:90 forSegmentAtIndex:0];
    [segControl setWidth:90 forSegmentAtIndex:1];
    segControl.momentary = YES;
    if (segControl.tag == min) [segControl setEnabled:NO forSegmentAtIndex:0];
    else if (segControl.tag == max) [segControl setEnabled:NO forSegmentAtIndex:1];
    
    return [[UIBarButtonItem alloc] initWithCustomView:segControl];

}

@end
