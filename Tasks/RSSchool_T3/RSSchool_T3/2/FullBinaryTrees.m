#import "FullBinaryTrees.h"
// good luck

@implementation FullBinaryTrees

- (NSString *)stringForNodeCount:(NSInteger)count {
    if (count % 2 == 0) {
        return @"[]";
    }
    if (count == 1) {
        return @"[[0]]";
    }
    
    NSMutableString *string = [[[NSMutableString alloc] init] autorelease];
    NSMutableArray *binaryTreeArray = [NSMutableArray arrayWithArray:[self makeCombinationsArray:count combinationsCount:8]];
    for(NSMutableArray *element in binaryTreeArray) {
        [element insertObjects:@[@(0), @(0), @(0)] atIndexes:[NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 3)]];
        for(int i = (int)element.count - 1; i > 0; i--) {
            if([element[i] isEqual:@"null"]) {
                [element removeObjectAtIndex:i];
            }
            else {
                break;
            }
        }
        [string appendString:@"["];
        [string appendString:[element componentsJoinedByString:@","]];
        [string appendString:@"]"];
        
    }
    return string;
}


-(NSArray *)makeCombinationsArray: (NSInteger) count combinationsCount: (NSUInteger) combinationsCount {
    NSArray *nullArray = @[@"null", @"null"];
    NSArray *zeroArray = @[@(0), @(0)];
    NSMutableArray *combinationsArray = [NSMutableArray arrayWithArray:[self allPossibleCombinations:[NSMutableArray arrayWithObjects:zeroArray, nullArray, nil] count:combinationsCount]];
    NSMutableArray *newArray = [[[NSMutableArray alloc] init] autorelease];
    for(NSMutableArray *element in combinationsArray) {
        element = [NSMutableArray arrayWithArray:[self flattenArrays:element]];
        if([self isSuit:element withCount:count - 3]) {
                if([self shouldContinue:count - 3 withArray:element]) {
                    NSInteger newCount = count - [self zeroCount:element];
                    NSArray *smallArray= [self makeCombinationsArray:newCount combinationsCount:[self nextArrayCount:element]];
                    for(NSArray *item in smallArray) {
                        NSMutableArray *nArray = [NSMutableArray arrayWithArray:element];
                        [nArray addObjectsFromArray:item];
                        [newArray addObject:nArray];
                    }
                }
                else {
                    [newArray addObject:element];
                }
        }
    }
    return [[newArray copy] autorelease];
}

-(NSInteger)zeroCount: (NSArray *) array {
    NSInteger zeroCount = 0;
    for(id element in array) {
        if([element isEqual:@(0)]) {
            zeroCount++;
        }
    }
    return zeroCount;
}

-(NSInteger)nextArrayCount:(NSArray *)array {
    NSInteger countZero = [self zeroCount:array];
    return countZero * 2;
}

-(BOOL)shouldContinue:(NSInteger)count withArray:(NSArray *) array {
    NSInteger countZero = [self zeroCount:array];
    if(countZero < count) {
        return YES;
    }
    return NO;
}

-(BOOL)isSuit: (NSArray *) array withCount:(NSUInteger) count {
    if([array containsObject:@(0)]){
        NSInteger countZero = [self zeroCount:array];
        if(countZero <= count) {
            return YES;
        }
    }
    return NO;
}

-(NSArray *) allPossibleCombinations:(NSArray *) array count: (NSInteger) count {
    NSMutableArray *combinations = [[[NSMutableArray alloc] init] autorelease];
    for (NSArray *element in array) {
        for (NSArray *element2 in array) {
            NSArray *combination = [NSArray arrayWithObjects:element, element2, nil];
            [combinations addObject:combination];
        }
    }
    count -= 4;
    if (count > 0) {
        combinations = [NSMutableArray arrayWithArray:[self allPossibleCombinations:combinations count:count]];
    }
    return [[combinations copy] autorelease];
}

-(NSArray *)flattenArrays: (NSArray *) array {
    NSMutableArray *flattedArray = [[NSMutableArray new] autorelease];
    
    for (id item in array) {
        if ([[item class] isSubclassOfClass:[NSArray class]]) {
            [flattedArray addObjectsFromArray:[self flattenArrays:item]];
        } else {
            [flattedArray addObject:item];
        }
    }
    
    return [[flattedArray copy] autorelease];
}

@end
