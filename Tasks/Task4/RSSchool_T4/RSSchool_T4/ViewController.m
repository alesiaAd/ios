//
//  ViewController.m
//  RSSchool_T4
//
//  Created by Alesia Adereyko on 19/04/2019.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import "ViewController.h"
#import "PhoneNumberFormatter.h"

@interface ViewController () <UITextFieldDelegate>
@property (nonatomic, retain) UITextField *phoneTextField;
@property (nonatomic, retain) UIImageView *flagView;
@end

@implementation ViewController

+ (NSDictionary *)phoneNumberCountry {
    return @{@"7": @[@"KZ", @"RU"],
             @"373": @"MD",
             @"374": @"AM",
             @"375": @"BY",
             @"380": @"UA",
             @"992": @"TJ",
             @"993": @"TM",
             @"994": @"AZ",
             @"996": @"KG",
             @"998": @"UZ"
             };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.phoneTextField = [[[UITextField alloc] initWithFrame:CGRectMake(0, 200, 300, 50)] autorelease];
    self.phoneTextField.delegate = self;
    CGPoint newCenter = self.phoneTextField.center;
    newCenter.x = self.view.center.x;
    self.phoneTextField.center = newCenter;
    self.phoneTextField.layer.borderWidth = 2.f;
    self.phoneTextField.layer.borderColor = [UIColor blackColor].CGColor;
    self.phoneTextField.layer.cornerRadius = 20;
    self.phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    self.flagView = [[[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 40, 40)] autorelease];
    [leftView addSubview:self.flagView];    
    self.phoneTextField.leftView = leftView;
    self.phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    [leftView release];
    
    [self.view addSubview:self.phoneTextField];
    
}

// TextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString * stringToCheck = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSString *pureNumbers = [[stringToCheck componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
    if(stringToCheck.length == 1) {
        if([stringToCheck isEqualToString:@"+"]) {
            return YES;
        }
    }
    //to delete "+"
    if(stringToCheck.length ==0) {
        textField.text = @"";
        return NO;
    }
    //to delete ")"
    if(range.length > 0 && [[stringToCheck substringFromIndex:stringToCheck.length - 1] isEqualToString:@")"]) {
        textField.text = [stringToCheck substringToIndex:stringToCheck.length - 2];
        return NO;
    }
    PhoneNumber *phoneNumber = [PhoneNumberFormatter formatPhoneNumber:stringToCheck];
    if(pureNumbers.length > 12 || (phoneNumber.code && (((int)pureNumbers.length - (int)phoneNumber.code.length) > (int)phoneNumber.phoneNumberLength))) {
        return NO;
    }
    if(![self checkIsNumber:string]) {
        return NO;
    }
    textField.text = phoneNumber.formattedValue;
    if([pureNumbers isEqualToString:@"7"]) {
        self.flagView.image = nil;
        return NO;
    }
    else if([pureNumbers hasPrefix:@"77"]) {
        [self setImageFromCode:@"77"];
        return NO;
    }
    else {
        if(phoneNumber.code) {
           [self setImageFromCode:phoneNumber.code];
        }
        else {
            self.flagView.image = nil;
        }
    }
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

-(void)setImageFromCode:(NSString *) code {
    NSDictionary *phoneNumberDictionary = [ViewController phoneNumberCountry];
    if([code hasPrefix:@"7"]) {
        if([code hasPrefix:@"77"]) {
            [self.flagView setImage:[UIImage imageNamed:[@"flag_" stringByAppendingString:[phoneNumberDictionary valueForKey:@"7"][0]]]];
        }
        else {
            [self.flagView setImage:[UIImage imageNamed:[@"flag_" stringByAppendingString:[phoneNumberDictionary valueForKey:code][1]]]];
        }
    }
    else {
        [self.flagView setImage:[UIImage imageNamed:[@"flag_" stringByAppendingString:[phoneNumberDictionary valueForKey:code]]]];
    }
}

-(void)dealloc {
    self.phoneTextField = nil;
    self.flagView = nil;
    [super dealloc];
}


@end
