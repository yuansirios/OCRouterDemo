//
//  OCRouter.h
//  YSRouter
//
//  Created by 18336 on 2018/6/21.
//  Copyright © 2018年 yuansirios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCRouter : NSObject

+ (instancetype)sharedInstance;

- (id)openUrl:(NSString *)urlStr;

- (id)performTarget:(NSString *)targetName action:(NSString *)actionName param:(NSDictionary *)param;

@end
