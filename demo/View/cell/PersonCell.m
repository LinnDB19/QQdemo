//
//  personCell.m
//  demo
//
//  Created by Abakus on 2023/6/30.
//

#import "PersonCell.h"

@implementation PersonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if(self)
    {
    }
    
    return self;
}


- (void)prepareForReuse
{
    [super prepareForReuse];
    self.textLabel.textColor = [UIColor blackColor];
    self.detailTextLabel.textColor = [UIColor blackColor];
}

static const int BORDER = 3;
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= BORDER;
    frame.size.height -= BORDER * 2;
    
    [super setFrame:frame];
}

@end
