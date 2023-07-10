//
//  MessageCell.m
//  demo
//
//  Created by LinDaobin on 2023/7/7.
//

#import "MessageCell.h"

@implementation MessageCell

- (UILabel *)lastDateLabel
{
    if(!_lastDateLabel)
    {
        int width = 50;
        int SCREEN_H = UIScreen.mainScreen.bounds.size.height;
        int SCREEN_W = UIScreen.mainScreen.bounds.size.width;
        int height = 30;
        //NSLog(@"%d %d", SCREEN_W, SCREEN_H);
        _lastDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_W - width - 10, 0, width, height)];
    }
    return _lastDateLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self addSubview:self.lastDateLabel];
    }
    
    return self;
}

static const int BORDER = 3;
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= BORDER;
    frame.size.height -= BORDER * 2;
    
    [super setFrame:frame];
}

@end
