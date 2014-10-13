//
//  JMFormScrollView.h
//  JMFormDescription
//
//  Created by jerome morissard on 04/10/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMFormDatasources.h"

@class JMFormView;
@class JMFormViewDescription;
@interface JMFormScrollView : UIScrollView

@property (assign, nonatomic) CGFloat formViewSpace UI_APPEARANCE_SELECTOR;
@property (weak, nonatomic) id <JMFormDatasource> formViewDatasource;

- (void)reloadScrollViewWithFormDescription:(NSArray *)description;
- (void)reloadData;

- (NSInteger)indexForFormView:(JMFormView *)formView;
- (JMFormView *)nextFirstResponderFormViewFromView:(JMFormView *)formView;
- (JMFormView *)previousFirstResponderFormViewFromView:(JMFormView *)formView;

@end
