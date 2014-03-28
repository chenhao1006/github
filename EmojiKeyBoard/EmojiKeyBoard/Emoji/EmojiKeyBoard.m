//
//  EmojiKeyBoard.m
//  EmojiKeyBoard
//
//  Created by chenhao on 14-3-20.
//  Copyright (c) 2014年 chenhao. All rights reserved.
//

#import "EmojiKeyBoard.h"

@implementation EmojiKeyBoard

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emoji_1ChangePageControlValue:) name:@"EmojiPage_1" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emoji_2ChangePageControlValue:) name:@"EmojiPage_2" object:nil];
    
    isFirstChooseEmoji2 = YES;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    lineView.backgroundColor = [UIColor grayColor];
    [self addSubview:lineView];
    scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    scroller.contentSize = CGSizeMake(scroller.frame.size.width * 3, scroller.frame.size.height);
    scroller.scrollEnabled = NO;
    [scroller setContentOffset:CGPointMake(scroller.frame.size.width, 0) animated:NO];
    [self addSubview:scroller];
    
    emoji = [[EmojiPage_1 alloc] initWithFrame:CGRectMake(scroller.frame.size.width, 0, self.frame.size.width, 125)];
    emoji.delegate = self;
    [scroller addSubview:emoji];
    
    emoji2 = [[EmojiPage_2 alloc] initWithFrame:CGRectMake(scroller.frame.size.width * 2, 0, self.frame.size.width, 125)];
    emoji2.delegate = self;
    [scroller addSubview:emoji2];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 135, self.frame.size.width, 1)];
    lineView2.backgroundColor = [UIColor grayColor];
    [self addSubview:lineView2];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 126, self.frame.size.width, 10)];
    pageControl.numberOfPages = emoji.pages;
    pageControl.currentPage = emoji.currentPage;
    pageControl.hidesForSinglePage = YES;
    pageControl.pageIndicatorTintColor = [UIColor darkGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [pageControl addTarget:self action:@selector(pageControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:pageControl];
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 136, self.frame.size.width, 40)];
    buttonView.backgroundColor = [UIColor purpleColor];
    [self addSubview:buttonView];
    
    UIButton *ofenButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [ofenButton setTag:0];
    [ofenButton setBackgroundColor:[UIColor lightGrayColor]];
    [ofenButton setFrame:CGRectMake(0, 0, 80, buttonView.frame.size.height)];
    [ofenButton setTitle:@"常用" forState:UIControlStateNormal];
    [ofenButton.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [ofenButton.titleLabel setTextColor:[UIColor lightTextColor]];
    [ofenButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:ofenButton];
    
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(79, 0, 1, buttonView.frame.size.height)];
    lineView3.backgroundColor = [UIColor grayColor];
    [buttonView addSubview:lineView3];
    
    UIButton *classicButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [classicButton setTag:1];
    [classicButton setBackgroundColor:[UIColor lightGrayColor]];
    [classicButton setFrame:CGRectMake(80, 0, 80, buttonView.frame.size.height)];
    [classicButton setTitle:@"经典" forState:UIControlStateNormal];
    [classicButton.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [classicButton.titleLabel setTextColor:[UIColor lightTextColor]];
    [classicButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:classicButton];
    
    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(159, 0, 1, buttonView.frame.size.height)];
    lineView4.backgroundColor = [UIColor grayColor];
    [buttonView addSubview:lineView4];
    
    UIButton *otherButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [otherButton setTag:2];
    [otherButton setBackgroundColor:[UIColor lightGrayColor]];
    [otherButton setFrame:CGRectMake(160, 0, 80, buttonView.frame.size.height)];
    [otherButton setTitle:@"其他" forState:UIControlStateNormal];
    [otherButton.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [otherButton.titleLabel setTextColor:[UIColor lightTextColor]];
    [otherButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:otherButton];
    
    UIView *lineView5 = [[UIView alloc] initWithFrame:CGRectMake(239, 0, 1, buttonView.frame.size.height)];
    lineView5.backgroundColor = [UIColor grayColor];
    [buttonView addSubview:lineView5];
    
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [sendButton setTag:3];
    [sendButton setBackgroundColor:[UIColor blueColor]];
    [sendButton setFrame:CGRectMake(240, 0, 80, buttonView.frame.size.height)];
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [sendButton.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [sendButton.titleLabel setTextColor:[UIColor lightTextColor]];
    [sendButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:sendButton];
}

- (void)pageControlValueChanged:(UIPageControl *)apageControl
{
    if (showEmojiIndex == 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"EmojiKeyBoardChangeEmoji_1CurrentPage" object:[NSNumber numberWithInteger:pageControl.currentPage]];
    }
    else if (showEmojiIndex == 2)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"EmojiKeyBoardChangeEmoji_2CurrentPage" object:[NSNumber numberWithInteger:pageControl.currentPage]];
    }
    
    
}
- (void)emoji_1ChangePageControlValue:(NSNotification *)not
{
    pageControl.currentPage = [[not object] integerValue];
    emoji.currentPage = pageControl.currentPage;
    
    
}
- (void)emoji_2ChangePageControlValue:(NSNotification *)not
{
    pageControl.currentPage = [[not object] integerValue];
    emoji2.currentPage = pageControl.currentPage;
    isFirstChooseEmoji2 = NO;
}
- (void)buttonPressed:(UIButton *)button
{
    switch (button.tag) {
        case 0:
            [scroller setContentOffset:CGPointMake(0, 0) animated:NO];
            break;
        case 1:
            [scroller setContentOffset:CGPointMake(scroller.frame.size.width, 0) animated:NO];
            showEmojiIndex = 1;
            pageControl.numberOfPages = emoji.pages;
            pageControl.currentPage = emoji.currentPage;
            break;
        case 2:
            [scroller setContentOffset:CGPointMake(scroller.frame.size.width * 2, 0) animated:NO];
            pageControl.numberOfPages = emoji2.pages;
            showEmojiIndex = 2;
            if (isFirstChooseEmoji2) {
                pageControl.currentPage = 0;
            }
            pageControl.currentPage = emoji2.currentPage;
            break;

        case 3:
            [self.delegate sendMeg:button];
            break;

            
        default:
            break;
    }
}
- (void)getButtonTitle:(NSString *)title
{
    NSLog(@"%@",title);
    [self.delegate chooseEmoji:title];
}
- (void)clickDelButton:(UIButton *)button
{
    [self.delegate delEmoji:button];
    //取字符串中得最后两个字符 判断是否为emoji表情字符
//    if (contentTextView.text.length >= 2) {
//        NSString *str = [contentTextView.text substringFromIndex:[contentTextView.text length]-2];
//        BOOL isEmoji = [self stringContainsEmoji:str];
//        if (isEmoji) {
//            contentTextView.text = [contentTextView.text substringToIndex:[contentTextView.text length] - 2];
//        }
//        else
//        {
//            contentTextView.text = [contentTextView.text substringToIndex:[contentTextView.text length] - 1];
//        }
//    }
//    else
//    {
//        contentTextView.text = [contentTextView.text substringToIndex:[contentTextView.text length] - 1];
//    }
}

@end
