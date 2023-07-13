//
//  PicBodyView.m
//  demo
//
//  Created by LinDaobin on 2023/7/12.
//

#import "PicBodyView.h"

@implementation PicBodyView

- (void) setImageCount:(int)count
{
    //self.backgroundColor = [UIColor brownColor];
    for(int i = 0; i < count; i ++)
    {
        UIImageView *imageView = [UIImageView new];
        imageView.backgroundColor = [UIColor brownColor];
        [self.imageViews addObject:imageView];
        [self addSubview:imageView];
    }
    
    //图片视窗数量为1,2或是3以及以上时的布局不一致，分别处理
    int padding = 5; // 图片视窗之间的边距
    if(count == 1)
    {
        UIImageView *imageView = self.imageViews[0];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.edges.equalTo(self);
        }];
    }
    else if(count == 2)
    {
        UIImageView *imageView1 = self.imageViews[0];
        UIImageView *imageView2 = self.imageViews[1];

        [imageView1 mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left);
            make.width.equalTo(self.mas_width).offset(-padding).dividedBy(2);
            make.height.equalTo(imageView1.mas_width);
        }];
        
        [imageView2 mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.mas_top);
            make.left.equalTo(imageView1.mas_right).offset(padding);
            make.width.equalTo(self.mas_width).offset(-padding).dividedBy(2);
            make.height.equalTo(imageView1.mas_width);
        }];
    }
    else
    {
        UIImageView *last = nil;
        for(int i  = 0; i < count; i ++)
        {
            UIImageView *now = self.imageViews[i];
            
            if(last == nil)
            {
                [now mas_makeConstraints:^(MASConstraintMaker *make){
                    make.top.equalTo(self.mas_top);
                    make.left.equalTo(self.mas_left);
                }];
            }
            else if(i % 3 == 0) //说明要布局的控件到了新的一行
            {
                [now mas_makeConstraints:^(MASConstraintMaker *make){
                    make.top.equalTo(last.mas_bottom).offset(padding); // 新起一行
                    make.left.equalTo(self.mas_left); // 第一列
                }];
            }
            else // 继续在之前行的后面布局
            {
                [now mas_makeConstraints:^(MASConstraintMaker *make){
                    make.top.equalTo(last.mas_top);
                    make.left.equalTo(last.mas_right).offset(padding);
                }];
            }
            
            [now mas_makeConstraints:^(MASConstraintMaker *make){
                make.width.equalTo(self.mas_width).offset(- 2 * padding).dividedBy(3);
                //make.width.equalTo(self.mas_width).offset(- 1 * padding).dividedBy(3);
                make.height.equalTo(now.mas_width);
            }];
            
            last = now;
        }
    }
    
    [self mas_makeConstraints:^(MASConstraintMaker *make){
            UIImageView *last = [self.imageViews lastObject];
            make.bottom.equalTo(last.mas_bottom);
    }]; // 让self能够随子视图自动拉伸
}

- (NSMutableArray *)imageViews
{
    if(!_imageViews) _imageViews = [NSMutableArray new];
    return _imageViews;
}

@end
