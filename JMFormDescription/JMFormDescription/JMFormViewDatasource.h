//
//  JMFormViewDatasource.h
//  JMFormDescription
//
//  Created by jerome morissard on 04/10/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JMFormViewDatasource <NSObject>

- (void)updateFormViewWithDescription:(id)data;

@end
