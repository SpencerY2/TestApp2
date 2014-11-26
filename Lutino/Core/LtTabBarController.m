//
//  LtTabBarController.m
//  Lutino
//
//  Created by Spencer Yeh on 11/15/13.
//  Copyright (c) 2013 Yeh Technology. All rights reserved.
//

#import "LtTabBarController.h"

@interface LtTabBarController ()

@end

@implementation LtTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"WebStoryboard" bundle:nil];
    UINavigationController * webView = (UINavigationController *)[storyboard instantiateInitialViewController];
    webView.title = NSLocalizedString(@"Web", @"");
    
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.viewControllers];
    [viewControllers insertObject:webView atIndex:1];
    
    self.viewControllers = viewControllers;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
