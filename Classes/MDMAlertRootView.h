//
//  MDMAlertRootView.h
//  MDM
//
//  Created by Alekseenko Oleg on 26.02.14.
//  Copyright (c) 2014 Hyperboloid. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MDMAlertTransitionType) {
    MDMAlertTransitionTypeModal = 0,
    MDMAlertTransitionTypeCustom = 10,
};

@interface MDMAlertRootView : UIView

@property (nonatomic) MDMAlertTransitionType transitionType;
@property (nonatomic, readonly) UIView *contentView;
@property (nonatomic, assign) BOOL clearAllAutomaticaly;

- (void)show;
- (void)hide;
- (void)clearAll;

//child must override this to fill data
- (void)fillContentView:(UIView *)view;

//calls only if transition type custom
- (void)contentViewWillPresent:(BOOL)animated; //inital setup
- (void)contentViewPresentAnimation; //destination
- (void)contentViewDidPresent:(BOOL)animated;

- (void)contentViewWillHide:(BOOL)animated;
- (void)contentViewHideAnimation;
- (void)contentViewDidHide:(BOOL)animated;

@end
