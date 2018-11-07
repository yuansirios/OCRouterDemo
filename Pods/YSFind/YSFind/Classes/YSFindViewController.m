//
//  YSFindViewController.m
//  YSRouter
//
//  Created by 18336 on 2018/6/21.
//  Copyright © 2018年 yuansirios. All rights reserved.
//

#import "YSFindViewController.h"
#import "OCRouter.h"

@implementation YSFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发现";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"首页" style:UIBarButtonItemStyleDone target:self action:@selector(indexClick)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
    
- (void)indexClick{
    UIViewController *vc = [[OCRouter sharedInstance]openUrl:@"http://Index/open?arg1=1111111&arg2=2222222"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UIViewController *vc = [[OCRouter sharedInstance]openUrl:@"http://Find/open1?arg1=1111111&arg2=2222222"];
    [self.navigationController pushViewController:vc animated:YES];
}
    
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
