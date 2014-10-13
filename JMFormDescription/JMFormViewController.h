//
//  JMFormViewController.h
//  JMFormDescription
//
//  Created by jerome morissard on 23/09/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMFormDelegate.h"
#import "JMFormScrollView.h"

@interface JMFormViewController : UIViewController <JMFormDelegate, JMKeyboardFormDelegate>

@property (weak, nonatomic) IBOutlet JMFormScrollView *formScrollView;

- (IBAction)customSelector1:(id)sender;
- (void)reloadContent;
- (void)presentChoices;

@end
