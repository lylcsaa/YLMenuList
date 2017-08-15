//
//  YLMenuAnimator.m
//  YLMenuList
//
//  Created by wlx on 2017/8/15.
//  Copyright © 2017年 Tim. All rights reserved.
//

#import "YLMenuAnimator.h"

@implementation YLMenuAnimator
{
    BOOL _isPresent;
}
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    _isPresent = YES;
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    _isPresent = NO;
    return self;
}
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.2;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    _isPresent ? [self animateForPresent:transitionContext] : [self animateForDismiss:transitionContext];
}
-(void)animateForPresent:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    [transitionContext.containerView addSubview:toView];

    [transitionContext.containerView insertSubview:self.maskView atIndex:0];
    [transitionContext.containerView addSubview:self.transitionButton];
    [transitionContext.containerView insertSubview:self.tableView aboveSubview:self.maskView];
    self.transitionButton.transform = CGAffineTransformMakeRotation(0);
    self.maskView.alpha = 0;
    CGFloat tableHeight = self.tableView.frame.size.height;
    CGFloat tableY = self.tableView.frame.origin.y;
    self.tableView.frame = CGRectMake(CGRectGetMinX(self.tableView.frame), self.transitionButton.center.y, CGRectGetWidth(self.tableView.frame), 0);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        self.transitionButton.transform = CGAffineTransformMakeRotation(M_PI_2*0.5);
        self.maskView.alpha = 0.2;
        self.tableView.frame = CGRectMake(CGRectGetMinX(self.tableView.frame), tableY, CGRectGetWidth(self.tableView.frame), tableHeight);
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:YES];
    }];
}
-(void)animateForDismiss:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
     [transitionContext.containerView addSubview:self.transitionButton];
    fromView.backgroundColor = [UIColor clearColor];
    for (UIView *subview in fromView.subviews) {
        if ([subview isKindOfClass:[UICollectionView class]]) {
            subview.hidden = YES;
            break;
        }
    }
     [transitionContext.containerView insertSubview:self.maskView atIndex:0];
    [fromView addSubview:self.transitionButton];
     [transitionContext.containerView insertSubview:self.tableView aboveSubview:self.maskView];
     self.transitionButton.transform = CGAffineTransformMakeRotation(M_PI_2*0.5);
    self.maskView.alpha = 0.2;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        self.transitionButton.transform = CGAffineTransformMakeRotation(0);
        self.maskView.alpha = 0;
        self.tableView.frame = CGRectMake(CGRectGetMinX(self.tableView.frame), self.transitionButton.center.y, CGRectGetWidth(self.tableView.frame), 0);
    } completion:^(BOOL finished) {
        [fromView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}
@end
