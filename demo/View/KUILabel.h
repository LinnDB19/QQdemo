

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ChatSendOrReveive) {
    ChatSend,
    ChatReceive
};

@interface KUILabel : UIView
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, assign) NSInteger numberOfLines;

- (instancetype)initWithLeftOrRightChat:(ChatSendOrReveive)chats headerImg:(NSString *)imgName;
- (instancetype)initWithWXLeftOrRightChat:(ChatSendOrReveive)chats headerImg:(NSString *)imgName;
- (instancetype)initWithWXCommonLeftOrRightChat:(ChatSendOrReveive)chats headerImg:(NSString *)imgName;

@end
