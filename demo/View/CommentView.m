//
//  CommentView.m
//  demo
//
//  Created by LinDaobin on 2023/10/25.
//

#import "CommentView.h"

@implementation CommentView

-(instancetype)init
{
    self = [super init];
    if(self)
    {
        int height = 50, scrWidth = UIScreen.mainScreen.bounds.size.width;
        int btnWid = 50, scrHeight = UIScreen.mainScreen.bounds.size.height;
        [self setFrame:CGRectMake(0, scrHeight  - height, scrWidth, height)];
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, scrWidth - btnWid, height)];
        [self addSubview:_textView];
        
        _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commitBtn setFrame:CGRectMake(scrWidth - btnWid, 0, btnWid, height)];
        [_commitBtn setBackgroundColor:[UIColor whiteColor]];
        [_commitBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_commitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview: _commitBtn];
    }
    
    return self;
}

@end
