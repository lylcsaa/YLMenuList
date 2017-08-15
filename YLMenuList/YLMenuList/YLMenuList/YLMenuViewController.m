//
//  YLMenuViewController.m
//  YLMenuList
//
//  Created by wlx on 2017/8/14.
//  Copyright © 2017年 Tim. All rights reserved.
//

#import "YLMenuViewController.h"
#import "YLMenuAnimator.h"
@interface YLMenuViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic,strong)UITableView *tableView;
/**
 **:<#注释#>
 **/
@property (nonatomic,copy)YLSelectResultBlock selectResultBlock;
/**
 **:<#注释#>
 **/
@property (nonatomic,strong)UIView *maskView;
/**
 **:<#注释#>
 **/
@property (nonatomic,strong)UIButton *menuButton;
@property (nonatomic,strong)YLMenuAnimator *animator;
/**
 **:<#注释#>
 **/
@property (nonatomic,strong)NSArray<YLMenuItem*> *items;
@end
#define KMENUCELLH 80
@implementation YLMenuViewController
+(void)yl_showMenuInViewController:(UIViewController*)showVC
                         withItems:(NSArray<YLMenuItem*>*)items
                   animationButton:(UIButton*)animationButton
        completionWithSelectResult:(YLSelectResultBlock)completionBlock
{
    YLMenuViewController *menuViewController = [[YLMenuViewController alloc] init];
    menuViewController.selectResultBlock = completionBlock;
    menuViewController.modalPresentationStyle = UIModalPresentationCustom;
    menuViewController.menuButton.frame = animationButton.frame;
    menuViewController.transitioningDelegate = menuViewController.animator;
    menuViewController.items = items;
    [showVC presentViewController:menuViewController animated:YES completion:^{
        [menuViewController.view addSubview:menuViewController.tableView];
    }];
}
-(YLMenuAnimator *)animator
{
    if (!_animator) {
        _animator = [[YLMenuAnimator alloc] init];
        _animator.transitionButton = self.menuButton;
        _animator.maskView = self.maskView;
        _animator.tableView = self.tableView;
    }
    return _animator;
}
-(UIButton *)menuButton
{
    if (!_menuButton) {
        UIButton * button  = [[UIButton alloc] init];
        button.backgroundColor = [UIColor redColor];
        button.layer.cornerRadius = 40;
        button.layer.masksToBounds = YES;
        [button setTitle:@"+" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //    [<#button#> setImage:<#(nullable UIImage *)#> forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:40];
        [button addTarget:self action:@selector(closeMenu:) forControlEvents:UIControlEventTouchUpInside];
        _menuButton = button;
    }
    return _menuButton;
}
-(void)setItems:(NSArray<YLMenuItem *> *)items
{
    _items = items;
    CGFloat tableWidth = 260;
    CGFloat tableHeight = items.count * KMENUCELLH;
    self.tableView.frame = CGRectMake(CGRectGetMaxX(self.menuButton.frame) - tableWidth, CGRectGetMinY(self.menuButton.frame) - tableHeight - 20, tableWidth, tableHeight);
    [self.view bringSubviewToFront:self.tableView];
    
}
-(void)closeMenu:(UIButton*)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(UIView *)maskView
{
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:self.view.bounds];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.2;
        _maskView.userInteractionEnabled = YES;
    }
    return _maskView;
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.layer.cornerRadius = 10;
        _tableView.layer.masksToBounds = YES;
        _tableView.layer.shadowColor = [UIColor blackColor].CGColor;
        _tableView.layer.shadowOpacity = 0.5;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}
-(void)tapForDismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return  self.items.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    YLMenuItem *item = self.items[indexPath.row];
    cell.textLabel.text = item.itemTitle;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KMENUCELLH;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     YLMenuItem *item = self.items[indexPath.row];
    if (self.selectResultBlock) {
        self.selectResultBlock(item);
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor clearColor];
    [self.view insertSubview:self.maskView atIndex:0];
    [self.view addSubview:self.menuButton];
    [self.view insertSubview:self.tableView aboveSubview:self.maskView];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 输出点击的view的类名
    NSLog(@"%@", NSStringFromClass([touch.view class]));
    
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapForDismiss)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
}
@end
