//
//  MDMAlertRootView.m
//  MDM
//
//  Created by Alekseenko Oleg on 26.02.14.
//  Copyright (c) 2014 Hyperboloid. All rights reserved.
//

#import "MDMAlertRootView.h"
#import <FXBlurView.h>

@interface MDMAlertRootView ()
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UIView *dimView;
@property (nonatomic, strong) FXBlurView *blurView;
@property (nonatomic, strong) UIView *backContainerView;
@property (nonatomic, strong) UIViewController *viewController;
@end


@implementation MDMAlertRootView

- (id)initWithFrame:(CGRect)frame
{
    NSAssert(NO, @"call init insted");
    return nil;
}

- (id)init {
    CGRect frame = [[UIApplication sharedApplication]keyWindow].bounds;
    if (self = [super initWithFrame:frame]) {
        self.clearAllAutomaticaly = YES;
        [self setupViewController];
        [self setupWindow];
        [self setupBackContainerView];
        [self setupBlurView];
        [self setupDimView];
        [self setupContentView];
        self.transitionType = MDMAlertTransitionTypeModal;
    }
    return self;
}


#pragma mark - Setup -

- (void)setupViewController {
    if (!_viewController) {
        _viewController = [[UIViewController alloc]init];
        _viewController.view.backgroundColor = [UIColor clearColor];
        _viewController.view.frame = self.bounds;
        [_viewController.view addSubview:self];
    }
}

- (void)setupWindow {
    if (!_window) {
        _window = [[UIWindow alloc]initWithFrame:self.bounds];
        _window.windowLevel = UIWindowLevelAlert;
        _window.rootViewController = _viewController;
    }
}

- (void)setupBackContainerView {
    if (!_backContainerView) {
        _backContainerView = [[UIView alloc]initWithFrame:self.bounds];
        [self addSubview:_backContainerView];
    }
}

- (void)setupBlurView {
    if (!_blurView) {
        _blurView = [[FXBlurView alloc]initWithFrame:self.backContainerView.bounds];
        _blurView.dynamic = NO;
        _blurView.tintColor = [UIColor clearColor];
        _blurView.blurRadius = 5;
        _blurView.underlyingView = [[UIApplication sharedApplication]keyWindow];
        [self.backContainerView addSubview:_blurView];
    }
}

- (void)setupDimView {
    if (!_dimView) {
        _dimView = [[UIView alloc]initWithFrame:self.backContainerView.bounds];
        _dimView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [self.backContainerView addSubview:_dimView];
    }
}

- (void)setupContentView {
    if (!_contentView) {
        _contentView  = [[UIView alloc]initWithFrame:self.bounds];
        [self addSubview:_contentView];
        [self fillContentView:_contentView];
    }
}

#pragma mark - Actions -

- (void)show {
//    [self updateBlur];
    [self prepareToShow];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startAnimation];
    });
}

- (void)prepareToShow {
    [self.window makeKeyAndVisible];
    self.backContainerView.alpha = 0;
    if (self.transitionType == MDMAlertTransitionTypeModal) {
        self.contentView.frame = ({
            CGRect frame = self.contentView.frame;
            frame.origin.y = self.bounds.size.height;
            frame;
        });

    } else if (self.transitionType == MDMAlertTransitionTypeCustom) {
        [self contentViewWillPresent:YES];
    }
}

- (void)startAnimation {
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseIn animations:^{
        self.backContainerView.alpha = 1.0;
        if (self.transitionType == MDMAlertTransitionTypeModal) {
            self.contentView.frame = ({
                CGRect frame = self.contentView.frame;
                frame.origin.y = 0;
                frame;
            });
        } else if (self.transitionType == MDMAlertTransitionTypeCustom) {
            [self contentViewPresentAnimation];
        }
    } completion:^(BOOL finished) {
        [self contentViewDidPresent:YES];
        [self updateBlur];
    }];
}

- (void)updateBlur {
  
    [_blurView updateAsynchronously:YES completion:^{
        [UIView animateWithDuration:0.3 animations:^{
            _blurView.alpha = 1.0;
        }];
    }];
}

- (void)hide {
    if (self.transitionType == MDMAlertTransitionTypeCustom) {
        [self contentViewWillHide:YES];
    }
    
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.backContainerView.alpha = 0.0;
        if (self.transitionType == MDMAlertTransitionTypeModal) {
            self.contentView.frame = ({
                CGRect frame = self.contentView.frame;
                frame.origin.y = self.bounds.size.height;
                frame;
            });
        } else if (self.transitionType == MDMAlertTransitionTypeCustom) {
            [self contentViewHideAnimation];
        }
    } completion:^(BOOL finished) {
        [self contentViewDidHide:YES];
        if (self.clearAllAutomaticaly) {
            [self clearAll];
        } else {
            _window.hidden = YES;
        }
    }];
}

- (void)clearAll {
    [self removeFromSuperview];
    _window.hidden = YES;
    _window = nil;
    _viewController = nil;
}


- (void)fillContentView:(UIView *)view {

}


- (void)contentViewWillPresent:(BOOL)animated {
    
}

- (void)contentViewPresentAnimation {
    
}

- (void)contentViewDidPresent:(BOOL)animated {
    
}

- (void)contentViewWillHide:(BOOL)animated {
    
}

- (void)contentViewHideAnimation {
    
}

- (void)contentViewDidHide:(BOOL)animated {
    
}
@end
