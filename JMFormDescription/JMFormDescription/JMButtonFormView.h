//
//  JMButtonFormView.h
//  JMFormDescription
//
//  Created by jerome morissard on 04/10/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import "JMFormView.h"

@interface JMButtonFormViewDescription : JMFormViewDescription
@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) BOOL enable;
@end

@interface JMButtonFormView : JMFormView
@property (strong, nonatomic) UIColor *formViewButtonTitleColor UI_APPEARANCE_SELECTOR;
@property (strong, nonatomic) UIFont *formViewButtonTitleFont UI_APPEARANCE_SELECTOR;
@property (strong, nonatomic) UIColor *formViewButtonBackgroundColor UI_APPEARANCE_SELECTOR;
@end


/*
 [button.layer setCornerRadius:2];
 [button setTitleColor:[self brun2] forState:UIControlStateNormal];
 button.backgroundColor = color;
 
 if (enabled) {
 button.layer.shadowColor = [[self shadowColor] CGColor];
 button.layer.shadowOpacity = 1;
 button.layer.shadowOffset = CGSizeMake(0,1);
 button.clipsToBounds = NO;
 button.layer.shadowRadius = 1.0;
 button.alpha = 1.0;
 button.layer.shadowPath = [[UIBezierPath bezierPathWithRect:button.bounds] CGPath];
 } else {
 button.clipsToBounds = YES;
 if (IS_IBIS()) {
 button.alpha = 0.6;
 } else if (IS_HOTELF1()) {
 button.alpha = 0.3;
 }
 }
 */