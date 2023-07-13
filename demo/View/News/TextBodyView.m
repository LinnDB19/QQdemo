//
//  TextBodyView.m
//  demo
//
//  Created by LinDaobin on 2023/7/12.
//

#import "TextBodyView.h"
#import "Masonry.h";

@implementation TextBodyView

-(instancetype) init
{
    self = [super init];
    if(self)
    {
        _contentLabel = [UILabel new];
        _contentLabel.font = [UIFont systemFontOfSize:17];
        _contentLabel.numberOfLines = 0;
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:_contentLabel];
        
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.size.equalTo(self);
        }];
    }
    
    return self;
}
@end
