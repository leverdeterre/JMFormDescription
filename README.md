##JMFormDescription

JMFormDescription is an Objective-C library for easily creating forms on iOS. 

![Image](./screenshots/merged_demos.png)

###Creating a form element (formView)

To create a form object

```objc
    JMTextfieldFormViewDescription *textfieldDesc  = [JMTextfieldFormViewDescription new];
    textfieldDesc.placeholder = @"Mon placeholder";
    textfieldDesc.data = model.textfieldText1;
    textfieldDesc.formDelegate = self;
    textfieldDesc.modelKey = @"textfieldText1";
```

### Supported formViews

* JMFormSectionHeaderFormView (to simulate a section header),
* JMTextfieldFormView,
* JMTextfieldWithTitleFormView,
* JMSwitchFormView,
* JMButtonFormView,
* JMListFormView,
* JMTextViewFormView.

### Delegation (JMFormDelegate)

```objc
- (void)textUpdatedFromFormView:(JMTextfieldFormView *)formView textfield:(UITextField *)textfield toText:(NSString *)text;
- (void)textUpdatedFromFormView:(JMTextViewFormView *)formView textView:(UITextView *)textView toText:(NSString *)text;
- (void)switchChangedFromFormView:(JMSwitchFormView *)formView toValue:(BOOL)value;
- (void)buttonPressedFromFormView:(JMButtonFormView *)formView withTitleValue:(NSString *)value;
- (void)listPressedFromFormView:(JMListFormView *)formView withSelectedValue:(NSString *)value;
- (void)selectedChoice:(NSString *)choice forModelKey:(NSString *)modelKey;
- (void)scrollToFormView:(JMFormView *)formView;
```

### Todo
* Support UIAppearance protocol,
* Add PickerFormView, 
* Add DatePickerFormView,
* Keyboard type,
* Textfield Regex to validate input.


