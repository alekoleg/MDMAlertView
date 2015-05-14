 //
//  MDMButtonsAlertView.h
//  MDM
//
//  Created by Alekseenko Oleg on 26.02.14.
//  Copyright (c) 2014 Hyperboloid. All rights reserved.
//

#import "MDMAlertRootView.h"

typedef void (^MDMAlertViewCancelButtonClickedBlock) ();
typedef void (^MDMAlertViewOtherButtonClickedBlock) (NSInteger clickedIndex);

@interface MDMButtonsAlertView : MDMAlertRootView

//вызывается, когда нажимается кнопка отмены. Может быть nil
@property (nonatomic, copy) MDMAlertViewCancelButtonClickedBlock onCancelClicked;
//вызывается, когда нажимается любая другая кнопка выбора. Может быть nil
@property (nonatomic, copy) MDMAlertViewOtherButtonClickedBlock onOtherButtonClicked;

- (id)initWithTitle:(NSString *)title cancelButton:(NSString *)cancel otherButtons:(NSArray *)buttons;
- (id)initWithTitle:(NSString *)title cancelButton:(NSString *)cancel otherButtons:(NSArray *)buttons onCancellClicked:(MDMAlertViewCancelButtonClickedBlock)cancelBlock onOtherClicked:(MDMAlertViewOtherButtonClickedBlock)otherBlock;
@end
