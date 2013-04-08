//
//  UIViewController+Aux.h
//  
//
//  Created by Marina Gray on 2013-02-22.
//  Copyright (c) 2013 Marina Gray. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIViewController (Aux)

- (UIBarButtonItem *) makeBarButtonWithAction:(SEL)action onImageName:(NSString *)on offImageName:(NSString *)off;
- (UIBarButtonItem *) makeBarButtonWithAction:(SEL)action onImageName:(NSString *)on offImageName:(NSString *)off shiftDown:(NSUInteger)y;
- (UIBarButtonItem *)makeBackBarButtonWithImageName:(NSString *)on offImageName:(NSString *)off;

- (UIBarButtonItem *)makeBackBarButtonWithImageName:(NSString *)on offImageName:(NSString *)off longPressGoesBack:(NSUInteger)level;
- (UIBarButtonItem *)makeBackBarButtonWithImageName:(NSString *)on offImageName:(NSString *)off longPressGoesBack:(NSUInteger)level shiftDown:(NSUInteger)y;

- (UIBarButtonItem *)makeBackBarButtonWithImageName:(NSString *)on offImageName:(NSString *)off shiftDown:(NSUInteger)y;

- (UIButton *) makeButtonWithAction:(SEL)action onImageName:(NSString *)on offImageName:(NSString *)off;

- (void)setNavigationTitleView:(NSString *)title;

- (UIBarButtonItem *)makePrevNextButtonsWithAction:(SEL)action tag:(NSUInteger)tag minIndex:(NSUInteger)min maxIndex:(NSUInteger)max;

@end
