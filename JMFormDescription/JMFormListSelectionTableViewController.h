//
//  JMFormListSelectionTableViewController.h
//  JMFormDescription
//
//  Created by jerome morissard on 04/10/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMFormDelegate.h"
#import "JMFormView.h"

@interface JMFormListSelectionTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *values;
@property (weak, nonatomic) id <JMFormDelegate> formDelegate;
@property (strong, nonatomic) NSString *modelKey;
@property (copy, nonatomic) JMFormViewCompltionBlock completionBlock;
@end
