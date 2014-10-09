//
//  JMFormScrollView.m
//  JMFormDescription
//
//  Created by jerome morissard on 04/10/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import "JMFormScrollView.h"
#import "JMFormView.h"

@interface JMFormScrollView ()
@property (strong, nonatomic) UIView *contentView;
@property (assign, nonatomic) CGSize customConstantSize;
@property (nonatomic, assign) UIEdgeInsets initialContentInset;
@property (assign, nonatomic) BOOL keyboardPresented;
@end

@implementation JMFormScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - keyboard

- (void)keyboardWillShow:(NSNotification*)notification
{
    if (self.keyboardPresented == YES) {
        return;
    }
    
    self.initialContentInset = self.contentInset;
    CGSize kbSize = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(self.initialContentInset.top, 0, kbSize.height, 0);
    [self setContentInset:edgeInsets];
    [self setScrollIndicatorInsets:edgeInsets];
    self.keyboardPresented = YES;
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    [self setContentInset:self.initialContentInset];
    [self setScrollIndicatorInsets:self.initialContentInset];
    self.keyboardPresented = NO;
}

#pragma mark - Appearance

- (void)setFormViewSpace:(CGFloat)formViewSpace
{
    _formViewSpace = formViewSpace;
}

#pragma mark - ReloadData

- (void)reloadScrollViewWithFormDescription:(NSArray *)descriptions
{
    //self.backgroundColor = [UIColor redColor];
    
    if (self.contentView.superview) {
        [self.contentView removeFromSuperview];
    }

    self.contentView = [[UIView alloc] initWithFrame:self.bounds];
    //self.contentView.backgroundColor = [UIColor blueColor];
    CGFloat computedHeight = 0.0f;

    JMFormView *previousFormView;
    JMFormView *currentFormView;
    
    for (JMFormViewDescription *desc in descriptions) {
        if ([desc.formViewClass isSubclassOfClass:[JMFormView class]]) {
            previousFormView = currentFormView;
            currentFormView = [desc.formViewClass viewFromNib];
            [currentFormView updateFormViewWithDescription:desc];
            [currentFormView setTranslatesAutoresizingMaskIntoConstraints:NO];
            [self.contentView addSubview:currentFormView];
            
            //Add constraints !!
            [self addConstraintsForPreviousFormView:previousFormView
                                    currentFormView:currentFormView
                             currentFormDescription:desc
                                 defaultHeightSpace:_formViewSpace];
            
            computedHeight = computedHeight + desc.formViewHeight + _formViewSpace;
        }
    }
    
    CGRect contentViewFrame = self.contentView.frame;
    contentViewFrame.origin.y = 0.0f;
    contentViewFrame.origin.x = 0.0f;
    contentViewFrame.size = CGSizeMake(CGRectGetWidth(self.bounds), computedHeight);
    
    self.contentView.frame = contentViewFrame;
    [self addSubview:self.contentView];
    [self setContentSize:self.contentView.frame.size];
    NSLog(@"%@", NSStringFromCGSize(self.contentView.frame.size));
}

#pragma mark - autolayout addConstraints

- (void)addConstraintsForPreviousFormView:(JMFormView *)previousFormView
                          currentFormView:(JMFormView *)currentFormView
                   currentFormDescription:(JMFormViewDescription *)currentFormDescription
                       defaultHeightSpace:(CGFloat)defaultHeightSpace
{
    //HEIGHT + ALIGN TOP (previous) + LEFT/ RIGHT PARENT
    if (previousFormView) {
        id views = @{@"currentFormView": currentFormView,
                     @"previousFormView": previousFormView};
        NSDictionary *metrics = @{@"currentFormViewHeight":@(currentFormDescription.formViewHeight),
                                  @"defaultHeightSpace":@(defaultHeightSpace)};
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0)-[currentFormView]-(0)-|"
                                                                                 options:NSLayoutFormatAlignAllBaseline
                                                                                 metrics:0
                                                                                   views:views]];
        [self.contentView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:[previousFormView]-(defaultHeightSpace)-[currentFormView(currentFormViewHeight)]"
                                                 options:NSLayoutFormatAlignAllLeft
                                                 metrics:metrics
                                                   views:views]];
        
    } else {
        id views = @{@"currentFormView": currentFormView};
        NSDictionary *metrics = @{@"currentFormViewHeight":@(currentFormDescription.formViewHeight),
                                  @"defaultHeightSpace":@(defaultHeightSpace)};
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0)-[currentFormView]-(0)-|"
                                                                                 options:NSLayoutFormatAlignAllBaseline
                                                                                 metrics:0
                                                                                   views:views]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(defaultHeightSpace)-[currentFormView(currentFormViewHeight)]"
                                                                                 options:NSLayoutFormatAlignAllLeft
                                                                                 metrics:metrics
                                                                                   views:views]];
    }
}

- (void)addContentViewConstraintsWithHeight:(CGFloat)height
{
    id views = @{@"contentView": self.contentView};
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[contentView]-|"
                                                                 options:NSLayoutFormatAlignAllBaseline
                                                                 metrics:nil
                                                                   views:views]];
    
    NSDictionary *metrics = @{@"contentViewHeight":@(height)};
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[contentView(contentViewHeight)]"
                                                                 options:NSLayoutFormatAlignAllBaseline
                                                                 metrics:metrics
                                                                   views:views]];
}


#pragma mark -

- (NSInteger)indexForFormView:(JMFormView *)formView
{
    NSArray *subViews = [self.contentView subviews];
    NSInteger formViewIndex = [subViews indexOfObject:formView];
    if (formViewIndex == NSNotFound) {
        return NSNotFound;
    }
    return formViewIndex;
}

- (JMFormView *)nextFirstResponderFormViewFromView:(JMFormView *)formView
{
    NSArray *subViews = [self.contentView subviews];
    NSInteger formViewIndex = [subViews indexOfObject:formView];
    if (formViewIndex == NSNotFound) {
        return nil;
    }
    
    NSArray *otherSubViews = [subViews subarrayWithRange:NSMakeRange(formViewIndex+1, subViews.count-formViewIndex-1)];
    for (JMFormView *formView in otherSubViews) {
        if ([formView formViewCanBecomeResponder]) {
            return formView;
        }
    }
    return nil;
}

- (JMFormView *)previousFirstResponderFormViewFromView:(JMFormView *)formView
{
    NSArray *subViews = [self.contentView subviews];
    NSInteger formViewIndex = [subViews indexOfObject:formView];
    if (formViewIndex == NSNotFound) {
        return nil;
    }
    
    NSArray *otherSubViews = [subViews subarrayWithRange:NSMakeRange(0, formViewIndex)];
    otherSubViews = [[otherSubViews reverseObjectEnumerator] allObjects];
    for (JMFormView *formView in otherSubViews) {
        if ([formView formViewCanBecomeResponder]) {
            return formView;
        }
    }
    return nil;
}

@end
