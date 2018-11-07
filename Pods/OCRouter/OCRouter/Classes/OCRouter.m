//
//  OCRouter.m
//  YSRouter
//
//  Created by 18336 on 2018/6/21.
//  Copyright © 2018年 yuansirios. All rights reserved.
//

#import "OCRouter.h"

@implementation OCRouter

+ (instancetype)sharedInstance{
    static OCRouter *mediator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mediator = [[OCRouter alloc]init];
    });
    return mediator;
}

- (id)openUrl:(NSString *)urlStr{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    //查询
    NSString *urlString = [url query];
    //切割字符串
    for (NSString *param in [urlString componentsSeparatedByString:@"&"]){
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if ([elts count] < 2)  continue;
        
        id firstEle = [elts firstObject];
        id lastEle = [elts lastObject];
        
        if (firstEle && lastEle) {
            [params setObject:lastEle forKey:firstEle];
        }
    }
    
    NSString *actionName = [url.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    if ([actionName hasPrefix:@"native"]) {
        return @(NO);
    }
    
    id result = [self performTarget:url.host action:actionName param:params];
    return result;
}

- (id)performTarget:(NSString *)targetName action:(NSString *)actionName param:(NSDictionary *)param{
    //这个目标类名字符串
    NSString *targetClassString = [NSString stringWithFormat:@"OCTarget_%@",targetName];
    NSString *actionMethodString = [NSString stringWithFormat:@"action_%@:",actionName];
    
    Class targetClass = NSClassFromString(targetClassString);
    NSObject *target = [[targetClass alloc]init];
    
    SEL action = NSSelectorFromString(actionMethodString);
    
    if ([target respondsToSelector:action]) {
        return [self safePerformAction:action target:target param:param];
    }else{
        SEL action = NSSelectorFromString(@"notFound:");
        if ([target respondsToSelector:action]) {
            return [self safePerformAction:action target:target param:param];
        }else{
            return nil;
        }
    }
    return nil;
}

- (id)safePerformAction:(SEL)action target:(NSObject *)target param:(NSDictionary *)param{
    NSMethodSignature *methodSig = [target methodSignatureForSelector:action];
    if (methodSig == nil) {
        return nil;
    }
    
    //获去这个方法的地址
    const char *retType = [methodSig methodReturnType];
    
    //id 是可以返回任意对象，所有我们单独处理基类变量，NSInteger Bool Void...
    if (strcmp(retType, @encode(NSInteger)) == 0){
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        
        [invocation setArgument:&param atIndex:2];
        [invocation setTarget:target];
        [invocation setSelector:action];
        [invocation invoke];
        
        NSInteger result = 0;
        [invocation getReturnValue:&result];
        
        return @(result);
    }
    
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector"
    return [target performSelector:action withObject:param];
    #pragma clang diagnostic pop
    
}

@end
