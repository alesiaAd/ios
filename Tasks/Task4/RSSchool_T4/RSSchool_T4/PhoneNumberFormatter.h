//
//  phoneNumberFormatter.h
//  RSSchool_T4
//
//  Created by Alesia Adereyko on 20/04/2019.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhoneNumber: NSObject
@property (nonatomic, retain) NSString *code;
@property (nonatomic, retain) NSString *rowValue;
@property (nonatomic, retain) NSString *formattedValue;
@end

@interface PhoneNumberFormatter : NSObject
+(PhoneNumber *)formatPhoneNumber:(NSString *)rowValue;
@end

NS_ASSUME_NONNULL_END
