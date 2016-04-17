//
//  SecondViewController.m
//  navigation
//
//  Created by 马了个马里奥 on 16/4/17.
//  Copyright © 2016年 马了个马里奥. All rights reserved.
//

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

@interface SecondViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, readwrite, assign) BOOL statusBarStyleControl;

@property (nonatomic, readwrite, strong) UITableView *tableView;

@property (nonatomic, readwrite, strong) UIImageView *imageView;

@property (nonatomic, assign) CGFloat alpha;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 314)];
    self.imageView.image = [UIImage imageNamed:@"beauty.jpeg"];
    [self.view addSubview:self.imageView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView setContentInset:UIEdgeInsetsMake(64 + 136, 0, 0, 0)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];

    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
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

#ifdef __IPHONE_7_0
- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (_statusBarStyleControl) {
        return UIStatusBarStyleDefault;
    }
    else {
        return UIStatusBarStyleLightContent;
    }
}
- (BOOL)prefersStatusBarHidden
{
    return NO;
}
#endif

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y + _tableView.contentInset.top;
    
    if (offsetY > 136 && offsetY <= 136 * 2) {
        
        _statusBarStyleControl = YES;
        if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
            [self setNeedsStatusBarAppearanceUpdate];
        }
        self.navigationController.navigationBar.tintColor = [UIColor blackColor];
        
        _alpha = offsetY/(136 * 2) >= 1 ? 1 : offsetY/(136 * 2);
        
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:_alpha];
        
    }
    else if (offsetY <= 136) {
        _statusBarStyleControl = NO;
        if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
            [self setNeedsStatusBarAppearanceUpdate];
        }
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        
        _alpha = 0;
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    }
    else if (offsetY > 136 * 2) {
        _alpha = 1;
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    }
    
    if (offsetY < 0) {
        self.imageView.transform = CGAffineTransformMakeScale(1 + offsetY/(-500), 1 + offsetY/(-500));
    }
    
    
}



@end
