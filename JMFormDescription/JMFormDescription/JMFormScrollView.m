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
@property (strong, nonatomic) NSMutableArray *formViews;
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
    _formViews = [NSMutableArray new];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
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

- (void)reloadData
{
    NSAssert(self.formViewDatasource != nil, @"formViewDatasource can't be nil");
    
    if (self.contentView.superview) {
        [self.formViews removeAllObjects];
        [self.contentView removeFromSuperview];
    }
    
    self.contentView = [[UIView alloc] initWithFrame:self.bounds];
    JMFormView *currentFormView;
    
    for (NSInteger i = 0; i < [self.formViewDatasource formScrollView:self numberOfRowsInSection:0]; i++){
        currentFormView = [self.formViewDatasource formScrollView:self formViewForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [currentFormView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:currentFormView];
        [self.formViews addObject:currentFormView];
    }
    
    [self addSubview:self.contentView];
    [self setNeedsUpdateConstraints];
}

- (void)reloadScrollViewWithFormDescription:(NSArray *)descriptions
{
    if (self.contentView.superview) {
        [self.formViews removeAllObjects];
        [self.contentView removeFromSuperview];
    }

    self.contentView = [[UIView alloc] initWithFrame:self.bounds];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;

    JMFormView *currentFormView;
    for (JMFormViewDescription *desc in descriptions) {
        if ([desc.formViewClass isSubclassOfClass:[JMFormView class]]) {
            currentFormView = [desc.formViewClass viewFromNib];
            [currentFormView updateFormViewWithDescription:desc];
            [currentFormView setTranslatesAutoresizingMaskIntoConstraints:NO];
            [self.contentView addSubview:currentFormView];
            [self.formViews addObject:currentFormView];
        }
    }
    
    [self addSubview:self.contentView];
    [self setNeedsUpdateConstraints];
}

/*
- (void)insertFormViewDescription:(JMFormViewDescription *)description afterFormViewAtIndex:(NSInteger)index
{
    JMFormView *formView = [description.formViewClass viewFromNib];
    [formView updateFormViewWithDescription:description];
    [formView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.formViews insertObject:formView atIndex:index];

    [UIView animateWithDuration:0.25 animations:^{
        [self setNeedsUpdateConstraints];
    }];
}
*/

#pragma mark - autolayout addConstraints

- (void)updateConstraints
{
    [super updateConstraints];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.formViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    JMFormView *previousFormView;
    JMFormView *currentFormView;
    
    for (JMFormView *formView in self.formViews) {
        
        previousFormView = currentFormView;
        currentFormView = formView;
        [self.contentView addSubview:currentFormView];

        //Add constraints !!
        [self addConstraintsForPreviousFormView:previousFormView
                                currentFormView:currentFormView
                             defaultHeightSpace:self.formViewSpace];
    }
    
    [self addContentViewConstraints];
}

- (void)addContentViewConstraints
{
    if (nil == self.contentView) {
        return;
    }
        
    id views = @{@"contentView": self.contentView,
                 @"scrollView": self};
    NSDictionary *metrics = @{@"contentViewWidth":@(self.frame.size.width)};
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentView(==scrollView)]|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentView]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
}

- (void)addConstraintsForPreviousFormView:(JMFormView *)previousFormView
                          currentFormView:(JMFormView *)currentFormView
                       defaultHeightSpace:(CGFloat)defaultHeightSpace
{
    //HEIGHT + ALIGN TOP (previous) + LEFT/ RIGHT PARENT
    if (previousFormView) {
        BOOL currentFormViewIsTheLast = [currentFormView isEqual:[self.formViews lastObject]];
        id views = @{@"currentFormView": currentFormView,
                     @"previousFormView": previousFormView};
        NSDictionary *metrics = @{@"currentFormViewHeight":@(currentFormView.formViewHeight),
                                  @"defaultHeightSpace":@(defaultHeightSpace)};
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[currentFormView]|" options:NSLayoutFormatAlignAllBaseline metrics:0 views:views]];
        
        if (NO == currentFormViewIsTheLast) {
            [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[previousFormView]-(defaultHeightSpace)-[currentFormView(currentFormViewHeight)]" options:NSLayoutFormatAlignAllLeft metrics:metrics views:views]];
        } else {
            [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[previousFormView]-(defaultHeightSpace)-[currentFormView(currentFormViewHeight)]|" options:NSLayoutFormatAlignAllLeft metrics:metrics views:views]];
        }
        
    } else {
        BOOL currentFormViewIsTheLast = [currentFormView isEqual:[self.formViews lastObject]];

        id views = @{@"currentFormView": currentFormView};
            NSDictionary *metrics = @{@"currentFormViewHeight":@(currentFormView.formViewHeight),
                                      @"defaultHeightSpace":@(defaultHeightSpace)};
            
            [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[currentFormView]|" options:NSLayoutFormatAlignAllBaseline metrics:0 views:views]];
        
        if (NO == currentFormViewIsTheLast) {
            [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(defaultHeightSpace)-[currentFormView(currentFormViewHeight)]" options:NSLayoutFormatAlignAllLeft metrics:metrics views:views]];
        } else {
            [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(defaultHeightSpace)-[currentFormView(currentFormViewHeight)]|" options:NSLayoutFormatAlignAllLeft metrics:metrics views:views]];
        }
    }
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
