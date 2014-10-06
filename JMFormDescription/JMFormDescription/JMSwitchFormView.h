//
//  JMSwitchFormView.h
//  JMFormDescription
//
//  Created by jerome morissard on 04/10/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import "JMFormView.h"

@interface JMTSwitchFormViewDescription : JMFormViewDescription
@property (assign, nonatomic) BOOL enable;
@property (assign, nonatomic) BOOL on;
@end

@interface JMSwitchFormView : JMFormView

@property (strong, nonatomic) UIColor *formViewSwitchTintColor UI_APPEARANCE_SELECTOR;

@end
