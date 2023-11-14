//
//  PersonInfoViewController.m
//  demo
//
//  Created by LinDaobin on 2023/11/14.
//

#import <Foundation/Foundation.h>
#import "PersonInfoViewController.h"
#import <Masonry.h>

@interface PersonInfoViewController()

@property(strong, nonatomic) UIImageView *backgroundImageView;
@property(strong, nonatomic) UIImageView *iconImageView;

@end

@implementation PersonInfoViewController

-(void)viewDidLoad
{
    [self initUI];
}

- (void)initUI
{
    self.view.frame = UIScreen.mainScreen.bounds;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.backgroundImageView.image = [UIImage imageNamed:@"background"];
    
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.iconImageView];
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.mas_equalTo(self.view).dividedBy(3);
        make.width.equalTo(self.view);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.width.mas_equalTo(80);
        make.top.equalTo(self.backgroundImageView.mas_bottom).offset(-40); //
        make.left.equalTo(self.view).offset(20);
    }];
}


#pragma mark lazyInit

- (UIImageView *)backgroundImageView
{
    if(!_backgroundImageView)
    {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    }
    
    return _backgroundImageView;
}

- (UIImageView *)iconImageView
{
    if(!_iconImageView)
    {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImageView.image = [UIImage imageNamed:self.iconName];
        _iconImageView.backgroundColor = [UIColor yellowColor];
    }
    
    return _iconImageView;
}

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}



@end
