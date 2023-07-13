//
//  BottomView.m
//  demo
//
//  Created by LinDaobin on 2023/7/12.
//

#import "BottomView.h"
#import "Masonry.h"

@interface BottomView()
@property BOOL like;
@end


@implementation BottomView

-(instancetype) init
{
    self.like = NO;
    self = [super init];
    if(self)
    {
        self.likeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        //[self.likeBtn setTitle:@"点赞" forState:UIControlStateNormal];
        [self.likeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.likeBtn setImage:[UIImage imageNamed:@"like_no"] forState:UIControlStateNormal];
        [self.likeBtn addTarget:self action:@selector(clickLikeBtn) forControlEvents:UIControlEventTouchUpInside];
        self.commentBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        //[self.commentBtn setTitle:@"评论" forState:UIControlStateNormal];
        [self.commentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.commentBtn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
        
        self.transmitBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        //[self.transmitBtn setTitle:@"转发" forState:UIControlStateNormal];
        [self.transmitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.transmitBtn setImage:[UIImage imageNamed:@"transmit"] forState:UIControlStateNormal];
        
        [self addSubview:self.likeBtn];
        [self addSubview:self.commentBtn];
        [self addSubview:self.transmitBtn];
        
        int padding = 20;
        [self.transmitBtn mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.mas_top).offset(5);
            make.right.equalTo(self.mas_right);
        }];
        [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.mas_top).offset(7);
            make.right.equalTo(self.transmitBtn.mas_left).offset(- padding);
        }];
        [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.mas_top).offset(0);
            make.right.equalTo(self.commentBtn.mas_left).offset(- padding + 7);
        }];
    }
    
    return self;
}

- (void)clickLikeBtn
{
    _like = !_like;
    NSString *imgName = @"like_no";
    if(_like == YES) imgName = @"like_yes";
    
    
    [self.likeBtn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
}


@end
