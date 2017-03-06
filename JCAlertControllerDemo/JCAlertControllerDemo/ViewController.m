//
//  ViewController.m
//  JCAlertControllerDemo
//
//  Created by 戴奕 on 2017/3/6.
//  Copyright © 2017年 JC. All rights reserved.
//

#import "ViewController.h"
#import "JCAlertController.h"

@implementation ViewController

- (IBAction)alertBtnAction:(id)sender {
    // 使用方法和系统的一样
    JCAlertController *alertController = [JCAlertController alertControllerWithTitle:@"提示" message:@"这是一个自定义的alertController，使用的是自定义转场实现" preferredStyle:JCAlertControllerStyleAlert];
    
    JCAlertAction *okAction = [JCAlertAction actionWithTitle:@"确定" style:JCAlertActionStyleDefault handler:^(JCAlertAction *action) {
        NSLog(@"我点击了确定");
    }];
    [alertController addAction:okAction];
    
    JCAlertAction *cancelAction = [JCAlertAction actionWithTitle:@"取消" style:JCAlertActionStyleDefault handler:^(JCAlertAction *action) {
        NSLog(@"我点击了取消");
    }];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
