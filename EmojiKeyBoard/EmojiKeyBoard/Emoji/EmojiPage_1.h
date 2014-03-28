//
//  EmojiPage.h
//  6Du
//
//  Created by chenhao on 14-3-20.
//  Copyright (c) 2014年 chenhao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol EmojiPage_1Delegate <NSObject>

- (void)getButtonTitle:(NSString *)title;
- (void)clickDelButton:(UIButton *)button;

@end
@interface EmojiPage_1 : UIView <UIScrollViewDelegate>
{
    UIScrollView *scrollView;
}
@property (nonatomic, assign) int pages;
@property (nonatomic, assign) int currentPage;
@property (nonatomic, assign) id<EmojiPage_1Delegate>delegate;
@end
