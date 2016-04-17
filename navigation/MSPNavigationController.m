//
//  MSPNavigationController.m
//  navigation
//
//  Created by 马了个马里奥 on 16/4/16.
//  Copyright © 2016年 马了个马里奥. All rights reserved.
//

#import "MSPNavigationController.h"

@interface MSPNavigationController ()

@end

@implementation MSPNavigationController

// this
- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}

// or this
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    UIViewController * topVC = self.topViewController;
//    return [topVC preferredStatusBarStyle];
//}


@end
