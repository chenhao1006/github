//
//  ViewController.m
//  EmojiKeyBoard
//
//  Created by chenhao on 14-3-20.
//  Copyright (c) 2014年 chenhao. All rights reserved.
//

#import "ViewController.h"
#import "EmojiKeyBoard.h"
@interface ViewController ()<EmojiKeyBoardDelegate, UITextFieldDelegate, UITextViewDelegate>
{
    UITextField *textField;
    UITextView *textView;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    EmojiKeyBoard *emoji = [[EmojiKeyBoard alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, 176)];
    //emoji.bounds = CGRectMake(0, 0, 320, 176);
    emoji.delegate = self;
    textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 300, 320, 30)];
    textField.delegate = self;
    textField.inputView = emoji;
    textField.layer.cornerRadius = 5;
    textField.layer.borderWidth = 1;
    textField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [self.view addSubview:textField];
    
    [self.view addSubview:emoji];
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 20, 320, 200)];
    textView.backgroundColor = [UIColor redColor];
    textView.delegate = self;
    [self.view addSubview:textView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}
- (void)chooseEmoji:(NSString *)emoji
{
    textField.text = [NSString stringWithFormat:@"%@%@",textField.text,emoji];
}
- (void)delEmoji:(UIButton *)button
{
    if (textField.text.length > 0) {
        if (textField.text.length >= 2) {
            NSString *str = [textField.text substringFromIndex:[textField.text length]-2];
            BOOL isEmoji = [self stringContainsEmoji:str];
            if (isEmoji) {
                textField.text = [textField.text substringToIndex:[textField.text length] - 2];
            }
            else
            {
                textField.text = [textField.text substringToIndex:[textField.text length] - 1];
            }
        }
        else
        {
            textField.text = [textField.text substringToIndex:[textField.text length] - 1];
        }
    }
    
}
- (void)sendMeg:(UIButton *)button
{
    textView.text = [textView.text stringByAppendingString:textField.text];
    textField.text = @"";
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return NO;
}
//判断textView中最后两个字符是否为emoji表情字符
-(BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}

#pragma mark - touch delegate
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [textField resignFirstResponder];
    
    [UIView animateWithDuration:.2 animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}
@end
