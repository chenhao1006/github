//
//  EmojiPage_2.m
//  EmojiKeyBoard
//
//  Created by chenhao on 14-3-20.
//  Copyright (c) 2014年 chenhao. All rights reserved.
//

#import "EmojiPage_2.h"

@implementation EmojiPage_2

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self viewDidLoad];
    }
    return self;
}

- (void)viewDidLoad
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollViewCurrenPage:) name:@"EmojiKeyBoardChangeEmoji_2CurrentPage" object:nil];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"EmojisList"
                                                          ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    
    float placesPageCount = [dic[@"Places"] count] / 39;
    self.pages = (int)[dic[@"Places"] count] / 39;
    for (NSString *str in dic[@"Places"]) {
        NSLog(@"%@",str);
    }
    
    placeScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    placeScrollView.contentSize = CGSizeMake(placeScrollView.frame.size.width * placesPageCount, placeScrollView.frame.size.height);
    placeScrollView.backgroundColor = self.backgroundColor;
    placeScrollView.pagingEnabled = YES;
    placeScrollView.delegate = self;
    for (int page = 0; page < placesPageCount; page ++) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0 + placeScrollView.frame.size.width * page, 0, placeScrollView.frame.size.width, placeScrollView.frame.size.height)];
        bgView.backgroundColor = [UIColor clearColor];
        for (int i = 0; i < 4; i ++) {
            for (int j = 0; j < 10; j ++) {
                
                if ((40 * page + (10 * i + j)) < [dic[@"Places"] count]) {
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                    
                    [button setFrame:CGRectMake(10 + 30 * j, 5 + 30 * i, 30, 30)];
                    [button setTag:(40 * page + (10 * i + j))];
                    if ((10 * i + j) == 39) {
                        [button setImage:[UIImage imageNamed:@"backspace_n.png"] forState:UIControlStateNormal];
                        [button setTitle:@"删除" forState:UIControlStateNormal];
                        [button.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
                        [button.titleLabel setTextColor:[UIColor clearColor]];
                    }
                    else
                    {
                        if (button.tag == [dic[@"Places"] count] - 1) {
                            [button setImage:[UIImage imageNamed:@"backspace_n.png"] forState:UIControlStateNormal];
                            [button setTitle:@"删除" forState:UIControlStateNormal];
                            [button.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
                            [button.titleLabel setTextColor:[UIColor clearColor]];
                        }
                        else
                        {
                            [button.titleLabel setFont:[UIFont fontWithName:@"Apple color emoji" size:16.0f]];
                            [button setTitle:[dic[@"Places"] objectAtIndex:button.tag] forState:UIControlStateNormal];
                        }
                        
                    }
                    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
                    [bgView addSubview:button];
                }
            }
        }
        [placeScrollView addSubview:bgView];
    }
    [self addSubview:placeScrollView];
}
- (void)buttonPressed:(UIButton *)Button
{
    if (![Button.titleLabel.text isEqualToString:@"删除"]) {
        [self.delegate getButtonTitle:Button.titleLabel.text];
    }
    else
    {
        [self.delegate clickDelButton:Button];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)ascrollView
{
    NSLog(@"%@",@"不移动了");
    self.currentPage = ascrollView.contentOffset.x / ascrollView.frame.size.width;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EmojiPage_2" object:[NSNumber numberWithInt:ascrollView.contentOffset.x / ascrollView.frame.size.width]];
}
- (void)changeScrollViewCurrenPage:(NSNotification *)not
{
    [placeScrollView setContentOffset:CGPointMake([[not object] integerValue] * placeScrollView.frame.size.width, 0) animated:YES];
}
@end
