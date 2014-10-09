//
//  JMFormViewController2.h
//  JMFormDescription
//
//  Created by jerome morissard on 09/10/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMFormDelegate.h"

@interface JMFormViewController2 : UIViewController <JMFormDelegate>

- (IBAction)customSelector1:(id)sender;
- (void)reloadContent;
- (void)presentChoices;

@end
