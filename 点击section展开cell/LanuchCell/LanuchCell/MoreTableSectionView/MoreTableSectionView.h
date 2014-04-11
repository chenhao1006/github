//
//  MoreTableSectionView.h
//  6Du
//
//  Created by chenhao on 14-3-18.
//  Copyright (c) 2014年 chenhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MoreTableSectionViewDelegate <NSObject>

- (void)doAnimationWithTitleLabel:(UILabel *)titleLabel numLabel:(UILabel *)numLabel dirLabel:(UIButton *)dirLabel withBgView:(UIView *)bgView isClicked:(BOOL)isClicked inSection:(NSInteger)section;

@end

@interface MoreTableSectionView : UIView

{
    UILabel *titleLabel;
    UILabel *numLabel;
    UIButton *directionLabel;
}
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *num;
@property (nonatomic, assign) NSInteger buttonTag;


@property (nonatomic, assign) BOOL isClicked;

@property (nonatomic, assign) id<MoreTableSectionViewDelegate>delegate;

@end
