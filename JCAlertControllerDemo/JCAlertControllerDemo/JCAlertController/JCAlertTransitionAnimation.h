//
//  JCAlertTransitionAnimation.h
//  JCAlertControllerDemo
//
//  Created by wenjie hua on 2016/12/28.
//  Copyright © 2016年 gold. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, JCAlertTransitionAnimationType) {
    JCAlertTransitionAnimationTypePop,
    JCAlertTransitionAnimationTypePush
};

@interface JCAlertTransitionAnimation : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) JCAlertTransitionAnimationType type;
@end
