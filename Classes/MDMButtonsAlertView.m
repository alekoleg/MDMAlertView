//
//  MDMButtonsAlertView.m
//  MDM
//
//  Created by Alekseenko Oleg on 26.02.14.
//  Copyright (c) 2014 Hyperboloid. All rights reserved.
//

#import "MDMButtonsAlertView.h"

static float MDMButtonsAlertViewOffsetX = 10;

@interface MDMButtonsAlertView ()
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *cancelButton;
@end

@implementation MDMButtonsAlertView

- (id)initWithTitle:(NSString *)title cancelButton:(NSString *)cancel otherButtons:(NSArray *)buttons {
    if (self = [super init]) {
        [self setupLabelWithTitle:title];
        [self setupButtonsWith:buttons hasCancelButton:cancel.length > 0];
        [self setupCancelButtonWith:cancel];
        [self centerContentViewSubviews];
    }
    return self;
}

- (id)initWithTitle:(NSString *)title cancelButton:(NSString *)cancel otherButtons:(NSArray *)buttons onCancellClicked:(MDMAlertViewCancelButtonClickedBlock)cancelBlock onOtherClicked:(MDMAlertViewOtherButtonClickedBlock)otherBlock {
    if ([self = self initWithTitle:title cancelButton:cancel otherButtons:buttons]) {
        self.onCancelClicked = cancelBlock;
        self.onOtherButtonClicked = otherBlock;
    }
    return self;
}

#pragma mark - Setup -

- (void)setupLabelWithTitle:(NSString *)title {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(MDMButtonsAlertViewOffsetX, 0, self.frame.size.width - MDMButtonsAlertViewOffsetX * 2, 0)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:24];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:[self separator]];
    }
    _titleLabel.text = title;
    _titleLabel.frame = ({
        CGRect frame = _titleLabel.frame;
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
            frame.size.height = [_titleLabel.text boundingRectWithSize:CGSizeMake(frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName: _titleLabel.font} context:NULL].size.height + 40;
        } else {
            frame.size.height = [_titleLabel.text sizeWithFont:_titleLabel.font constrainedToSize:CGSizeMake(frame.size.width, MAXFLOAT) lineBreakMode:_titleLabel.lineBreakMode].height;
        }
        
        frame;
    });
}

- (void)setupButtonsWith:(NSArray *)buttons hasCancelButton:(BOOL)hasCancelButton {
    if (buttons.count > 0) {
        [buttons enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *stop) {
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(MDMButtonsAlertViewOffsetX, 0, self.frame.size.width - 2 * MDMButtonsAlertViewOffsetX, 95)];
            [button setTitle:obj forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];
            button.tag = idx;
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:button];
            if (idx != buttons.count - 1 || hasCancelButton) {
                [self.contentView addSubview:[self separator]];
            }
        }];
    }
}

- (void)setupCancelButtonWith:(NSString *)cancel {
    if (cancel.length > 0) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(MDMButtonsAlertViewOffsetX, 0, self.contentView.frame.size.width - 2 * MDMButtonsAlertViewOffsetX, 95)];
        [button setTitle:cancel forState:UIControlStateNormal];
        [button addTarget:self action:@selector(cancelClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];
        [self.contentView addSubview:button];
    }
}


#pragma mark - Actions -

- (void)centerContentViewSubviews {
    __block float totalHeight = 0;
    [self.contentView.subviews enumerateObjectsUsingBlock:^(UIView * obj, NSUInteger idx, BOOL *stop) {
        totalHeight += obj.frame.size.height;
    }];
    __block float yOffsex = (self.contentView.frame.size.height - totalHeight) / 2;
    [self.contentView.subviews enumerateObjectsUsingBlock:^(UIView * obj, NSUInteger idx, BOOL *stop) {
        obj.frame = ({
            CGRect frame = obj.frame;
            frame.origin.y = yOffsex;
            frame;
        });
        yOffsex += obj.frame.size.height;
    }];
}

- (void)cancelClicked:(UIButton *)cancel {
    [self hide];
    if (self.onCancelClicked) {
        self.onCancelClicked();
    }
}

- (void)buttonClicked:(UIButton *)button {
    [self hide];
    if (self.onOtherButtonClicked) {
        self.onOtherButtonClicked(button.tag);
    }
}


#pragma mark - Helpers -

- (UIView *)separator {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(MDMButtonsAlertViewOffsetX, 0, self.frame.size.width - 2 * MDMButtonsAlertViewOffsetX, 1)];
    view.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    return view;
}
@end
