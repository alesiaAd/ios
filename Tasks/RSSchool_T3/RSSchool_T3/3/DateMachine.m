#import "DateMachine.h"

@interface DateMachine() <UITextFieldDelegate>
@property (nonatomic, retain) UILabel *dateLabel;
@property (nonatomic, retain) UITextField *dateField;
@property (nonatomic, retain) UITextField *stepField;
@property (nonatomic, retain) UITextField *dateUnitField;
@end

@implementation DateMachine
- (void)viewDidLoad {
  [super viewDidLoad];
    // have fun
    //oh yeah, I had thanks:)
    self.dateLabel = [[[UILabel alloc] init] autorelease];
    [self.dateLabel sizeToFit];
    self.dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.dateLabel];
    [self.dateLabel.heightAnchor constraintEqualToConstant:50];
    [self.dateLabel.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:20].active = YES;
    [self.dateLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm"];
    NSString *currentDate = [dateFormatter stringFromDate:[NSDate date]];
    self.dateLabel.text = currentDate;
    
    self.dateField = [[[UITextField alloc] init] autorelease];
    self.dateField.delegate = self;
    self.dateField.textAlignment = NSTextAlignmentCenter;
    self.dateField.placeholder = @"Start date";
    self.dateField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.dateField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.dateField];
    [self.dateField.widthAnchor constraintGreaterThanOrEqualToConstant:200].active = YES;
    [self.dateField.heightAnchor constraintEqualToAnchor:self.dateLabel.heightAnchor].active = YES;
    [self.dateField.topAnchor constraintEqualToAnchor:self.dateLabel.bottomAnchor constant:20].active = YES;
    [self.dateField.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    
    self.stepField =[[[UITextField alloc] init] autorelease];
    self.stepField.delegate = self;
    self.stepField.textAlignment = NSTextAlignmentCenter;
    self.stepField.placeholder = @"Step";
    self.stepField.keyboardType = UIKeyboardTypeNumberPad;
    self.stepField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.stepField];
    [self.stepField.widthAnchor constraintGreaterThanOrEqualToConstant:200].active = YES;
    [self.stepField.heightAnchor constraintEqualToAnchor:self.dateField.heightAnchor].active = YES;
    [self.stepField.topAnchor constraintEqualToAnchor:self.dateField.bottomAnchor constant:20].active = YES;
    [self.stepField.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    
    self.dateUnitField =[[[UITextField alloc] init] autorelease];
    self.dateUnitField.delegate = self;
    self.dateUnitField.textAlignment = NSTextAlignmentCenter;
    self.dateUnitField.placeholder = @"Date unit";
    self.dateUnitField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.dateUnitField];
    [self.dateUnitField.widthAnchor constraintGreaterThanOrEqualToConstant:200].active = YES;
    [self.dateUnitField.heightAnchor constraintEqualToAnchor:self.dateField.heightAnchor].active = YES;
    [self.dateUnitField.topAnchor constraintEqualToAnchor:self.stepField.bottomAnchor constant:20].active = YES;
    [self.dateUnitField.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    
    UIButton *addButton = [[UIButton alloc] init];
    [addButton setTitle:@"Add" forState:UIControlStateNormal];
    addButton.backgroundColor = [UIColor greenColor];
    addButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:addButton];
    [addButton.heightAnchor constraintEqualToAnchor:self.dateField.heightAnchor].active = YES;
    [addButton.widthAnchor constraintEqualToConstant:100].active = YES;
    [addButton.topAnchor constraintEqualToAnchor:self.dateUnitField.bottomAnchor constant:20].active = YES;
    [addButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = YES;
    [addButton addTarget:self action:@selector(addButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *subButton = [[UIButton alloc] init];
    [subButton setTitle:@"Sub" forState:UIControlStateNormal];
    subButton.backgroundColor = [UIColor greenColor];
    subButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:subButton];
    [subButton.heightAnchor constraintEqualToAnchor:self.dateField.heightAnchor].active = YES;
    [subButton.widthAnchor constraintEqualToAnchor:addButton.widthAnchor].active = YES;
    [subButton.topAnchor constraintEqualToAnchor:self.dateUnitField.bottomAnchor constant:20].active = YES;
    [subButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20].active = YES;
    [subButton addTarget:self action:@selector(subButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)addButtonClicked:(UIButton *)sender {
    if([self checkFieldsNotEmpty]) {
        [self changeDate:[self.stepField.text integerValue]];
    }
}

-(void)subButtonClicked:(UIButton *)sender {
    if([self checkFieldsNotEmpty]) {
        [self changeDate:-[self.stepField.text integerValue]];
    }
}

-(void)changeDate: (NSInteger)stepInt {
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm"];
    dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDate *date = [dateFormatter dateFromString:self.dateLabel.text];
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    NSString *lowerCaseDateUnit = [self.dateUnitField.text lowercaseString];
    if([lowerCaseDateUnit isEqualToString:@"year"]) {
        dayComponent.year = stepInt;
    }
    else if([lowerCaseDateUnit isEqualToString:@"month"]) {
        dayComponent.month = stepInt;
    }
    else if([lowerCaseDateUnit isEqualToString:@"week"]) {
        dayComponent.weekOfYear = stepInt;
    }
    else if([lowerCaseDateUnit isEqualToString:@"day"]) {
        dayComponent.day = stepInt;
    }
    else if([lowerCaseDateUnit isEqualToString:@"hour"]) {
        dayComponent.hour = stepInt;
    }
    else if([lowerCaseDateUnit isEqualToString:@"minute"]) {
        dayComponent.minute = stepInt;
    }
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    NSDate *newDate = [theCalendar dateByAddingComponents:dayComponent toDate:date options:0];
    [dayComponent release];
    
    self.dateLabel.text = [dateFormatter stringFromDate:newDate];
}

-(BOOL)checkFieldsNotEmpty {
    if (self.stepField.text.length == 0) {
        [self sendAlert:@"Please enter step field."];
        return NO;
    }
    else if (self.dateUnitField.text.length == 0) {
        [self sendAlert:@"Please enter date unit field."];
        return NO;
    }
    return YES;
}

-(void)sendAlert:(NSString *) message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

//TextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self checkTextFields:textField];
    return NO;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self checkTextFields:textField];
}

-(void)checkTextFields:(UITextField *)textField {
    if ([textField.text isEqualToString: @""]) {
        return;
    }
    if(textField == self.dateField) {
        if([self checkIsDate:textField.text]) {
            self.dateLabel.text = textField.text;
        }
        else {
            [self sendAlert:@"Check the date you entered. Date should be in format dd/MM/YYYY HH:mm"];
            textField.text = nil;
        }
    }
    else if(textField == self.stepField) {
        if(![self checkIsNumber:textField.text]) {
            [self sendAlert:@"Check step you entered. It should be a number."];
            textField.text = nil;
        }
    }
    else if (textField == self.dateUnitField) {
        if (![self checkIsDateUnit:textField.text]) {
            [self sendAlert:@"Check Date unit you entered. It should only allow these values: year, month, week, day, hour, minute."];
            textField.text = nil;
        }
    }
}

-(BOOL)checkIsDate:(NSString *)string {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm"];
    if ([dateFormatter dateFromString:string]) {
        [dateFormatter release];
        return YES;
    }
    [dateFormatter release];
    return NO;
}

-(BOOL)checkIsNumber:(NSString *)string {
    NSCharacterSet* notDigits =
    [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    if ([string rangeOfCharacterFromSet:notDigits].location == NSNotFound){
        return YES;
    }
    return NO;
}

-(BOOL)checkIsDateUnit:(NSString *)string {
    NSString *lowerCaseString = [string lowercaseString];
    NSArray *array = @[@"year", @"month", @"week", @"day", @"hour", @"minute"];
    for (NSString *element in array) {
        if ([lowerCaseString isEqualToString:element]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString * stringToCheck = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField == self.dateField) {
        if([self checkIsDate:stringToCheck]) {
            self.dateLabel.text = stringToCheck;
        }
    } else if (textField == self.dateUnitField) {
        if ([stringToCheck isEqual:@""]) {
            return YES;
        }
        NSArray *array = @[@"year", @"month", @"week", @"day", @"hour", @"minute"];
        BOOL isSubstringOfUnit = NO;
        for (NSString * unit in array) {
            if ([unit rangeOfString:stringToCheck.lowercaseString].location != NSNotFound) {
                isSubstringOfUnit = YES;
                break;
            }
        }
        return isSubstringOfUnit;
    }
    return YES;
}

-(void)dealloc {
    self.dateLabel = nil;
    self.dateField = nil;
    self.stepField = nil;
    self.dateUnitField = nil;
    [super dealloc];
}

@end
