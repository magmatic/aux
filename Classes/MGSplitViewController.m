//
//  MGSplitViewController.m
//  
//
//  Created by Marina Gray on 2013-03-12.
//  Copyright (c) 2013 Marina Gray. All rights reserved.
//

#import "MGSplitViewController.h"

@interface MGSplitViewController ()

- (CGRect) masterViewFrame;
- (CGRect) detailViewFrame;

@end

@implementation MGSplitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.masterWidth = 254;
        self.gapWidth = 1;
        self.masterViewController = [[UIViewController alloc] init];
        self.detailViewController = [[UIViewController alloc] init];
        self.splitDirection = MGSplitViewVertical;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // set up observers to immediately reflect changes on screen
    for (NSString *keyPath in @[@"detailViewController", @"masterViewController", @"masterWidth", @"gapWidth", @"splitDirection"])
        [self addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self) {
        [self layoutSubviews];
    }
}

- (void)layoutSubviews {
    [self setFrameSizes];
    
    for (UIView *v in self.view.subviews) [v removeFromSuperview];
    
    for (UIViewController *vc in @[self.masterViewController, self.detailViewController]) {
        [vc viewWillAppear:NO];
        [self.view addSubview:vc.view];
        [vc viewDidAppear:NO];
    }
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
    [self.masterViewController viewWillAppear:NO];
	[self.detailViewController viewWillAppear:NO];
	
	[self layoutSubviews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.masterViewController viewDidAppear:NO];
	[self.detailViewController viewDidAppear:NO];
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self setFrameSizes];

    [self.masterViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self.detailViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (void) setFrameSizes {
    self.masterViewController.view.frame = [self masterViewFrame];
    self.detailViewController.view.frame = [self detailViewFrame];
}

- (CGRect) masterViewFrame{
    // origin = (0,0)
    // height = height of the full view
    // width = masterWidth
    CGRect f;
    f.origin.x = 0;
    f.origin.y = 0;
    
    if (self.splitDirection == MGSplitViewVertical) {
        f.size.height = self.view.bounds.size.height;
        f.size.width = self.masterWidth;
    } else {
        f.size.width = self.view.bounds.size.width;
        f.size.height = self.masterWidth;
    }
    return f;
}

- (CGRect) detailViewFrame{
    // origin = aligned to top, after masterView and gap
    // height = height of full view
    // width = width of full view - masterWidth - gapWidth
    CGRect f;
    if (self.splitDirection == MGSplitViewVertical) {
        f.origin.x = self.masterWidth + self.gapWidth;
        f.origin.y = 0;
        f.size.height = self.view.bounds.size.height;
        f.size.width = self.view.bounds.size.width - f.origin.x;
    } else {
        f.origin.x = 0;
        f.origin.y = self.masterWidth + self.gapWidth;
        f.size.height = self.view.bounds.size.height - f.origin.y;
        f.size.width = self.view.bounds.size.width;

    }
    return f;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
