//
//  BodyView.m
//  demo
//
//  Created by LinDaobin on 2023/7/12.
//

#import "BodyView.h"
#import "masonry.h"

@implementation BodyView

- (instancetype) init
{
    self = [super init];
    if(self)
    {
        //self.backgroundColor = [UIColor blueColor];
        _textBodyView = [TextBodyView new];
        [self addSubview:_textBodyView];
        [_textBodyView mas_makeConstraints:^(MASConstraintMaker *make){
            make.edges.equalTo(self);
        }];
    }
    
    return self;
}

- (void) setPicBodyImageCount:(int)count
{
    if(!count) return;
    
    [_textBodyView mas_remakeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    
    _picBodyView = [PicBodyView new];
    [self addSubview:_picBodyView];

    
    [_picBodyView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.textBodyView.mas_bottom).offset(5);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.equalTo(self.picBodyView.mas_bottom);
    }]; // 设置后self大小能根据子空间大小自动拉伸
    
    [_picBodyView setImageCount:count]; // 提供参数给picBodyView设置布局
}

@end
