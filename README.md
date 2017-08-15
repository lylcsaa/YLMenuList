# YLMenuList

#示例代码：
```Object-C
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
