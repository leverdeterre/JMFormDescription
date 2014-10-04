##JMFormDescription

JMFormDescription is an Objective-C library for easily creating forms on iOS. 


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
-----------------------
* JMFormSectionHeaderFormView (to simulate a section header),
* JMTextfieldFormView,
* JMTextfieldWithTitleFormView,
* JMSwitchFormView,
* JMButtonFormView,
* JMListFormView,
* JMTextViewFormView

![Image](./screenshots/merged_demos.png)
