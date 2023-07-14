//
//  ANew.m
//  demo
//
//  Created by LinDaobin on 2023/7/12.
//

#import "ANewView.h"
#import "Masonry.h"

@implementation ANewView


- (instancetype)init
{
    self = [super init];
    if(self)
    {
        
        
        self.topView = [TopView new];
        self.bodyView = [BodyView new];
        self.bottomView = [BottomView new];
        [self addSubview:self.topView];
        [self addSubview:self.bodyView];
        [self addSubview:self.bottomView];
        
        self.topView.mas_key = @"topView";
        self.bodyView.mas_key = @"bodyView";
        self.bottomView.mas_key = @"bottomView";
        
        UIEdgeInsets padding = UIEdgeInsetsMake(0, 10, 0, -10);
        [self.topView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self);
            make.left.equalTo(self.mas_left).offset(padding.left);
            make.right.equalTo(self.mas_right).offset(padding.right);
            make.height.mas_equalTo(50);
        }];
        [self.bodyView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.topView.mas_bottom).offset(5);
            make.left.equalTo(self.mas_left).offset(padding.left);
            make.right.equalTo(self.mas_right).offset(padding.right);
        }];
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.bodyView.mas_bottom).offset(10);
            make.bottom.equalTo(self.mas_bottom);
            make.left.equalTo(self.mas_left).offset(padding.left);
            make.right.equalTo(self.mas_right).offset(padding.right);
            make.height.mas_equalTo(10);
            
        }];
        
        //self.backgroundColor = [UIColor brownColor];
        //self.topView.backgroundColor = [UIColor redColor];
        //self.bodyView.backgroundColor = [UIColor blueColor];
        //self.bottomView.backgroundColor = [UIColor greenColor];
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
