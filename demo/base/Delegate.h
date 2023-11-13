//
//  Delegate.h
//  demo
//
//  Created by LinDaobin on 2023/10/25.
//

#ifndef Delegate_h
#define Delegate_h

@protocol CommentDelegate<NSObject>
@required
-(void)didClickCommentBtnWithTag:(int)tag;
@end

@protocol TransDelegate<NSObject>
@required
-(void)didClickTransBtnWithTag:(int)tag;
@end

#endif /* Delegate_h */
