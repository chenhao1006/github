//
//  EmojiKeyBoard.h
//  EmojiKeyBoard
//
//  Created by chenhao on 14-3-20.
//  Copyright (c) 2014年 chenhao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EmojiPage_1.h"
#import "EmojiPage_2.h"

@class EmojiPage_1;
@class EmojiPage_2;

@protocol EmojiKeyBoardDelegate <NSObject>
- (void)chooseEmoji:(NSString *)emoji;
- (void)delEmoji:(UIButton *)button;
- (void)sendMeg:(UIButton *)button;
@end

@interface EmojiKeyBoard : UIView <EmojiPage_1Delegate, EmojiPage_2Delegate>
{
    UIScrollView *scroller;
    UIPageControl *pageControl;
    
    EmojiPage_1 *emoji;
    EmojiPage_2 *emoji2;
    
    int  showEmojiIndex;
    BOOL isFirstChooseEmoji2;
}
@property (nonatomic, assign) id<EmojiKeyBoardDelegate>delegate;
@end
