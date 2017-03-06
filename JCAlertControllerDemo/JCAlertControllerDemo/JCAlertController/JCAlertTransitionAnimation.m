//
//  JCAlertTransitionAnimation.m
//  JCAlertControllerDemo
//
//  Created by wenjie hua on 2016/12/28.
//  Copyright © 2016年 gold. All rights reserved.
//

#import "JCAlertTransitionAnimation.h"
#import "JCAlertController.h"
@interface JCAlertTransitionAnimation()
@property (nonatomic, strong) CAKeyframeAnimation *animation;

@end;
@implementation JCAlertTransitionAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if (toVC.isBeingPresented) {
        return 0.3;
    }else if (fromVC.isBeingDismissed){
        return 0.1;
    }
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    JCAlertController *toVC = (JCAlertController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    if (!toVC || !fromVC) {
        return;
    }
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    if (toVC.isBeingPresented) {
        // 2
        [containerView addSubview:toVC.view];
        toVC.view.frame = CGRectMake(0.0, 0.0, containerView.frame.size.width, containerView.frame.size.height);
        toVC.vBackground.alpha = 0.0;
        
        toVC.vAlert.center = containerView.center;
        [toVC.vAlert.layer addAnimation:self.animation forKey:nil];
        
        [UIView animateWithDuration:duration animations:^{
            toVC.vBackground.alpha = 0.3;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }else if (fromVC.isBeingDismissed){
        [UIView animateWithDuration:duration animations:^{
            fromVC.view.alpha = 0.0;
        } completion:^(BOOL finished) {
            fromVC.view.alpha = 1.0;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }

}

#pragma mark - setter and getter Methods
- (void)setType:(JCAlertTransitionAnimationType)type{
    _type = type;
    switch (type) {
        case JCAlertTransitionAnimationTypePop:
            self.animation = [self popAnimation];
            break;
            
        default:
            break;
    }
}

- (CAKeyframeAnimation *)animation{
    if (_animation == nil) {
        _animation = [self popAnimation];
    }
    return _animation;
}

- (CAKeyframeAnimation *)popAnimation{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform";
    animation.duration = 0.4;
    animation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                         [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    animation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    return animation;
}
@end
