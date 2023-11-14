//
//  TopView.m
//  demo
//
//  Created by LinDaobin on 2023/7/12.
//

#import "TopView.h"
#import "Masonry.h"

@implementation TopView

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [self addSubview:self.iconImageView];
        [self addSubview:self.nickNameLabel];
        [self addSubview:self.dateLabel];
        
        self.nickNameLabel.font = [UIFont systemFontOfSize:15];
        self.nickNameLabel.textColor = [UIColor blackColor];
        self.dateLabel.font = [UIFont systemFontOfSize:14];
        self.dateLabel.textColor = [UIColor grayColor];
        
        [self mas_makeConstraints:^(MASConstraintMaker * make){
            make.height.mas_equalTo(50);
        }];
        
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.size.mas_equalTo(CGSizeMake(45, 45));
            make.top.equalTo(self.mas_top).offset(5);
            make.left.equalTo(self.mas_left).offset(5);
        }];
        
        [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.iconImageView.mas_right).offset(10);
            make.top.equalTo(self.iconImageView.mas_top);
        }];
        
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.nickNameLabel.mas_left);
            make.top.equalTo(self.nickNameLabel.mas_bottom).offset(5);
        }];
    }
    
    return self;
}

- (UIImageView *)iconImageView
{
    if(!_iconImageView)
    {
        _iconImageView = [UIImageView new];
        _iconImageView.userInteractionEnabled = YES;
    }
    return _iconImageView;
}

- (UILabel *)nickNameLabel
{
    if(!_nickNameLabel)_nickNameLabel = [UILabel new];
    return _nickNameLabel;
}

- (UILabel *)dateLabel
{
    if(!_dateLabel) _dateLabel = [UILabel new];
    return _dateLabel;
}

@end
