//
//  XMUserViewController.m
//  JSMusic
//
//  Created by 朱洁珊 on 2019/12/3.
//  Copyright © 2019 朱洁珊. All rights reserved.
//

#import "XMUserViewController.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface XMUserViewController ()<UITextViewDelegate,UIAlertViewDelegate>
@property(strong,nonatomic)UITextView *textView;
@property(strong,nonatomic)UILabel *placeHolderLabel;
@property(strong,nonatomic)UILabel *numLabel;
@property(strong,nonatomic)UIButton *saveBtn;

@end

@implementation XMUserViewController
#pragma mark -- LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我要反馈";
    [self setUI];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


#pragma mark -- UI
-(void)setUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _textView =[[UITextView alloc]initWithFrame:CGRectMake(10, 50, kScreenWidth-20, 100)];
    _textView.layer.masksToBounds = YES;
    _textView.layer.cornerRadius = 5;
    _textView.layer.borderColor = [UIColor redColor].CGColor;
    _textView.layer.borderWidth = 2;
    _textView.delegate = self;
    [self.view addSubview:_textView];
    
    _placeHolderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 100, 30)];
    _placeHolderLabel.text = @"请输入意见反馈";
    _placeHolderLabel.font = [UIFont systemFontOfSize:12];
    _placeHolderLabel.textColor = [UIColor lightGrayColor];
    [_textView addSubview:_placeHolderLabel];
    
    _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(_textView.tj_width-65, _textView.tj_height-30, 60, 30)];
    _numLabel.textAlignment = NSTextAlignmentRight;
    _numLabel.text = @"0/20";
    _numLabel.font = [UIFont systemFontOfSize:12];
    _numLabel.textColor = [UIColor lightGrayColor];
    [_textView addSubview:_numLabel];
    
    _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _saveBtn.frame = CGRectMake(10, _textView.tj_y+_textView.tj_height+20, kScreenWidth-20, 40);
    _saveBtn.layer.masksToBounds = YES;
    _saveBtn.layer.cornerRadius = 5;
    [_saveBtn setTitle:@"提交反馈" forState:UIControlStateNormal];
    [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_saveBtn setBackgroundColor:[UIColor colorThemeColor]];
    [_saveBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    _saveBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:_saveBtn];
    
}

-(void)saveAction{
    if (_textView.text.length == 0) {
        [XDProgressHUD showHUDWithText:@"请输入一些意见或建议吧" hideDelay:1.0];
        return;
    }else{
        //zf
        _textView.text = @"";
    }
    
    [[RequestManager manager] GET:[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/ca/album/track/true/1/20?"] parameters:nil success:^(id  _Nullable responseObj) {
        
    } failure:^(NSError * _Nonnull error) {

    }];
    [XDProgressHUD showHUDWithText:@"感谢您的宝贵意见！" hideDelay:1.0];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    [_textView becomeFirstResponder];
    //    NSLog(@"文本开始编辑");
    _placeHolderLabel.hidden = YES;
}

-(void)textViewDidChange:(UITextView *)textView{
    //    NSLog(@"文本在变化");
    _numLabel.text = [NSString stringWithFormat:@"%d/50",50-(int)textView.text.length];
    
    if (textView.text.length >= 50) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的字数超过50了" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        _textView.text = [textView.text substringToIndex:50];
        _numLabel.text = [NSString stringWithFormat:@"0/50"];
    }else if (textView.text.length ==0){
        _placeHolderLabel.hidden = NO;
    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex ==1) {
        NSLog(@"确定");
    }else{
        NSLog(@"取消");
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    //     NSLog(@"文本结束编辑");
    
}

#pragma mark -- Setter And Getter

-(void)dealloc{
    
}

@end
