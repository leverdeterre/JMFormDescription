//
//  JMFormViewController+formDescriptionUsingBlocks.m
//  JMFormDescription
//
//  Created by jerome morissard on 09/10/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import "JMFormViewController+formDescriptionUsingBlocks.h"
#import "JMFormViews.h"

@implementation JMFormViewController (formDescriptionUsingBlocks)

- (JMFormDescription *)generateFormDescriptionBlocksUsingModel:(JMFormModel *)model
{
    JMFormDescription *formDesc = [JMFormDescription new];
    NSMutableArray *descriptions = [NSMutableArray new];
    
    JMFormSectionHeaderFormViewDescription *headerDesc = [JMFormSectionHeaderFormViewDescription new];
    headerDesc.title = @"Textfield tests";
    [descriptions addObject:headerDesc];
    
    JMTextfieldFormViewDescription *textfieldDesc  = [JMTextfieldFormViewDescription new];
    textfieldDesc.placeholder = @"Mon placeholder";
    textfieldDesc.data = model.textfieldText1;
    textfieldDesc.keyboardFormDelegate = self;
    textfieldDesc.updateBlock = ^(id modifiedValue){
        model.textfieldText1 = modifiedValue;
    };
    [descriptions addObject:textfieldDesc];
    
    textfieldDesc  = [JMTextfieldFormViewDescription new];
    textfieldDesc.placeholder = nil;
    textfieldDesc.data = model.textfieldText2;
    textfieldDesc.keyboardFormDelegate = self;
    textfieldDesc.updateBlock = ^(id modifiedValue){
        model.textfieldText2 = modifiedValue;
    };
    [descriptions addObject:textfieldDesc];
    
    textfieldDesc  = [JMTextfieldFormViewDescription new];
    textfieldDesc.placeholder = nil;
    textfieldDesc.data = model.textfieldText3;
    textfieldDesc.keyboardFormDelegate = self;
    textfieldDesc.updateBlock = ^(id modifiedValue){
        model.textfieldText3 = modifiedValue;
    };
    [descriptions addObject:textfieldDesc];
    
    headerDesc = [JMFormSectionHeaderFormViewDescription new];
    headerDesc.title = @"Textfield tests With title";
    [descriptions addObject:headerDesc];
    
    JMTextfieldWithTitleFormViewDescription * textfieldTitleDesc = [JMTextfieldWithTitleFormViewDescription new];
    textfieldTitleDesc.title = @"Mont titre4";
    textfieldTitleDesc.placeholder = @"Mon placeholder4";
    textfieldTitleDesc.data = model.textfieldText4;
    textfieldTitleDesc.keyboardFormDelegate = self;
    textfieldTitleDesc.updateBlock = ^(id modifiedValue){
        model.textfieldText4 = modifiedValue;
    };
    [descriptions addObject:textfieldTitleDesc];
    
    textfieldTitleDesc = [JMTextfieldWithTitleFormViewDescription new];
    textfieldTitleDesc.title = @"Mont titre5";
    textfieldTitleDesc.placeholder = @"Mon placeholder5";
    textfieldTitleDesc.data = model.textfieldText5;
    textfieldTitleDesc.keyboardFormDelegate = self;
    textfieldTitleDesc.updateBlock = ^(id modifiedValue){
        model.textfieldText5 = modifiedValue;
    };
    [descriptions addObject:textfieldTitleDesc];
    
    headerDesc = [JMFormSectionHeaderFormViewDescription new];
    headerDesc.title = @"Switch tests title";
    [descriptions addObject:headerDesc];
    
    JMTSwitchFormViewDescription *switchDescription = [JMTSwitchFormViewDescription new];
    switchDescription.data = @"Mon text de switch";
    switchDescription.on = model.switch1;
    switchDescription.updateBlock = ^(id modifiedValue){
        model.switch1 = [modifiedValue boolValue];
    };
    [descriptions addObject:switchDescription];
    
    switchDescription = [JMTSwitchFormViewDescription new];
    switchDescription.data = @"Mon text de switch";
    switchDescription.on = model.switch2;
    switchDescription.updateBlock = ^(id modifiedValue){
        model.switch2 = [modifiedValue boolValue];
    };
    [descriptions addObject:switchDescription];
    
    switchDescription = [JMTSwitchFormViewDescription new];
    switchDescription.data = @"Switch pour déplier";
    switchDescription.on = model.expended;
    switchDescription.updateBlock = ^(id modifiedValue){
        model.expended = [modifiedValue boolValue];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadContent];
        });
    };
    [descriptions addObject:switchDescription];
    
    if (model.expended) {
        JMTextfieldWithTitleFormViewDescription * textfieldTitleDesc = [JMTextfieldWithTitleFormViewDescription new];
        textfieldTitleDesc.title = @"Secret textfield";
        textfieldTitleDesc.placeholder = @"Secret textfield";
        textfieldTitleDesc.data = model.secretValue;
        textfieldTitleDesc.keyboardFormDelegate = self;
        textfieldTitleDesc.updateBlock = ^(id modifiedValue){
            model.secretValue = modifiedValue;
        };
        [descriptions addObject:textfieldTitleDesc];
        
        textfieldTitleDesc = [JMTextfieldWithTitleFormViewDescription new];
        textfieldTitleDesc.title = @"Secret textfield 2";
        textfieldTitleDesc.placeholder = @"Secret textfield 2";
        textfieldTitleDesc.data = model.secretValue2;
        textfieldTitleDesc.keyboardFormDelegate = self;
        textfieldTitleDesc.updateBlock = ^(id modifiedValue){
            model.secretValue2 = modifiedValue;
        };
        [descriptions addObject:textfieldTitleDesc];
    }
    
    switchDescription = [JMTSwitchFormViewDescription new];
    switchDescription.data = @"Mon text de switch un peu plus llong ";
    switchDescription.enable = NO;
    switchDescription.on = model.switch4;
    switchDescription.updateBlock = ^(id modifiedValue){
        model.switch4 = [modifiedValue boolValue];
    };
    [descriptions addObject:switchDescription];
    
    headerDesc = [JMFormSectionHeaderFormViewDescription new];
    headerDesc.title = @"List selection tests title";
    [descriptions addObject:headerDesc];
    
    JMListFormViewDescription *listDesc = [JMListFormViewDescription new];
    listDesc.title = @"Choose a color";
    listDesc.placeholder = @"none";
    listDesc.data = model.selectedColorNAme;
    listDesc.listStyle = JMListFormViewModalChoice;
    listDesc.formViewHeight = 80.0f;
    listDesc.updateBlock = ^(id modifiedValue){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentListChoices:model.coloChoices currentChoice:model.selectedColorNAme withCompletionBlock:^(id modifiedValue) {
                model.selectedColorNAme = modifiedValue;
                [self reloadContent];
            }];
        });
    };
    [descriptions addObject:listDesc];
    
    listDesc = [JMListFormViewDescription new];
    listDesc.title = @"Choose a color (AppleInlinePush)";
    listDesc.choices = model.coloChoices;
    listDesc.placeholder = @"none";
    listDesc.data = model.selectedColorNAme2;
    listDesc.listStyle = JMListFormViewAppleInlinePush;
    listDesc.formViewHeight = 41.0f;
    listDesc.updateBlock = ^(id modifiedValue){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentListChoices:model.coloChoices currentChoice:model.selectedColorNAme2 withCompletionBlock:^(id modifiedValue) {
                model.selectedColorNAme2 = modifiedValue;
                [self reloadContent];
            }];
        });
    };
    [descriptions addObject:listDesc];
    
    headerDesc = [JMFormSectionHeaderFormViewDescription new];
    headerDesc.title = @"TextView tests";
    [descriptions addObject:headerDesc];
    
    JMTextViewFormViewDescription *textDesc = [JMTextViewFormViewDescription new];
    textDesc.placeholder = @"";
    textDesc.data = model.bigText;
    textDesc.keyboardFormDelegate = self;
    textDesc.updateBlock = ^(id modifiedValue){
        model.bigText = modifiedValue;
    };
    [descriptions addObject:textDesc];
    
    textDesc = [JMTextViewFormViewDescription new];
    textDesc.placeholder = @"";
    textDesc.data = model.bigText2;
    textDesc.keyboardFormDelegate = self;
    textDesc.updateBlock = ^(id modifiedValue){
        model.bigText2 = modifiedValue;
    };
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
