#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) UILabel *labelResultColor;
@property (weak, nonatomic) UILabel *labelRed;
@property (weak, nonatomic) UILabel *labelGreen;
@property (weak, nonatomic) UILabel *labelBlue;
@property (weak, nonatomic) UIView *viewResultColor;
@property (weak, nonatomic) UITextField *textFieldRed;
@property (weak, nonatomic) UITextField *textFieldGreen;
@property (weak, nonatomic) UITextField *textFieldBlue;
@property (weak, nonatomic) UIButton *buttonProcess;

// Constraints
@property (weak, nonatomic) NSLayoutConstraint *topContraint;
@property (weak, nonatomic) NSLayoutConstraint *bottomContraint;

@end

// MARK: - Keyboard category
@interface ViewController (KeyboardHandling)
- (void)subscribeOnKeyboardEvents;
- (void)updateTopContraintWith:(CGFloat) constant andBottom:(CGFloat) bottomConstant;
- (void)hideWhenTappedAround;
@end

@implementation ViewController

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat height = self.view.bounds.size.height;
    CGFloat width = self.view.bounds.size.width;
    
    // create labelResultColor
    self.labelResultColor = [[UILabel alloc] initWithFrame:CGRectMake(width / 15, height / 9.5, width / 2, height / 25)];
    self.labelResultColor.textColor = [UIColor blackColor];
    self.labelResultColor.text = @"Color";
    [self.view addSubview:self.labelResultColor];
    
    // create labelRed
    self.labelRed = [[UILabel alloc] initWithFrame:CGRectMake(width / 15, height / 9.5 * 1.8, width / 5, height / 25)];
    self.labelRed.textColor = [UIColor blackColor];
    self.labelRed.text = @"RED";
    [self.view addSubview:self.labelRed];
    
    // create labelGreen
    self.labelGreen = [[UILabel alloc] initWithFrame:CGRectMake(width / 15, height / 9.5 * 2.6, width / 5, height / 25)];
    self.labelGreen.textColor = [UIColor blackColor];
    self.labelGreen.text = @"GREEN";
    [self.view addSubview:self.labelGreen];
    
    // create labelBlue
    self.labelBlue = [[UILabel alloc] initWithFrame:CGRectMake(width / 15, height / 9.5 * 3.4, width / 5, height / 25)];
    self.labelBlue.textColor = [UIColor blackColor];
    self.labelBlue.text = @"BLUE";
    [self.view addSubview:self.labelBlue];
    
    // create viewResultColor
    self.viewResultColor = [[UIView alloc] initWithFrame:CGRectMake(width / 2.5, height / 9.5, (width / 2) - (width / 15), height / 25)];
    self.viewResultColor.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.viewResultColor];
    
    // create textFieldRed
    self.textFieldRed = [[UITextField alloc] initWithFrame:CGRectMake(width / 3, height / 9.5 * 1.8, width / 2 , height / 25)];
    self.textFieldRed.layer.borderColor = UIColor.lightGrayColor.CGColor;
    self.textFieldRed.layer.borderWidth = 1.0;
    self.textFieldRed.layer.cornerRadius = 5.0;
    self.textFieldRed.placeholder = @"0..255";
    self.textFieldRed.textColor = [UIColor lightGrayColor];
    [self.view addSubview:self.textFieldRed];
    
    // create textFieldGreen
    self.textFieldGreen = [[UITextField alloc] initWithFrame:CGRectMake(width / 3, height / 9.5 * 2.6, width / 2, height / 25)];
    self.textFieldGreen.layer.borderColor = UIColor.lightGrayColor.CGColor;
    self.textFieldGreen.layer.borderWidth = 1.0;
    self.textFieldGreen.layer.cornerRadius = 5.0;
    self.textFieldGreen.placeholder = @"0..255";
    [self.view addSubview:self.textFieldGreen];
    
    // create textFieldBlue
    self.textFieldBlue = [[UITextField alloc] initWithFrame:CGRectMake(width / 3, height / 9.5 * 3.4, width / 2, height / 25)];
    self.textFieldBlue.layer.borderColor = UIColor.lightGrayColor.CGColor;
    self.textFieldBlue.layer.borderWidth = 1.0;
    self.textFieldBlue.layer.cornerRadius = 5.0;
    self.textFieldBlue.placeholder = @"0..255";
    [self.view addSubview:self.textFieldBlue];
    
    // create buttonProcess
    self.buttonProcess = [[UIButton alloc] initWithFrame:CGRectMake(width / 2.5, height / 10 * (1.85 + 3 * 0.85), width / 5, height / 25)];
    [self.buttonProcess addTarget:self
                           action:@selector(buttonPressed:)
    forControlEvents:UIControlEventTouchUpInside];
    [self.buttonProcess setTitle:@"Process" forState:UIControlStateNormal];
    [self.buttonProcess setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.buttonProcess setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.view addSubview:self.buttonProcess];
    
    self.view.accessibilityIdentifier = @"mainView";
    self.textFieldRed.accessibilityIdentifier = @"textFieldRed";
    self.textFieldGreen.accessibilityIdentifier = @"textFieldGreen";
    self.textFieldBlue.accessibilityIdentifier = @"textFieldBlue";
    self.buttonProcess.accessibilityIdentifier = @"buttonProcess";
    self.labelRed.accessibilityIdentifier = @"labelRed";
    self.labelGreen.accessibilityIdentifier = @"labelGreen";
    self.labelBlue.accessibilityIdentifier = @"labelBlue";
    self.labelResultColor.accessibilityIdentifier = @"labelResultColor";
    self.viewResultColor.accessibilityIdentifier = @"viewResultColor";
    
    // Subscrube on keyboard events
    [self subscribeOnKeyboardEvents];
    [self hideWhenTappedAround];

    // Set delegates
    self.textFieldRed.delegate = self;
    self.textFieldGreen.delegate = self;
    self.textFieldBlue.delegate = self;
}

- (void)buttonPressed:(UIButton *)sender {
     self.labelResultColor.text = @"Color";
    
    NSInteger red = self.textFieldRed.text.intValue;
    NSInteger green = self.textFieldGreen.text.intValue;
    NSInteger blue = self.textFieldBlue.text.intValue;
    
    if (red > 255 || red < 0 || green > 255 || green < 0 || blue > 255 || blue < 0 || [self.textFieldRed.text isEqual: @""] || [self.textFieldGreen.text isEqual: @""] || [self.textFieldBlue.text isEqual: @""] || (![ViewController number:self.textFieldRed.text]) || (![ViewController number:self.textFieldGreen.text]) || (![ViewController number:self.textFieldBlue.text]) ) {
        self.labelResultColor.text = @"Error";
    } else {
    UIColor *colorToBeShow = [[UIColor alloc] initWithRed:(CGFloat)red/255 green:(CGFloat)green/255 blue:(CGFloat)blue/255 alpha:1.0];
    const CGFloat *component = CGColorGetComponents(colorToBeShow.CGColor);
    CGFloat redCGFloat = component[0];
    CGFloat greenCGFloat = component[1];
    CGFloat blueCGFloat = component[2];
    self.viewResultColor.backgroundColor = colorToBeShow;
    NSString *stringHexColor = [[NSString alloc] initWithFormat:@"0x%02X%02X%02X", (int)(redCGFloat*255), (int)(greenCGFloat*255), (int)(blueCGFloat*255)];
    self.labelResultColor.text = stringHexColor;
    self.textFieldRed.text = @"";
    self.textFieldGreen.text = @"";
    self.textFieldBlue.text = @"";
    }
    
    [self.textFieldRed resignFirstResponder];
    [self.textFieldGreen resignFirstResponder];
    [self.textFieldBlue resignFirstResponder];
}

// MARK: - Delegates

// TextField
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.textFieldRed) {
        return [self.textFieldRed becomeFirstResponder];
    } else if (textField == self.textFieldGreen) {
        return [self.textFieldGreen becomeFirstResponder];
    } else {
        return [self.textFieldBlue becomeFirstResponder];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)sender {
    self.labelResultColor.text = @"Color";
}

@end

// MARK: - Keyboard category

@implementation ViewController (KeyboardHandling)

- (void)subscribeOnKeyboardEvents {
    // Keyboard will show
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(keybaordWillShow:)
                                               name:UIKeyboardWillShowNotification
                                             object:nil];
    // Keyboard will hide
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(keybaordWillHide:)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];
}

- (void)hideWhenTappedAround {
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(hide)];
    [self.view addGestureRecognizer:gesture];
}

- (void)hide {
    [self.view endEditing:true];
}

- (void)keybaordWillShow:(NSNotification *)notification {
    CGRect rect = [(NSValue *)notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

    [self updateTopContraintWith:15.0 andBottom:rect.size.height - self.view.safeAreaInsets.bottom + 15.0];
}

- (void)keybaordWillHide:(NSNotification *)notification {
    [self updateTopContraintWith:200.0 andBottom:0.0];
}

- (void)updateTopContraintWith:(CGFloat) constant andBottom:(CGFloat) bottomConstant {
    // Change your constraint constants
    self.topContraint.constant = constant;
    self.bottomContraint.constant = bottomConstant;
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

+(BOOL)number:(NSString *)text {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *number = [formatter numberFromString:text];
    return number;
}

@end
