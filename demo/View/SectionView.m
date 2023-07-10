//
//  SectionView.m
//  demo
//
//  Created by Abakus on 2023/6/30.
//

#import "SectionView.h"

@implementation SectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        double HEIGHT = self.frame.size.height, WIDTH = self.frame.size.width;
        CGSize STATE_IMAGE_SIZE = CGSizeMake(25, 25);
        //self.backgroundColor = [UIColor brownColor];
        _stateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, (HEIGHT - STATE_IMAGE_SIZE.height) / 2, STATE_IMAGE_SIZE.width, STATE_IMAGE_SIZE.height)];
        //_stateImageView.backgroundColor = [UIColor greenColor];
        _stateImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        _sectionName = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH / 5, 0, WIDTH / 5 * 3, HEIGHT)];
        //_sectionName.backgroundColor = [UIColor redColor];
        _sectionName.textAlignment = NSTextAlignmentCenter;
        
        _onlineTotal = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH / 5 * 4 - 15, 0, WIDTH / 5, HEIGHT)];
        _onlineTotal.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.stateImageView];
        [self addSubview:self.sectionName];
        [self addSubview:self.onlineTotal];
    }
    
    return self;
}

@end
