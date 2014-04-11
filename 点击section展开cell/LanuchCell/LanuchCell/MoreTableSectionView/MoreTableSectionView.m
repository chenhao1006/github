//
//  MoreTableSectionView.m
//  6Du
//
//  Created by chenhao on 14-3-18.
//  Copyright (c) 2014年 chenhao. All rights reserved.
//

#import "MoreTableSectionView.h"

@implementation MoreTableSectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)setDelegate:(id<MoreTableSectionViewDelegate>)delegate
{
    _delegate = delegate;
    [self viewDidLoad];
}
- (void)viewDidLoad
{
    
    UIColor *lanuchTextColor = RGB_COLOR(0, 131, 177, 1);
    UIColor *lanuchNotTextColor = [UIColor whiteColor];
    UIColor *lanuchBgColor = RGB_COLOR(149, 218, 241, 1);
    UIColor *lanuchNotBgColor = RGB_COLOR(161, 173, 182, 1);
    float lanuchRangle = M_PI_2;
    float lanuchNotRangle = 0;
    
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    CGSize consSize = CGSizeMake(320, 2000);
    CGSize size = [self.title sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:consSize];
    titleLabel.numberOfLines = 1;
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.text = self.title;
    titleLabel.backgroundColor = [UIColor clearColor];
    
    titleLabel.frame = CGRectMake(10, 0, size.width, self.frame.size.height);
    titleLabel.tag = 5553;
    [self addSubview:titleLabel];
    
    numLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.frame.size.width + titleLabel.frame.origin.x + 10, 0, 100, self.frame.size.height)];
    numLabel.text = [NSString stringWithFormat:@"(%@)",self.num];
    
    numLabel.textAlignment = NSTextAlignmentLeft;
    numLabel.font = [UIFont systemFontOfSize:14.0f];
    numLabel.tag = 5554;
    numLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:numLabel];
    
    directionLabel = [UIButton buttonWithType:UIButtonTypeCustom];
    directionLabel.frame = CGRectMake(self.frame.size.width - 30, 5, 20, 20);
    directionLabel.tag = 5555;
    [directionLabel setImage:[UIImage imageNamed:@"right.png"] forState:UIControlStateNormal];
    directionLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:directionLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor clearColor]];
    [button setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [button setTag:self.buttonTag];
    [button addTarget:self action:@selector(sectionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    if (_isClicked) {
        titleLabel.textColor = lanuchTextColor;
        numLabel.textColor = lanuchTextColor;
        directionLabel.transform = CGAffineTransformMakeRotation(lanuchRangle);
        self.backgroundColor = lanuchBgColor;
    }
    else
    {
        titleLabel.textColor = lanuchNotTextColor;
        numLabel.textColor = lanuchNotTextColor;
        directionLabel.transform = CGAffineTransformMakeRotation(lanuchNotRangle);
        self.backgroundColor = lanuchNotBgColor;
    }
}

- (void)sectionButtonClick:(UIButton *)button
{
    if (self.isClicked) {
        self.isClicked = NO;
    }
    else
    {
        self.isClicked = YES;
    }
    [_delegate doAnimationWithTitleLabel:titleLabel numLabel:numLabel dirLabel:directionLabel withBgView:self isClicked:self.isClicked inSection:self.buttonTag];
}

@end
