//
//  MoreTableViewCell.m
//  6Du
//
//  Created by chenhao on 14-3-19.
//  Copyright (c) 2014年 chenhao. All rights reserved.
//

#import "MoreTableViewCell.h"

@implementation MoreTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 5, 40, 40)];
    imageView.image = [UIImage imageNamed:@"touxiang2.jpg"];
    imageView.layer.cornerRadius = 6;
    [self.contentView addSubview:imageView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.size.width + imageView.frame.origin.x + 20, 3, 200, 20)];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.font = [UIFont systemFontOfSize:12.0f];
    nameLabel.text = @"刘大明";
    [self.contentView addSubview:nameLabel];
    
    UILabel *positionLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabel.frame.origin.x, imageView.frame.size.height + imageView.frame.origin.y - 17, 200, 20)];
    positionLabel.textAlignment = NSTextAlignmentLeft;
    positionLabel.textColor = [UIColor lightGrayColor];
    positionLabel.font = [UIFont systemFontOfSize:10.0f];
    positionLabel.text = @"人力资源部-主管";
    [self.contentView addSubview:positionLabel];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1)];
    view.backgroundColor = RGB_COLOR(222, 222, 222, 1);
    [self.contentView addSubview:view];
}

@end
