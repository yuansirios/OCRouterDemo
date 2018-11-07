//
//  OCTarget_Find.m
//  YSRouter
//
//  Created by 18336 on 2018/6/21.
//  Copyright © 2018年 yuansirios. All rights reserved.
//

#import "OCTarget_Find.h"
#import "YSFindViewController.h"

@implementation OCTarget_Find

- (id)action_open:(NSDictionary *)pargma{
    NSLog(@"参数：%@",pargma);
    YSFindViewController *vc = [[YSFindViewController alloc]init];
    return vc;
}

//TODO:根据产品实现
- (id)notFound:(NSDictionary *)pargma{
    NSLog(@"notFound：参数：%@",pargma);
    UIViewController *vc = [UIViewController new];
    vc.title = @"未找到";
    return vc;
}
    
@end
