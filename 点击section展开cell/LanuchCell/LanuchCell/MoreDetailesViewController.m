//
//  MoreDetailesViewController.m
//  6Du
//
//  Created by chenhao on 14-3-18.
//  Copyright (c) 2014年 chenhao. All rights reserved.
//

#import "MoreDetailesViewController.h"

#import "MoreTableView.h"

@interface MoreDetailesViewController ()

@end

@implementation MoreDetailesViewController

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
	// Do any additional setup after loading the view.
    self.title = @"这只是个Demo";

    MoreTableView *moreView = [[MoreTableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    [self.view addSubview:moreView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
