//
//  JCAlertController.h
//  Easybao
//
//  Created by wenjie hua on 2016/12/28.
//  Copyright © 2016年 gold. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, JCAlertActionStyle) {
    JCAlertActionStyleDefault = 0,
    JCAlertActionStyleCancel
};

typedef NS_ENUM(NSInteger, JCAlertControllerStyle) {
    JCAlertControllerStyleAlert
};

@interface JCAlertAction: NSObject
+ (instancetype)actionWithTitle:(NSString *)title style:(JCAlertActionStyle)style handler:(void (^)(JCAlertAction *))handler;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, readonly) JCAlertActionStyle style;
@property (nonatomic, copy, readonly) void(^handler)(JCAlertAction *);

@end

@interface JCAlertController : UIViewController

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(JCAlertControllerStyle)preferredStyle;

- (void)addAction:(JCAlertAction *)action;

@property (nonatomic, readonly) NSArray<JCAlertAction *> *actions;
@property (nonatomic, strong) NSString *message;

@property (nonatomic, readonly) JCAlertControllerStyle preferredStyle;

@property (weak, nonatomic) IBOutlet UIView *vBackground;
@property (weak, nonatomic) IBOutlet UIView *vAlert;

@end
