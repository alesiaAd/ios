#import "ArrayPrint.h"

@implementation NSArray (RSSchool_Extension_Name)

- (NSString *)print {
    NSMutableString *string = [[[NSMutableString alloc] init] autorelease];
    [string appendString:[self parseArray:self]];
    return string;
}

-(NSString *)parseArray: (NSArray *) array {
    NSMutableString *string = [[[NSMutableString alloc] init] autorelease];
    [string appendString:@"["];
    for (id element in array) {
        if ([element isKindOfClass:[NSArray class]]) {
            [string appendString:[self parseArray:element]];
            if ([array indexOfObject:element] < array.count - 1) {
                [string appendString:@","];
            }
        }
        else if ([element isKindOfClass:[NSNumber class]]) {
            [string appendString:[NSString stringWithFormat:@"%@", [element description]]];
            if ([array indexOfObject:element] < array.count - 1) {
                [string appendString:@","];
            }
        }
        else if ([element isKindOfClass:[NSNull class]]) {
            [string appendString:@"null"];
            if ([array indexOfObject:element] < array.count - 1) {
                [string appendString:@","];
            }
        }
        else if ([element isKindOfClass:[NSString class]]) {
            [string appendString:@"\""];
            [string appendString:[element description]];
            [string appendString:@"\""];
            if ([array indexOfObject:element] < array.count - 1) {
                [string appendString:@","];
            }
        }
        else {
            [string appendString:@"unsupported"];
            if ([array indexOfObject:element] < array.count - 1) {
                [string appendString:@","];
            }
        }
    }
    [string appendString:@"]"];
    return string;
}

@end
