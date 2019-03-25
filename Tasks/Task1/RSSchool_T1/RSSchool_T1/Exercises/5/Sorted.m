#import "Sorted.h"

@implementation ResultObject

-(void) dealloc {
    self.detail = nil;
    [super dealloc];
}

@end

@implementation Sorted

// Complete the sorted function below.
- (ResultObject*)sorted:(NSString*)string {
    ResultObject *value = [[ResultObject new] autorelease];
    NSArray *array = [string componentsSeparatedByString:@" "];
    NSMutableArray *updatedArray = [[NSMutableArray alloc] initWithArray:array copyItems:YES];
    NSMutableDictionary *dictionaryForSorting = [[NSMutableDictionary alloc] init];
    
    if ([self isSorted:array]) {
        value.status = YES;
    }
    
    for (int i = 0; i < array.count - 1; i++) {
        if ([array[i] integerValue] > [array[i + 1] integerValue]) {
            if(array.count > 2) {
                if (![self compare:array index:i i:i]) {
                    [dictionaryForSorting setObject:array[i] forKey:@(i)];
                }
                else if ([self compare:array index:i + 1 i:i]) {
                    [dictionaryForSorting setObject:array[i] forKey:@(i)];
                    [dictionaryForSorting setObject:array[i + 1] forKey:@(i + 1)];
                }
                if (![self compare:array index:i + 1 i:i]) {
                    [dictionaryForSorting setObject:array[i + 1] forKey:@(i + 1)];
                }
            }
            else {
                [dictionaryForSorting setObject:array[i] forKey:@(i)];
                [dictionaryForSorting setObject:array[i + 1] forKey:@(i + 1)];
                break;
            }
        }
    }
    
    NSMutableArray * keyArray = [[NSMutableArray alloc] initWithArray:dictionaryForSorting.allKeys];
    if (dictionaryForSorting.count == 2) {
        if ([keyArray[0] intValue] > [keyArray[1] intValue]) {
            NSNumber *temp = keyArray[0];
            [keyArray replaceObjectAtIndex:0 withObject:keyArray[1]];
            [keyArray replaceObjectAtIndex:1 withObject:temp];
        }
        [updatedArray replaceObjectAtIndex:[keyArray[0] intValue] withObject:[dictionaryForSorting objectForKey:keyArray[1]]];
        [updatedArray replaceObjectAtIndex:[keyArray[1] intValue] withObject:[dictionaryForSorting objectForKey:keyArray[0]]];
        if ([self isSorted:updatedArray]) {
            value.status = YES;
            value.detail = [NSString stringWithFormat:@"swap %d %d", [keyArray[0] intValue] + 1, [keyArray[1] intValue] + 1];
        }
        else {
            value.status = NO;
        }
    }
    
    else {
        NSSortDescriptor *sorting = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
        [keyArray sortUsingDescriptors:[NSArray arrayWithObject:sorting]];
        for (int i = 0; i < keyArray.count - 1; i++) {
            if ([keyArray[i + 1] intValue] - [keyArray[i] intValue] != 1) {
                value.status = NO;
                [keyArray release];
                [updatedArray release];
                [dictionaryForSorting release];
                return value;
            }
        }
        NSMutableArray *reversedArray = [NSMutableArray array];
        for (int i = [keyArray[0] intValue]; i <= [keyArray.lastObject intValue]; i++) {
            [reversedArray addObject:updatedArray[i]];
        }
        reversedArray = [[[reversedArray reverseObjectEnumerator] allObjects] mutableCopy];
        [updatedArray replaceObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange([keyArray[0] intValue], keyArray.count)] withObjects:reversedArray];
        [reversedArray release];
        if ([self isSorted:updatedArray]) {
            value.status = YES;
            value.detail = [NSString stringWithFormat:@"reverse %d %d", [keyArray[0] intValue] + 1, [keyArray.lastObject intValue] + 1];
        }
        else {
            value.status = NO;
        }
    }
    
    [keyArray release];
    [updatedArray release];
    [dictionaryForSorting release];
    
    return value;
}

- (BOOL) compare: (NSArray *) array index: (int) index i: (int) i {
    if (i > 0 && i < array.count - 1) {
        if ([array[index] integerValue] > [array[i - 1] integerValue]) {
            if ([array[index] integerValue] < [array[i + 2] integerValue]) {
                return YES;
            }
        }
    }
    else if (i == 0) {
        if ([array[index] integerValue] < [array[i + 2] integerValue]) {
            return YES;
        }
    }
    else {
        if ([array[index] integerValue] > [array[i - 1] integerValue]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL) isSorted: (NSArray *) array {
    for (int i = 0; i < array.count - 1; i++) {
        if ([array[i] integerValue] > [array[i + 1] integerValue]) {
            return NO;
        }
    }
    return YES;
}

@end
