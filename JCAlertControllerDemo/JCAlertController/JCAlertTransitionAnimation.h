//
//  JCAlertTransitionAnimation.h
//  Easybao
//
//  Created by wenjie hua on 2016/12/28.
//  Copyright © 2016年 gold. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, JCAlertTransitionAnimationType) {
    JCAlertTransitionAnimationTypePop,
    JCAlertTransitionAnimationTypePush
};

@interface JCAlertTransitionAnimation : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) JCAlertTransitionAnimationType type;
@end
