//
//  EmojiPage.m
//  6Du
//
//  Created by chenhao on 14-3-20.
//  Copyright (c) 2014年 chenhao. All rights reserved.
//


#import "EmojiPage_1.h"

@implementation EmojiPage_1

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self viewDidLoad];
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    /* 这部分是一些常见表情*/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollViewCurrenPage:) name:@"EmojiKeyBoardChangeEmoji_1CurrentPage" object:nil];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"EmojisList"
                                                          ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    
    float peoplePageCount = [dic[@"People"] count] / 39.0;
    self.pages = (int)peoplePageCount + 1;

    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * ((int)peoplePageCount + 1), scrollView.frame.size.height);
    scrollView.backgroundColor = self.backgroundColor;
    scrollView.pagingEnabled = YES;
    for (int page = 0; page < (int)peoplePageCount + 1; page ++) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0 + scrollView.frame.size.width * page, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
        bgView.backgroundColor = [UIColor clearColor];
        for (int i = 0; i < 4; i ++) {
            for (int j = 0; j < 10; j ++) {
                
                if ((40 * page + (10 * i + j)) < [dic[@"People"] count]) {
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
                        if (button.tag == [dic[@"People"] count] - 1) {
                            [button setImage:[UIImage imageNamed:@"backspace_n.png"] forState:UIControlStateNormal];
                            [button setTitle:@"删除" forState:UIControlStateNormal];
                            [button.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
                            [button.titleLabel setTextColor:[UIColor clearColor]];
                        }
                        else
                        {
                            [button.titleLabel setFont:[UIFont fontWithName:@"Apple color emoji" size:16.0f]];
                            [button setTitle:[dic[@"People"] objectAtIndex:button.tag] forState:UIControlStateNormal];
                        }
                        
                    }
                    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
                    [bgView addSubview:button];
                }
                
            }
        }
        [scrollView addSubview:bgView];
    }
    [self addSubview:scrollView];
}
- (void)buttonPressed:(UIButton *)button
{
    NSLog(@"点击了: %@",button.titleLabel.text);
    if (![button.titleLabel.text isEqualToString:@"删除"]) {
        [self.delegate getButtonTitle:button.titleLabel.text];
    }
    else
    {
        [self.delegate clickDelButton:button];
    }
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)ascrollView
{
    NSLog(@"%@",@"不移动了");
    self.currentPage = ascrollView.contentOffset.x / ascrollView.frame.size.width;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EmojiPage_1" object:[NSNumber numberWithInt:ascrollView.contentOffset.x / ascrollView.frame.size.width]];
}
- (void)changeScrollViewCurrenPage:(NSNotification *)not
{
    [scrollView setContentOffset:CGPointMake([[not object] integerValue] * scrollView.frame.size.width, 0) animated:YES];
}
@end
