//
//  ViewController.m
//  navigation
//
//  Created by 马了个马里奥 on 16/4/9.
//  Copyright © 2016年 马了个马里奥. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface UIColor (randomColor)

+ (UIColor *)randomColor;

@end

@implementation UIColor (randomColor)

+ (UIColor *)randomColor
{
    CGFloat r = arc4random_uniform(255);
    CGFloat g = arc4random_uniform(255);
    CGFloat b = arc4random_uniform(255);
    return [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:1];
}

@end

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, readwrite, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = nil;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView.separatorInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 120, 100, 100);
    [button setTitle:@"push!!!" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(touch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)touch
{
    [self.navigationController pushViewController:[[SecondViewController alloc] init] animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [UIColor randomColor];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y + _tableView.contentInset.top;
    CGFloat panTranslationY = [scrollView.panGestureRecognizer translationInView:self.tableView].y;
    NSLog(@"offsety:%d",(int)offsetY);
    NSLog(@"pan:%d",(int)panTranslationY);
    if (offsetY > 64) {
        if (panTranslationY > 0) { // down
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }
        else { // up
            [self.navigationController setNavigationBarHidden:YES animated:YES];
        }
    }
    else {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }

}



@end
