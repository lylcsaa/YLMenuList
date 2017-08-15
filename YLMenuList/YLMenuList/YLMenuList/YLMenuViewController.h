//
//  YLMenuViewController.h
//  YLMenuList
//
//  Created by wlx on 2017/8/14.
//  Copyright © 2017年 Tim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLMenuItem.h"
typedef void(^YLSelectResultBlock) (YLMenuItem *item);
@interface YLMenuViewController : UIViewController
+(void)yl_showMenuInViewController:(UIViewController*)showVC
                         withItems:(NSArray<YLMenuItem*>*)items
                   animationButton:(UIButton*)animationButton
        completionWithSelectResult:(YLSelectResultBlock)completionBlock;
@end
