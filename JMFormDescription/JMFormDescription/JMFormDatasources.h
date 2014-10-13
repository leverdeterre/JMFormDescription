//
//  JMFormDatasources.h
//  JMFormDescription
//
//  Created by jerome morissard on 04/10/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JMFormScrollView;
@class JMFormView;
@protocol JMFormViewDatasource <NSObject>

- (void)updateFormViewWithDescription:(id)data;

@end

@protocol JMFormDatasource <NSObject>

@required
- (NSInteger)formScrollView:(JMFormScrollView *)formScrollView numberOfRowsInSection:(NSInteger)section;
- (JMFormView *)formScrollView:(JMFormScrollView *)formScrollView formViewForRowAtIndexPath:(NSIndexPath *)indexPath;

@end