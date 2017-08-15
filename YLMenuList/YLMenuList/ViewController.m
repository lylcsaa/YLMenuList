//
//  ViewController.m
//  YLMenuList
//
//  Created by wlx on 2017/8/14.
//  Copyright © 2017年 Tim. All rights reserved.
//

#import "ViewController.h"
#import "YLMenuViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * button  = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 120, self.view.bounds.size.height - 120, 80, 80)];
    button.backgroundColor = [UIColor redColor];
    button.layer.cornerRadius = 40;
    button.layer.masksToBounds = YES;
    [button setTitle:@"+" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:40];
    [button addTarget:self action:@selector(showMenuList:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
-(void)showMenuList:(UIButton*)sender
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        YLMenuItem *item = [[YLMenuItem alloc] init];
        item.itemTitle = [NSString stringWithFormat:@"测试item%d",i];
        [array addObject:item];
    }
    [YLMenuViewController yl_showMenuInViewController:self withItems:array animationButton:sender completionWithSelectResult:^(YLMenuItem *item) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor purpleColor];
        vc.navigationItem.title = item.itemTitle;
        [self.navigationController pushViewController:vc animated:YES];
    }];

}
@end
