//
//  SlideCell.m
//  demo
//
//  Created by LinDaobin on 2023/11/2.
//

#import <Foundation/Foundation.h>
#import "SlideCell.h"
#import "masonry.h"

@implementation SlideCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self).offset(20);
            make.top.mas_equalTo(10);
            make.height.width.equalTo(self.mas_height).multipliedBy(0.6);
        }];
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.imageView.mas_right).offset(10);
            make.height.equalTo(self);
        }];
    }
    
    return self;
}


- (void)prepareForReuse
{
    [super prepareForReuse];
    self.textLabel.textColor = [UIColor blackColor];
    self.detailTextLabel.textColor = [UIColor blackColor];
}

//static const int BORDER = 3;
//- (void)setFrame:(CGRect)frame
//{
//    [super setFrame:frame];
//    CGRect imgFrame = self.imageView.frame;
//    CGFloat newHeight = imgFrame.size.height - 10;
//    CGFloat newWidth = imgFrame.size.width - 10;
//    self.imageView.frame = CGRectMake(imgFrame.origin.x + 5, imgFrame.origin.y + 5, newWidth, newHeight);
//}

@end
