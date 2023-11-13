//
//  Macro.h
//  demo
//
//  Created by LinDaobin on 2023/11/5.
//

#ifndef Macro_h
#define Macro_h

#define WEAKSELF(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#endif /* Macro_h */
