//
//  ViewController.m
//  tableViewAndSuoying
//
//  Created by chenhao on 14-4-11.
//  Copyright (c) 2014年 chenhao. All rights reserved.
//

#import "ViewController.h"

#import "ChineseString.h"
#import "pinyin.h"
#import "MJNIndexView.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, MJNIndexViewDataSource>
{
    UITableView *_tableView;
    MJNIndexView *indexView;
    
    NSMutableArray *friendArray;
    NSMutableArray *sortedArrForArrays;
    NSMutableArray *sectionHeadsKeys;
    
    NSMutableArray *listArray;
}
@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"这只是个Demo";
    
    friendArray = [[NSMutableArray alloc] init];
    sortedArrForArrays = [[NSMutableArray alloc] init];
    sectionHeadsKeys = [[NSMutableArray alloc] init];      //initialize a array to hold keys like A,B,C ...
    
    //add test data
    [friendArray addObject:@"郭靖"];
    [friendArray addObject:@"黄蓉"];
    [friendArray addObject:@"杨过"];
    [friendArray addObject:@"苗若兰"];
    [friendArray addObject:@"令狐冲"];
    [friendArray addObject:@"小龙女"];
    [friendArray addObject:@"胡斐"];
    [friendArray addObject:@"水笙"];
    [friendArray addObject:@"任盈盈"];
    [friendArray addObject:@"白琇"];
    [friendArray addObject:@"狄云"];
    [friendArray addObject:@"石破天"];
    [friendArray addObject:@"殷素素"];
    [friendArray addObject:@"张翠山"];
    [friendArray addObject:@"张无忌"];
    [friendArray addObject:@"青青"];
    [friendArray addObject:@"袁冠南"];
    [friendArray addObject:@"萧中慧"];
    [friendArray addObject:@"袁承志"];
    [friendArray addObject:@"乔峰"];
    [friendArray addObject:@"王语嫣"];
    [friendArray addObject:@"段玉"];
    [friendArray addObject:@"虚竹"];
    [friendArray addObject:@"苏星河"];
    [friendArray addObject:@"丁春秋"];
    [friendArray addObject:@"庄聚贤"];
    [friendArray addObject:@"阿紫"];
    [friendArray addObject:@"阿朱"];
    [friendArray addObject:@"阿碧"];
    [friendArray addObject:@"鸠魔智"];
    [friendArray addObject:@"萧远山"];
    [friendArray addObject:@"慕容复"];
    [friendArray addObject:@"慕容博"];
    [friendArray addObject:@"Jim"];
    [friendArray addObject:@"Lily"];
    [friendArray addObject:@"Ethan"];
    [friendArray addObject:@"Green小"];
    [friendArray addObject:@"Green大"];
    [friendArray addObject:@"DavidSmall"];
    [friendArray addObject:@"DavidBig"];
    [friendArray addObject:@"James"];
    [friendArray addObject:@"Kobe Brand"];
    [friendArray addObject:@"Kobe Crand"];
    
    
    sortedArrForArrays = [self getChineseStringArr:friendArray];
    NSLog(@"%f",self.navigationController.navigationBar.frame.size.height);
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(
                                                               0,
                                                               0,
                                                               [[UIScreen mainScreen] bounds].size.width,
                                                               self.view.frame.size.height)
                                              style:UITableViewStylePlain];
    
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    indexView = [[MJNIndexView alloc]initWithFrame:_tableView.frame];
    indexView.dataSource = self;
    [self firstAttributesForMJNIndexView];
    [self.view addSubview:indexView];
}
#pragma mark - MjnIndexView
- (void)firstAttributesForMJNIndexView
{
    
    indexView.getSelectedItemsAfterPanGestureIsFinished = YES;
    indexView.font = [UIFont fontWithName:@"HelveticaNeue" size:17.0];
    indexView.selectedItemFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:40.0];
    indexView.backgroundColor = [UIColor clearColor];
    indexView.curtainColor = nil;
    indexView.curtainFade = 0.0;
    indexView.curtainStays = NO;
    indexView.curtainMoves = YES;
    indexView.curtainMargins = NO;
    indexView.ergonomicHeight = NO;
    indexView.upperMargin = 54.0;
    indexView.lowerMargin = 0.0;
    indexView.rightMargin = 15.0;
    indexView.itemsAligment = NSTextAlignmentCenter;
    indexView.maxItemDeflection = 100.0;
    indexView.rangeOfDeflection = 5;
    indexView.fontColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
    indexView.selectedItemFontColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    indexView.darkening = NO;
    indexView.fading = NO;
    
}
- (NSArray *)sectionIndexTitlesForMJNIndexView:(MJNIndexView *)indexView
{
    listArray = [NSMutableArray new];
    for(int section='A';section<='Z';section++)
    {
        [listArray addObject:[NSString stringWithFormat:@"%c",section]];
    }
    [listArray addObject:@"#"];
    return listArray;
}
- (void)sectionForSectionMJNIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    int section = 0;
    for (int i = 0; i < sectionHeadsKeys.count; i ++) {
        if ([sectionHeadsKeys[i] isEqualToString:title]) {
            section = i;
            break;
        }
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition: UITableViewScrollPositionTop animated:YES];
    
}
#pragma mark - paixu
- (NSMutableArray *)getChineseStringArr:(NSMutableArray *)arrToSort {
    NSMutableArray *chineseStringsArray = [NSMutableArray array];
    for(int i = 0; i < [arrToSort count]; i++) {
        ChineseString *chineseString=[[ChineseString alloc]init];
        chineseString.string=[NSString stringWithString:[arrToSort objectAtIndex:i]];
        
        if(chineseString.string==nil){
            chineseString.string=@"";
        }
        
        if(![chineseString.string isEqualToString:@""]){
            //join the pinYin
            NSString *pinYinResult = [NSString string];
            for(int j = 0;j < chineseString.string.length; j++) {
                NSString *singlePinyinLetter = [[NSString stringWithFormat:@"%c",
                                                 pinyinFirstLetter([chineseString.string characterAtIndex:j])]uppercaseString];
                
                pinYinResult = [pinYinResult stringByAppendingString:singlePinyinLetter];
            }
            chineseString.pinYin = pinYinResult;
        } else {
            chineseString.pinYin = @"";
        }
        [chineseStringsArray addObject:chineseString];
    }
    
    //sort the ChineseStringArr by pinYin
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES]];
    [chineseStringsArray sortUsingDescriptors:sortDescriptors];
    
    
    NSMutableArray *arrayForArrays = [NSMutableArray array];
    BOOL checkValueAtIndex= NO;  //flag to check
    NSMutableArray *TempArrForGrouping = nil;
    
    for(int index = 0; index < [chineseStringsArray count]; index++)
    {
        ChineseString *chineseStr = (ChineseString *)[chineseStringsArray objectAtIndex:index];
        NSMutableString *strchar= [NSMutableString stringWithString:chineseStr.pinYin];
        NSString *sr= [strchar substringToIndex:1];
        //sr containing here the first character of each string
        if(![sectionHeadsKeys containsObject:[sr uppercaseString]])//here I'm checking whether the character already in the selection header keys or not
        {
            [sectionHeadsKeys addObject:[sr uppercaseString]];
            TempArrForGrouping = [[NSMutableArray alloc] initWithObjects:nil];
            checkValueAtIndex = NO;
        }
        if([sectionHeadsKeys containsObject:[sr uppercaseString]])
        {
            [TempArrForGrouping addObject:[chineseStringsArray objectAtIndex:index]];
            if(checkValueAtIndex == NO)
            {
                [arrayForArrays addObject:TempArrForGrouping];
                checkValueAtIndex = YES;
            }
        }
    }
    return arrayForArrays;
}
#pragma mark - tableView delegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sortedArrForArrays count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else
    {
        return  [[sortedArrForArrays objectAtIndex:section] count];
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if ([sortedArrForArrays count] > indexPath.section - 1) {
        NSArray *arr = [sortedArrForArrays objectAtIndex:indexPath.section - 1];
        if ([arr count] > indexPath.row) {
            ChineseString *str = (ChineseString *) [arr objectAtIndex:indexPath.row];
            cell.textLabel.text = str.string;
        } else {
            NSLog(@"arr out of range");
        }
    } else {
        NSLog(@"sortedArrForArrays out of range");
    }
    return cell;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [sectionHeadsKeys objectAtIndex:section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return NO;
    }
    else
    {
        return YES;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
