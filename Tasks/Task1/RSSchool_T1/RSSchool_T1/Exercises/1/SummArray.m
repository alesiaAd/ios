#import "SummArray.h"

@implementation SummArray

// Complete the summArray function below.
- (NSNumber *)summArray:(NSArray *)array {
    float sum = 0.0;
    for (NSNumber *element in array) {
        sum += [element floatValue];
    }
    return @(sum);
}

@end
