//
//  phoneNumberFormatter.m
//  RSSchool_T4
//
//  Created by Alesia Adereyko on 20/04/2019.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import "PhoneNumberFormatter.h"

@implementation PhoneNumber

-(void)dealloc {
    self.rawValue = nil;
    self.code = nil;
    self.formattedValue = nil;
    [super dealloc];
}

@end

@implementation PhoneNumberFormatter

+ (NSDictionary *)phoneNumberLength {
    return @{@"7": @(10),
             @"373": @(8),
             @"374": @(8),
             @"375": @(9),
             @"380": @(9),
             @"992": @(9),
             @"993": @(8),
             @"994": @(9),
             @"996": @(9),
             @"998": @(9)
             };
}

+(PhoneNumber *)formatPhoneNumber:(NSString *)rawValue {
    PhoneNumber *phoneNumber = [[PhoneNumber new] autorelease];
    phoneNumber.rawValue = rawValue;
    NSString *pureNumbers = [[rawValue componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
    NSMutableString *formattedString = [pureNumbers mutableCopy];
    if(![[formattedString substringWithRange:NSMakeRange(0, 1)] isEqual:@"+"]) {
        [formattedString insertString:@"+" atIndex:0];
    }
    for(NSString *key in self.phoneNumberLength) {
        if([pureNumbers hasPrefix:key]) {            
            phoneNumber.phoneNumberLength = [[[PhoneNumberFormatter phoneNumberLength] valueForKey:key] integerValue];
            phoneNumber.code = key;
            break;
        }
    }
    
    if(phoneNumber.code) {
        if((int)phoneNumber.phoneNumberLength == 8 || (int)phoneNumber.phoneNumberLength == 9) {
            if(pureNumbers.length == phoneNumber.code.length + 1) {
                [formattedString insertString:@" (" atIndex:phoneNumber.code.length + 1];
            }
            else if(pureNumbers.length >= phoneNumber.code.length + 2 && pureNumbers.length <= phoneNumber.code.length + 5) {
                [formattedString insertString:@" (" atIndex:phoneNumber.code.length + 1];
                [formattedString insertString:@") " atIndex:phoneNumber.code.length + 5];
            }
            else if(pureNumbers.length > phoneNumber.code.length + 5 && pureNumbers.length <= phoneNumber.code.length + 7) {
                [formattedString insertString:@" (" atIndex:phoneNumber.code.length + 1];
                [formattedString insertString:@") " atIndex:phoneNumber.code.length + 5];
                [formattedString insertString:@"-" atIndex:phoneNumber.code.length + 10];

            }
            if((int)phoneNumber.phoneNumberLength == 8) {
                if(pureNumbers.length == phoneNumber.code.length + 8) {
                    [formattedString insertString:@" (" atIndex:phoneNumber.code.length + 1];
                    [formattedString insertString:@") " atIndex:phoneNumber.code.length + 5];
                    [formattedString insertString:@"-" atIndex:phoneNumber.code.length + 10];
                }
            }
            else if((int)phoneNumber.phoneNumberLength == 9) {
                if(pureNumbers.length >= phoneNumber.code.length + 8) {
                    [formattedString insertString:@" (" atIndex:phoneNumber.code.length + 1];
                    [formattedString insertString:@") " atIndex:phoneNumber.code.length + 5];
                    [formattedString insertString:@"-" atIndex:phoneNumber.code.length + 10];
                    [formattedString insertString:@"-" atIndex:phoneNumber.code.length + 13];
                }
            }

        }
        else if((int)phoneNumber.phoneNumberLength == 10) {
            if(pureNumbers.length > phoneNumber.code.length && pureNumbers.length < phoneNumber.code.length + 3) {
                [formattedString insertString:@" (" atIndex:phoneNumber.code.length + 1];
            }
            else if(pureNumbers.length >= phoneNumber.code.length + 3 && pureNumbers.length <= phoneNumber.code.length + 6) {
                [formattedString insertString:@" (" atIndex:phoneNumber.code.length + 1];
                [formattedString insertString:@") " atIndex:phoneNumber.code.length + 6];
            }
            else if(pureNumbers.length > phoneNumber.code.length + 6 && pureNumbers.length <= phoneNumber.code.length + 8) {
                [formattedString insertString:@" (" atIndex:phoneNumber.code.length + 1];
                [formattedString insertString:@") " atIndex:phoneNumber.code.length + 6];
                [formattedString insertString:@" " atIndex:phoneNumber.code.length + 11];
            }
            else if(pureNumbers.length > phoneNumber.code.length + 8) {
                [formattedString insertString:@" (" atIndex:phoneNumber.code.length + 1];
                [formattedString insertString:@") " atIndex:phoneNumber.code.length + 6];
                [formattedString insertString:@" " atIndex:phoneNumber.code.length + 11];
                [formattedString insertString:@" " atIndex:phoneNumber.code.length + 14];
            }
        }
    }
    phoneNumber.formattedValue = formattedString;
    [formattedString release];
    return phoneNumber;
}

@end
