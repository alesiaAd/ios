//
//  phoneNumberFormatter.h
//  RSSchool_T4
//
//  Created by Alesia Adereyko on 20/04/2019.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhoneNumber: NSObject
@property (nonatomic, retain) NSString *code;
@property (nonatomic, retain) NSString *rawValue;
@property (nonatomic, retain) NSString *formattedValue;
@property (nonatomic, assign) NSInteger phoneNumberLength;
@end

@interface PhoneNumberFormatter : NSObject

+(PhoneNumber *)formatPhoneNumber:(NSString *)rowValue;

@end
