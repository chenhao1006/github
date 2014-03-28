//
//  EmojiPage_2.h
//  EmojiKeyBoard
//
//  Created by chenhao on 14-3-20.
//  Copyright (c) 2014年 chenhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EmojiPage_2Delegate <NSObject>

- (void)getButtonTitle:(NSString *)title;
- (void)clickDelButton:(UIButton *)button;

@end

@interface EmojiPage_2 : UIView <UIScrollViewDelegate>
{
    UIScrollView *placeScrollView;
}
@property (nonatomic, assign) int pages;
@property (nonatomic, assign) int currentPage;
@property (nonatomic, assign) id<EmojiPage_2Delegate>delegate;

@end
