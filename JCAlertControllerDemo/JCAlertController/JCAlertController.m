//
//  JCAlertController.m
//  Easybao
//
//  Created by wenjie hua on 2016/12/28.
//  Copyright © 2016年 gold. All rights reserved.
//

#import "JCAlertController.h"
#import "JCAlertTransitionAnimation.h"

@implementation JCAlertAction
@synthesize title = _title;
@synthesize style = _style;
@synthesize handler = _handler;

+ (instancetype)actionWithTitle:(NSString *)title style:(JCAlertActionStyle)style handler:(void (^)(JCAlertAction *))handler{
    JCAlertAction *alertAction = [[JCAlertAction alloc] initWithTitle:title style:style handler:handler];
    return alertAction;
}

- (instancetype)initWithTitle:(NSString *)title style:(JCAlertActionStyle)style handler:(void (^)())handler{
    self = [super init];
    if (self) {
        _title = title;
        _style = style;
        _handler = handler;
    }
    return self;
}
@end

@interface JCAlertController ()<UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UIView *vLine;
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lcWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lcMsgBottom;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIView *vVline;
@property (nonatomic, strong) NSAttributedString *attributedMessage;

@end

@implementation JCAlertController
@synthesize preferredStyle = _preferredStyle;
@synthesize title = _title;
@synthesize message = _message;
@synthesize actions = _actions;

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(JCAlertControllerStyle)preferredStyle{
    JCAlertController *vcAlert = [[JCAlertController alloc] initWithTitle:title message:message preferredStyle:preferredStyle];
    vcAlert.transitioningDelegate = vcAlert;
    vcAlert.modalPresentationStyle = UIModalPresentationCustom;
    return vcAlert;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(JCAlertControllerStyle)preferredStyle{
    self = [super init];
    if (self) {
        _title = title;
        _message = message;
        _preferredStyle = preferredStyle;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self updateUI];
}

- (void)setUI{
    self.vAlert.clipsToBounds = YES;
    self.vAlert.layer.cornerRadius = 8;
    self.vLine.backgroundColor = [JCYColorManager colorPswTxfBorder];
    self.vVline.backgroundColor = [JCYColorManager colorPswTxfBorder];
    self.vVline.hidden = YES;
    self.btn1.hidden = YES;
    self.btn2.hidden = YES;
    
    self.btn1.exclusiveTouch = YES;
    self.btn2.exclusiveTouch = YES;
}

- (void)updateUI{
    if (self.attributedMessage.length > 0) {
        self.lblMessage.attributedText = self.attributedMessage;
    } else {
        self.lblMessage.text = self.message;
    }
    
    
    if (self.title.length > 0) {
        self.lblTitle.text = self.title;
        self.lcMsgBottom.constant = 20;
    } else {
        [self.lblTitle removeFromSuperview];
        self.lcMsgBottom.constant = 32;
    }
    
    if (self.actions.count == 1) {
        JCAlertAction *action = [self.actions objectAtIndex:0];
        [self setBtn:self.btn1 action:action];
        self.lcWidth.constant = self.vAlert.bounds.size.width;
        self.btn1.hidden = NO;
        self.btn2.hidden = YES;
        self.vVline.hidden = YES;
    } else if (self.actions.count == 2) {
        JCAlertAction *action = [self.actions objectAtIndex:0];
        [self setBtn:self.btn1 action:action];
        JCAlertAction *action2 = [self.actions objectAtIndex:1];
        [self setBtn:self.btn2 action:action2];
        self.lcWidth.constant = self.vAlert.bounds.size.width / 2.0;
        self.btn1.hidden = NO;
        self.btn2.hidden = NO;
        self.vVline.hidden = NO;
    }
}

#pragma mark - Public Methods
- (void)addAction:(JCAlertAction *)action{
    if (self.actions.count <= 1) {
        NSMutableArray *actions = (NSMutableArray *)self.actions;
        [actions addObject:action];
    }
}

#pragma mark - Private Methods
- (void)setBtn:(UIButton *)btn action:(JCAlertAction *)action{
    UIColor * color = [JCYColorManager colorMain];
    
    if (action.style == JCAlertActionStyleCancel) {
        color = [JCYColorManager colorMain];
    }
    
    NSString *title = @"";
    
    if (action.title.length > 0) {
        title = action.title;
    }
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
}
- (IBAction)btnAction:(id)sender {
    WeakObj(self);
    [self dismissViewControllerAnimated:YES completion:^{
        StrongObj(self);
        if (sender == selfWeak.btn1) {
            if (selfWeak.actions.count >= 1) {
                JCAlertAction *action = [self.actions objectAtIndex:0];
                if (action.handler) {
                    action.handler(action);
                }
            }
        }else if (sender == selfWeak.btn2){
            if (selfWeak.actions.count >= 2) {
                JCAlertAction *action = [self.actions objectAtIndex:1];
                if (action.handler) {
                    action.handler(action);
                }
            }
        }
    }];
}
#pragma mark - setter and getter Methods
- (NSArray *)actions{
    if (_actions == nil) {
        _actions = [[NSMutableArray alloc] init];
    }
    return _actions;
}
- (void)setAttributedMessage:(NSAttributedString *)attributedMessage{
    _attributedMessage = attributedMessage;
}
#pragma mark - UIViewControllerTransitioningDelegate Methods

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    JCAlertTransitionAnimation *animation = [[JCAlertTransitionAnimation alloc] init];
    
    switch (self.preferredStyle) {
        case JCAlertControllerStyleAlert:
            animation.type = JCAlertTransitionAnimationTypePop;
            break;
        default:
            animation.type = JCAlertTransitionAnimationTypePush;
            break;
    }
    return animation;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    JCAlertTransitionAnimation *animation = [[JCAlertTransitionAnimation alloc] init];
    
    switch (self.preferredStyle) {
        case JCAlertControllerStyleAlert:
            animation.type = JCAlertTransitionAnimationTypePop;
            break;
        default:
            animation.type = JCAlertTransitionAnimationTypePush;
            break;
    }
    return animation;
}

- (BOOL)willDealloc {
    return NO;
}

@end
