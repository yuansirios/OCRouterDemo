//
//  OCTarget_Index.m
//  YSRouter
//
//  Created by 18336 on 2018/6/21.
//  Copyright © 2018年 yuansirios. All rights reserved.
//

#import "OCTarget_Index.h"
#import "YSIndexViewController.h"

@implementation OCTarget_Index

- (id)action_open:(NSDictionary *)pargma{
    NSLog(@"参数：%@",pargma);
    YSIndexViewController *vc = [[YSIndexViewController alloc]init];
    return vc;
}

@end
