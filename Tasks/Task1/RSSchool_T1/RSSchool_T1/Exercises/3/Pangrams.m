#import "Pangrams.h"

@implementation Pangrams

// Complete the pangrams function below.
- (BOOL)pangrams:(NSString *)string {
    NSString *alphabet = @"abcdefghijklmnopqrstuvwxyz";
    NSArray *arrayFromAlphabet = [self makeArray:alphabet];
    NSString *newString = [[string lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSArray *arrayFromString = [self makeArray:newString];
    
    for (NSString *letter in arrayFromAlphabet) {
        for (int i = 0; i < arrayFromString.count; i++) {
            if([letter isEqualToString:arrayFromString[i]]) {
                break;
            }
            else if(i == arrayFromString.count - 1) {
                return NO;
            }
        }
    }
    return YES;
}

- (NSArray *) makeArray: (NSString *)string {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < string.length; i++) {
        NSString *character = [NSString stringWithFormat:@"%C", [string characterAtIndex:i]];
        [array addObject:character];
    }
    return array;
}

@end
