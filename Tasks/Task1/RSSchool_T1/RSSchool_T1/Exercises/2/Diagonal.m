#import "Diagonal.h"

@implementation Diagonal

// Complete the diagonalDifference function below.
- (NSNumber *) diagonalDifference:(NSArray *)array {
    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    NSMutableArray *leftDiagonal = [[NSMutableArray alloc] init];
    NSMutableArray *rightDiagonal = [[NSMutableArray alloc] init];
    for (NSString *element in array){
        NSArray *new = [element componentsSeparatedByString:@" "];
        [newArray addObject:new];
    }
    for (int i = 0; i < newArray.count; i++) {
        [leftDiagonal addObject:newArray[i][i]];
        [rightDiagonal addObject:newArray[i][newArray.count - 1 - i]];
    }
    
    [newArray release];
    
    NSInteger sumLeftDiagonal = [self summArray:leftDiagonal];
    NSInteger sumRightDiagonal = [self summArray:rightDiagonal];
    NSNumber *difference = @(labs(sumLeftDiagonal - sumRightDiagonal));
    
    [leftDiagonal release];
    [rightDiagonal release];
    
    return difference;
}

- (NSInteger)summArray:(NSArray *)array {
    NSInteger sum = 0;
    for (NSNumber *element in array) {
        sum += [element intValue];
    }
    return sum;
}

@end
