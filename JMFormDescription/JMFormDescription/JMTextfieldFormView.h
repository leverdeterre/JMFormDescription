//
//  JMTextfieldFormView.h
//  JMFormDescription
//
//  Created by jerome morissard on 23/09/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import "JMFormView.h"

@interface JMTextfieldFormViewDescription : JMFormViewDescription
@property (copy, nonatomic) NSString *placeholder;
@property (assign, nonatomic) CGSize textfieldSize;
@end

@interface JMTextfieldFormViewDescription (JMTextfieldFormBlocked)
@property (assign, nonatomic) SEL blockingButtonSelector;
@end


@interface JMTextfieldFormView : JMFormView
@property (strong, nonatomic) UIFont *formViewTextfieldFont UI_APPEARANCE_SELECTOR;
@property (strong, nonatomic) UIColor *formViewTextfieldBackgroundColor UI_APPEARANCE_SELECTOR;
@property (strong, nonatomic) UIColor *formViewTextfieldTextColor UI_APPEARANCE_SELECTOR;

/*
@property (assign, nonatomic) CGFloat textfieldCornerRadius UI_APPEARANCE_SELECTOR;
@property (assign, nonatomic) CGFloat textfieldShadowOpacity UI_APPEARANCE_SELECTOR;
@property (assign, nonatomic) CGSize textfieldShadowOffset UI_APPEARANCE_SELECTOR;
@property (assign, nonatomic) BOOL textfieldClipsToBounds  UI_APPEARANCE_SELECTOR;
@property (assign, nonatomic) CGFloat textfieldShadowRadius UI_APPEARANCE_SELECTOR;
 */
@end
