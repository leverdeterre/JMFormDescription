//
//  JMFormViewController+formDescription.m
//  JMFormDescription
//
//  Created by jerome morissard on 23/09/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import "JMFormViewController+formDescription.h"
#import "JMFormViews.h"

@implementation JMFormViewController (formDescription)

- (JMFormDescription *)generateFormDescriptionUsingModel:(JMFormModel *)model
{
    JMFormDescription *formDesc = [JMFormDescription new];
    NSMutableArray *descriptions = [NSMutableArray new];
    
    JMFormSectionHeaderFormViewDescription *headerDesc = [JMFormSectionHeaderFormViewDescription new];
    headerDesc.title = @"Textfield tests";
    [descriptions addObject:headerDesc];
    
    JMTextfieldFormViewDescription *textfieldDesc  = [JMTextfieldFormViewDescription new];
    textfieldDesc.placeholder = @"Mon placeholder";
    textfieldDesc.data = model.textfieldText1;
    textfieldDesc.formDelegate = self;
    textfieldDesc.modelKey = @"textfieldText1";
    [descriptions addObject:textfieldDesc];
    
    textfieldDesc  = [JMTextfieldFormViewDescription new];
    textfieldDesc.placeholder = nil;
    textfieldDesc.data = model.textfieldText2;
    textfieldDesc.formDelegate = self;
    textfieldDesc.modelKey = @"textfieldText2";
    [descriptions addObject:textfieldDesc];
    
    textfieldDesc  = [JMTextfieldFormViewDescription new];
    textfieldDesc.placeholder = nil;
    textfieldDesc.data = model.textfieldText3;
    textfieldDesc.formDelegate = self;
    textfieldDesc.blockingButtonSelector = @selector(customSelector1:);
    textfieldDesc.modelKey = @"textfieldText3";
    textfieldDesc.placeholder = @"Editable via customSelector1";
    [descriptions addObject:textfieldDesc];
     
    headerDesc = [JMFormSectionHeaderFormViewDescription new];
    headerDesc.title = @"Textfield tests With title";
    [descriptions addObject:headerDesc];
    
    JMTextfieldWithTitleFormViewDescription * textfieldTitleDesc = [JMTextfieldWithTitleFormViewDescription new];
    textfieldTitleDesc.title = @"Mont titre3";
    textfieldTitleDesc.placeholder = @"Mon placeholder3";
    textfieldTitleDesc.data = model.textfieldText4;
    textfieldTitleDesc.formDelegate = self;
    textfieldTitleDesc.modelKey = @"textfieldText4";
    [descriptions addObject:textfieldTitleDesc];
    
    textfieldTitleDesc = [JMTextfieldWithTitleFormViewDescription new];
    textfieldTitleDesc.title = @"Mont titre4";
    textfieldTitleDesc.placeholder = @"Mon placeholder4";
    textfieldTitleDesc.data = model.textfieldText5;
    textfieldTitleDesc.formDelegate = self;
    textfieldTitleDesc.modelKey = @"textfieldText5";
    [descriptions addObject:textfieldTitleDesc];
    
    headerDesc = [JMFormSectionHeaderFormViewDescription new];
    headerDesc.title = @"Switch tests title";
    [descriptions addObject:headerDesc];
    
    JMTSwitchFormViewDescription *switchDescription = [JMTSwitchFormViewDescription new];
    switchDescription.data = @"Mon text de switch";
    switchDescription.on = model.switch1;
    switchDescription.formDelegate = self;
    switchDescription.modelKey = @"switch1";
    [descriptions addObject:switchDescription];
    
    switchDescription = [JMTSwitchFormViewDescription new];
    switchDescription.data = @"Mon text de switch";
    switchDescription.on = model.switch2;
    switchDescription.formDelegate = self;
    switchDescription.modelKey = @"switch2";
    [descriptions addObject:switchDescription];
    
    switchDescription = [JMTSwitchFormViewDescription new];
    switchDescription.data = @"Switch pour déplier";
    switchDescription.on = model.expended;
    switchDescription.formDelegate = self;
    switchDescription.modelKey = @"expended";
    [descriptions addObject:switchDescription];
    
    if (model.expended) {
        JMTextfieldWithTitleFormViewDescription * textfieldTitleDesc = [JMTextfieldWithTitleFormViewDescription new];
        textfieldTitleDesc.title = @"Secret textfield";
        textfieldTitleDesc.placeholder = @"Secret textfield";
        textfieldTitleDesc.data = model.secretValue;
        textfieldTitleDesc.formDelegate = self;
        textfieldTitleDesc.modelKey = @"secretValue";
        [descriptions addObject:textfieldTitleDesc];
        
        textfieldTitleDesc = [JMTextfieldWithTitleFormViewDescription new];
        textfieldTitleDesc.title = @"Secret textfield 2";
        textfieldTitleDesc.placeholder = @"Secret textfield 2";
        textfieldTitleDesc.data = model.secretValue2;
        textfieldTitleDesc.formDelegate = self;
        textfieldTitleDesc.modelKey = @"secretValue2";
        [descriptions addObject:textfieldTitleDesc];
    }
    
    switchDescription = [JMTSwitchFormViewDescription new];
    switchDescription.data = @"Mon text de switch un peu plus llong ";
    switchDescription.enable = NO;
    switchDescription.on = model.switch4;
    switchDescription.formDelegate = self;
    switchDescription.modelKey = @"switch4";
    [descriptions addObject:switchDescription];
    
    headerDesc = [JMFormSectionHeaderFormViewDescription new];
    headerDesc.title = @"List selection tests title";
    [descriptions addObject:headerDesc];
    
    JMListFormViewDescription *listDesc = [JMListFormViewDescription new];
    listDesc.title = model.listPlaceholder;
    listDesc.formDelegate = self;
    listDesc.choices = model.coloChoices;
    listDesc.placeholder = model.listPlaceholder;
    listDesc.data = model.selectedColorNAme;
    listDesc.modelKey = @"selectedColorNAme";
    [descriptions addObject:listDesc];
    
    listDesc = [JMListFormViewDescription new];
    listDesc.title = model.listPlaceholder;
    listDesc.formDelegate = self;
    listDesc.choices = model.coloChoices;
    listDesc.placeholder = model.listPlaceholder;
    listDesc.data = model.selectedColorNAme2;
    listDesc.modelKey = @"selectedColorNAme2";
    [descriptions addObject:listDesc];
    
    headerDesc = [JMFormSectionHeaderFormViewDescription new];
    headerDesc.title = @"TextView tests";
    [descriptions addObject:headerDesc];
    
    JMTextViewFormViewDescription *textDesc = [JMTextViewFormViewDescription new];
    textDesc.formDelegate = self;
    textDesc.placeholder = @"";
    textDesc.data = model.bigText;
    textDesc.modelKey = @"bigText";
    [descriptions addObject:textDesc];
    
    textDesc = [JMTextViewFormViewDescription new];
    textDesc.formDelegate = self;
    textDesc.placeholder = @"";
    textDesc.data = model.bigText2;
    textDesc.modelKey = @"bigText2";
    [descriptions addObject:textDesc];
    
    headerDesc = [JMFormSectionHeaderFormViewDescription new];
    headerDesc.title = @"Button tests";
    [descriptions addObject:headerDesc];
    
    JMButtonFormViewDescription *buttonDesc = [JMButtonFormViewDescription new];
    buttonDesc.formDelegate = self;
    buttonDesc.title = @"This is a validation button";
    buttonDesc.formViewHeight = 50.0f;
    [descriptions addObject:buttonDesc];

    
    formDesc.formViewDescriptions = descriptions;
    return formDesc;
}

@end

