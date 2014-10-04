//
//  JMFormScrollView.h
//  JMFormDescription
//
//  Created by jerome morissard on 04/10/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JMFormView;
@class JMFormViewDescription;

@interface JMFormScrollView : UIScrollView

- (void)reloadScrollViewWithFormDescription:(NSArray *)description;
//- (void)insertFormViewDescription:(JMFormViewDescription *)description afterFromView:(JMFormView *)formView;
//- (void)insertFormViewDescriptions:(NSArray *)descriptions afterFromView:(JMFormView *)formView;

- (NSInteger)indexForFormView:(JMFormView *)formView;
- (JMFormView *)nextFirstResponderFormViewFromView:(JMFormView *)formView;
- (JMFormView *)previousFirstResponderFormViewFromView:(JMFormView *)formView;

@end
