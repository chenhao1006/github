

//
//  MoreTableView.m
//  6Du
//
//  Created by chenhao on 14-3-18.
//  Copyright (c) 2014年 chenhao. All rights reserved.
//

#import "MoreTableView.h"

#import "MoreTableViewCell.h"
#import "MoreTableSectionView.h"
@interface MoreTableView ()<UITableViewDelegate, UITableViewDataSource, MoreTableSectionViewDelegate>
{
    UITableView *_tableView;
    NSArray *sectionTitleArray;
    
    NSMutableArray *launchOrNot;   //用来记录每个section底下的数量
    NSDictionary *rowDict;
    
    BOOL isLanuch;
    
    NSMutableArray *headerViewArray;
}
@end

@implementation MoreTableView

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
	// Do any additional setup after loading the view.
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self addSubview:_tableView];
    
    sectionTitleArray = [NSArray arrayWithObjects:@"人力资源部", @"市场部", @"生产开发部", @"售后服务部",nil];
    
    launchOrNot = [NSMutableArray new];
    //刚开始让它全为0，即全部的section都不是展开的
    for (int i = 0; i < sectionTitleArray.count; i ++) {
        if (i == 0) {
            //默认第一行展开，其他都不展开
            [launchOrNot addObject:[NSNumber numberWithInt:7]];
        }
        else
        {
            [launchOrNot addObject:[NSNumber numberWithInt:0]];
        }
        
    }
    
    /**
     *moneyDict,,techDict,,yuyingDict都是从服务器上去的数据
     *
     */
    NSArray *moneyDict = [[NSArray alloc] initWithObjects:@"xiaohong", @"xiaolv", @"xiaohuang", @"zhangsan", @"lisi", @"wanger", @"mazi", nil];
    NSArray *techDict = [[NSArray alloc] initWithObjects:@"小红", @"小绿", @"小黄", @"小黑", @"小紫", @"小兰", @"小青", nil];
    NSArray *yuyingDict = [[NSArray alloc] initWithObjects:@"巨蟹座", @"水瓶座", @"金牛座", @"双子座", @"双鱼座", @"处女座", @"天平座", nil];
    NSArray *yuyDict = [[NSArray alloc] initWithObjects:@"巨蟹座", @"水瓶座", @"金牛座", @"双子座", @"双鱼座", @"处女座", @"天平座", nil];
    
    rowDict = [[NSDictionary alloc] initWithObjectsAndKeys:moneyDict, @"人力资源部", techDict, @"市场部", yuyingDict, @"生产开发部", yuyDict, @"售后服务部",nil];
    headerViewArray = [NSMutableArray new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return sectionTitleArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [[launchOrNot objectAtIndex:section] intValue];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 28.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"cellID";
    MoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[MoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MoreTableSectionView *headerView = nil;
    if (section >= [headerViewArray count]) {
        headerView = [[MoreTableSectionView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 28)];
        headerView.buttonTag = section;
        headerView.title = [sectionTitleArray objectAtIndex:section];
        headerView.num = @"102";
        headerView.isClicked = isLanuch;
        if (section == 0) {
            headerView.isClicked = YES;
        }
        else
        {
            headerView.isClicked = NO;
            
        }
        headerView.delegate = self;
        
        [headerViewArray addObject:headerView];
    }
    else
    {
        headerView= headerViewArray[section];
    }
    
    return headerView;
}

#pragma mark -
- (void)doAnimationWithTitleLabel:(UILabel *)titleLabel numLabel:(UILabel *)numLabel dirLabel:(UIButton *)dirLabel withBgView:(UIView *)bgView isClicked:(BOOL)isClicked inSection:(NSInteger)section
{
    NSInteger cellCount = [[launchOrNot objectAtIndex:section] integerValue];
    if (cellCount == 0) {
        cellCount = [[rowDict objectForKey:[sectionTitleArray objectAtIndex:section]] count];
    }else{
        cellCount = 0;
    }
    [launchOrNot replaceObjectAtIndex:section withObject:[NSNumber numberWithInteger:cellCount]];
    
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    
    UIColor *lanuchTextColor = RGB_COLOR(0, 131, 177, 1);
    UIColor *lanuchNotTextColor = [UIColor whiteColor];
    
    UIColor *lanuchBgColor = RGB_COLOR(149, 218, 241, 1);
    UIColor *lanuchNotBgColor = RGB_COLOR(161, 173, 182, 1);
    
    float lanuchRangle = M_PI_2;
    float lanuchNotRangle = 0;
    
    if (isClicked) {
        [UIView animateWithDuration:.2 animations:^{
            titleLabel.textColor = lanuchTextColor;
            numLabel.textColor = lanuchTextColor;
            bgView.backgroundColor = lanuchBgColor;
            dirLabel.transform = CGAffineTransformMakeRotation(lanuchRangle);
        }];
    }
    else
    {
        [UIView animateWithDuration:.2 animations:^{
            titleLabel.textColor = lanuchNotTextColor;
            numLabel.textColor = lanuchNotTextColor;
            bgView.backgroundColor = lanuchNotBgColor;
            dirLabel.transform = CGAffineTransformMakeRotation(lanuchNotRangle);
        }];
    }
}

@end
