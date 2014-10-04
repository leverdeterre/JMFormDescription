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

@end
