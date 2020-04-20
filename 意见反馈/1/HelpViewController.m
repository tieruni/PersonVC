//
//  PC_PassPictureViewController.m
//  OverturnOnlineCollege_Students
//
//  Created by Kevin on 16/4/22.
//  Copyright © 2016年 Dongxk. All rights reserved.
//

#import "HelpViewController.h"
#import "PlaceholderTextView.h"
#import "UIView+TFExtension.h"
#import "Utilities.h"

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]


@interface HelpViewController ()<UITextViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (nonatomic, strong) PlaceholderTextView * textView;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UILabel *iLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView *tfView;
@property (nonatomic, strong) NSMutableArray *bigImageArray;

@end

@implementation HelpViewController{

    NSString *contentStr;
    NSString *phoneStr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"帮助与反馈";
    self.view.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(clickRightBarButtonItem:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self initViews];
}

- (void)clickRightBarButtonItem:(id)sender{
    
    [self passPhotoAction:_bigImageArray];
    
}

- (void)initViews{

    UILabel *qLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 64, ScreenWidth - 30, 30)];
    qLabel.text = @"问题和意见";
    qLabel.textColor = [Utilities getColor:@"555555"];
    qLabel.font = [UIFont systemFontOfSize:16];
    qLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:qLabel];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(-0.5, qLabel.frame.origin.y + qLabel.frame.size.height + 5, ScreenWidth+1, 165)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderWidth = 0.1;
    view.layer.cornerRadius = 2;
    view.layer.masksToBounds = YES;
    [self.view addSubview:view];
    
    _textView = [[PlaceholderTextView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 140)];
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.delegate = self;
    _textView.font = [UIFont systemFontOfSize:15.f];
    _textView.textColor = [UIColor blackColor];
    _textView.textAlignment = NSTextAlignmentLeft;
    _textView.placeholderColor = RGBCOLOR(0x89, 0x89, 0x89);
    _textView.placeholder = @"请输入不小于10个字的描述~";
    [view addSubview:_textView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewEditChanged:) name:UITextViewTextDidChangeNotification object:_textView];
    
    _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, _textView.frame.origin.y + _textView.frame.size.height, ScreenWidth - 30, 20)];
    _numLabel.font = [UIFont systemFontOfSize:14.f];
    _numLabel.textColor = [UIColor lightGrayColor];
    _numLabel.text = @"0/150";
    _numLabel.backgroundColor = [UIColor whiteColor];
    _numLabel.textAlignment = NSTextAlignmentRight;
    [view addSubview:_numLabel];
    
//    _tfView = [[UIView alloc]initWithFrame:CGRectMake(0, view.frame.origin.y + view.frame.size.height -44, 150, 44)];
//    _tfView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:_tfView];
//    
//    _textField = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, _tfView.qjyywidth-15, 44)];
//    _textField.placeholder = @"联系方式";
//    _textField.font = [UIFont systemFontOfSize:15];
//    _textField.backgroundColor = [UIColor whiteColor];
//    _textField.textColor = [Utilities getColor:@"555555"];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldEditChanged:) name:UITextFieldTextDidChangeNotification object:_textField];
//    [_tfView addSubview:_textField];
    
}
- (void)textViewEditChanged:(NSNotification *)obj{
    
    UITextView *tv = (UITextView *)obj.object;
    if (tv.text.length > 150) {
        tv.text = [tv.text substringToIndex:150];
    }
    contentStr = tv.text;
    _numLabel.text = [NSString stringWithFormat:@"%ld/150", tv.text.length];
     [self rightItemEnable];
}

- (void)textFieldEditChanged:(NSNotification *)obj{

    UITextField *tf = (UITextField *)obj.object;
    if (tf.text.length > 11) {
        tf.text = [tf.text substringToIndex:11];
    }
    phoneStr = tf.text;
    
    [self rightItemEnable];
}

- (void)rightItemEnable{

    if (_bigImageArray.count > 0 || contentStr.length > 0 || phoneStr.length > 0) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }else{
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}

#pragma mark ---------- 批量上传照片
- (void)passPhotoAction:(NSArray *)dataArray{
    
//    [_textView resignFirstResponder];
    [self.view endEditing:YES];
    NSLog(@"------点击了提交");
    [XDProgressHUD showHUDWithText:@"提交成功, 多谢您的宝贵意见或建议!" hideDelay:1.0];

//    [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"提交成功, 多谢您的宝贵意见或建议!"];
    
    [self.navigationController popViewControllerAnimated:YES];
}



- (UIColor *)getColor:(NSString *)hexColor
{
    if (hexColor.length<=0) {
        return [UIColor clearColor];
    }
    
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
