//
//  YLMenuAnimator.h
//  YLMenuList
//
//  Created by wlx on 2017/8/15.
//  Copyright © 2017年 Tim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface YLMenuAnimator : NSObject<UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate>
@property (nonatomic,assign)CGRect startFrame;
@property (nonatomic,assign)CGRect endFrame;
@property (nonatomic,strong)UIImage * image;
@property (nonatomic,strong)UIButton *transitionButton;
@property (nonatomic,strong)UIView*maskView;
@property (nonatomic,strong)UITableView *tableView;
@end
