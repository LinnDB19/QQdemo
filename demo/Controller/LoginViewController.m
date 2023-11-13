//
//  LoginViewController.m
//  demo
//
//  Created by LinDaobin on 2023/11/6.
//

#import <Foundation/Foundation.h>
#import "LoginViewController.h"
#import <Masonry.h>
#import "JHUserDefaultStatus.h"
#import "JHControllerManager.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
@interface LoginViewController()
@property(strong, nonatomic) UIImageView *logoImgView;
@property(strong, nonatomic) UITextField *idTextFiled;
@property(strong, nonatomic) UITextField *pswTextFiled;
@property(strong, nonatomic) UIButton *commitBtn;
@end

@implementation LoginViewController

-(void)viewDidLoad
{
    self.view.frame = UIScreen.mainScreen.bounds;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.idTextFiled];
    [self.view addSubview:self.pswTextFiled];
    [self.view addSubview:self.commitBtn];
    [self.view addSubview:self.logoImgView];
    
    
    
    [self.idTextFiled mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.view.bounds.size.height * 0.35);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(self.view.bounds.size.width / 2);
    }];
    [self.pswTextFiled mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(0);
        make.top.equalTo(self.idTextFiled.mas_bottom).offset(20);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(self.view.bounds.size.width / 2);
    }];
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.view.bounds.size.height / 5 * 3);
        make.height.mas_equalTo(70);
        make.width.mas_equalTo(70);
    }];
    
    [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(0);
        make.centerY.equalTo(self.idTextFiled.mas_top).dividedBy(2);
        //make.top.equalTo(self.view).offset(30);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
}

#pragma mark 控件事件
-(void)commitBtnClicked
{
    
    [[JHUserDefaultStatus sharedManager] saveLoginInfo];
    [[JHControllerManager ShareManager] postNotification:ControllerManagerChangeToHomeNotification userInfo:nil];
}
-(void)TextChangeInTextField:(UITextField *)textfield
{
    NSLog(@"textfield内容改变");
    if([self.idTextFiled.text isEqual:@""] || [self.pswTextFiled.text isEqual:@""])
    {
        self.commitBtn.enabled = NO;
        self.commitBtn.alpha = 0.3;
    }
    else if( ![self.idTextFiled.text isEqual:@""] && ![self.pswTextFiled.text isEqual:@""])
    {
        self.commitBtn.enabled = YES;
        self.commitBtn.alpha = 1;
    }
}
    
#pragma mark lazyInit

-(UIImageView *)logoImgView
{
    if(!_logoImgView)
    {
        _logoImgView = [UIImageView new];
        _logoImgView.image = [UIImage imageNamed:@"QQLogo"];
        
    }
    return _logoImgView;
}

-(UITextField *)idTextFiled
{
    if(!_idTextFiled)
    {
        _idTextFiled = [UITextField new];
        _idTextFiled.layer.cornerRadius = 20;
        _idTextFiled.placeholder = @"输入账号";
        _idTextFiled.textAlignment = NSTextAlignmentCenter;
        _idTextFiled.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:233/255.0 alpha:1];
        [_idTextFiled addTarget:self action:@selector(TextChangeInTextField:) forControlEvents:UIControlEventEditingChanged];
    }
    
    return _idTextFiled;
}

-(UITextField *)pswTextFiled
{
    if(!_pswTextFiled)
    {
        _pswTextFiled = [UITextField new];
        _pswTextFiled.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:233/255.0 alpha:1];
        _pswTextFiled.layer.cornerRadius = 20;
        _pswTextFiled.textAlignment = NSTextAlignmentCenter;
        _pswTextFiled.placeholder = @"输入密码";
        _pswTextFiled.secureTextEntry = YES;
        [_pswTextFiled addTarget:self action:@selector(TextChangeInTextField:) forControlEvents:UIControlEventEditingChanged];
    }
    
    return _pswTextFiled;
}
-(UIButton *)commitBtn
{
    if(!_commitBtn)
    {
        _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _commitBtn.frame = CGRectMake(0, 0, 50, 50);
        [_commitBtn setBackgroundColor:[UIColor blueColor]];
        _commitBtn.layer.cornerRadius = 20;
        _commitBtn.enabled = NO;
        _commitBtn.alpha = 0.3;
        [_commitBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commitBtn addTarget:self action:@selector(commitBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _commitBtn;
}


@end
