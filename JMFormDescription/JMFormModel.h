//
//  JMFormModel.h
//  JMFormDescription
//
//  Created by jerome morissard on 04/10/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMFormModel : NSObject
@property (strong, nonatomic) NSString *textfieldText1;
@property (strong, nonatomic) NSString *textfieldText2;
@property (strong, nonatomic) NSString *textfieldText3;
@property (strong, nonatomic) NSString *textfieldText4;
@property (strong, nonatomic) NSString *textfieldText5;
@property (assign, nonatomic) BOOL switch1;
@property (assign, nonatomic) BOOL switch2;
@property (assign, nonatomic) BOOL expended;
@property (strong, nonatomic) NSString *secretValue;
@property (strong, nonatomic) NSString *secretValue2;
@property (assign, nonatomic) BOOL switch4;
@property (strong, nonatomic) NSArray *coloChoices;
@property (strong, nonatomic) NSString *selectedColorNAme;
@property (strong, nonatomic) NSString *selectedColorNAme2;
@property (strong, nonatomic) NSString *listPlaceholder;
@property (strong, nonatomic) NSString *bigText;
@property (strong, nonatomic) NSString *bigText2;
@end
