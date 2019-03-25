#import "Encryption.h"

@implementation Encryption

// Complete the encryption function below.
- (NSString *)encryption:(NSString *)string {
    NSString *stringWithoutSpaces = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSInteger length = stringWithoutSpaces.length;
    float square = sqrtf(length);
    int ceilSquare = (int) ceilf(square);

    NSMutableArray *updatedArray  = [[NSMutableArray alloc] init];
    for (int i = 0; i < stringWithoutSpaces.length; i = i + ceilSquare) {
        NSInteger endRange = i + ceilSquare - 1;
        NSString * rangeString = @"";
        if (endRange < stringWithoutSpaces.length) {
            rangeString = [stringWithoutSpaces substringWithRange:NSMakeRange(i, ceilSquare)];
        }
        else {
            rangeString = [stringWithoutSpaces substringWithRange:NSMakeRange(i, stringWithoutSpaces.length - i)];
        }
        [updatedArray addObject:rangeString];
    }
    
    NSMutableString *updatedString = [NSMutableString string];
    for (int i = 0; i < ceilSquare; i++) {
        for (NSString *string in updatedArray) {
            if (i < string.length) {
                [updatedString appendString:[NSString stringWithFormat:@"%c", [string characterAtIndex:i]]];
            }
        }
        if(i < ceilSquare - 1) {
            [updatedString appendString:@" "];
        }
    }
    [updatedArray release];
    
    return updatedString;
}

@end
