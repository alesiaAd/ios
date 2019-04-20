//
//  ViewController.m
//  RSSchool_T4
//
//  Created by Alesia Adereyko on 19/04/2019.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>
@property (nonatomic, retain) UITextField *phoneTextField;
@property (nonatomic, retain) UIImageView *flagView;
@property (nonatomic, retain) NSDictionary *phoneData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.phoneData = @{@"7": @{@"country": @[@"KZ", @"RU"], @"phone number length": @(10)},
                       @"373": @{@"country": @"MD", @"phone number length": @(8)},
                       @"374": @{@"country": @"AM", @"phone number length": @(8)},
                       @"375": @{@"country": @"BY", @"phone number length": @(9)},
                       @"380": @{@"country": @"UA", @"phone number length": @(9)},
                       @"992": @{@"country": @"TJ", @"phone number length": @(9)},
                       @"993": @{@"country": @"TM", @"phone number length": @(8)},
                       @"994": @{@"country": @"AZ", @"phone number length": @(9)},
                       @"996": @{@"country": @"KG", @"phone number length": @(9)},
                       @"998": @{@"country": @"UZ", @"phone number length": @(9)},
                       };
    
    self.phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 200, 300, 50)];
    self.phoneTextField.delegate = self;
    CGPoint newCenter = self.phoneTextField.center;
    newCenter.x = self.view.center.x;
    self.phoneTextField.center = newCenter;
    self.phoneTextField.layer.borderWidth = 2.f;
    self.phoneTextField.layer.borderColor = [UIColor blackColor].CGColor;
    self.phoneTextField.layer.cornerRadius = 20;
    self.phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    self.flagView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 40, 40)];
    [leftView addSubview:self.flagView];
    self.phoneTextField.leftView = leftView;
    self.phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:self.phoneTextField];
    
}

// TextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"string - %@", string);
    NSString * stringToCheck = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSString *newString = [stringToCheck substringFromIndex:1];
    if(stringToCheck.length == 1) {
        if(![stringToCheck isEqualToString:@"+"]) {
            if([self checkIsNumber:stringToCheck]) {
                textField.text = @"+";
            }
            else {
                return NO;
            }
        }
    }
    else {
        if(![self checkIsNumber:string]) {
            return NO;
        }
        else if([newString isEqualToString:@"7"]) {
            return YES;
        }
        else {
            [self setImageFromCode:newString];
        }
    }
    return YES;
}

-(BOOL)checkIsNumber:(NSString *)string {
    NSCharacterSet* notDigits =
    [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    if ([string rangeOfCharacterFromSet:notDigits].location == NSNotFound){
        return YES;
    }
    return NO;
}

-(void)setImageFromCode:(NSString *) string {
    NSDictionary *data = [self.phoneData valueForKey:string];
    if([string hasPrefix:@"7"]) {
        data = [self.phoneData valueForKey:@"7"];
    }
    NSString *country = [[NSString alloc] init];
    if(data) {
        if([string hasPrefix:@"7"]) {
            if([string hasPrefix:@"77"]) {
              country = [data valueForKey:@"country"][0];
            }
            else {
                country = [data valueForKey:@"country"][1];
            }
        }
        else {
            country = [data valueForKey:@"country"];
            //return [data valueForKey:@"phone number length"];
        }
        [self.flagView setImage:[UIImage imageNamed:[@"flag_" stringByAppendingString:country]]];
    }
    else {
        //self.flagView.image = nil;
    }
    //return nil;
}

-(NSString *)formatPhoneNumberWithLength8:(NSString *)string withCode:(NSString *)code{
    NSMutableString *formattedPhoneNumber = [string mutableCopy];
    if(string.length == code.length + 1) {
        formattedPhoneNumber = [NSMutableString stringWithFormat:@"%@ (%hu", code, [string characterAtIndex:string.length - 1]];
    }
    else if(string.length == code.length + 4) {
        [formattedPhoneNumber appendString:@") "];
    }
    else if(string.length == code.length + 10) {
        [formattedPhoneNumber insertString:@"-" atIndex:string.length - 2];
    }
    return formattedPhoneNumber;
}

@end
