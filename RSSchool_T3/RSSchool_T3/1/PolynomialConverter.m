#import "PolynomialConverter.h"

@implementation PolynomialConverter
- (NSString*)convertToStringFrom:(NSArray <NSNumber*>*)numbers {
    NSMutableString *result = [[NSMutableString alloc] init];
    if (![numbers  isEqual: @[]]) {
        unsigned long count = numbers.count;
        for (int i = 0; i < count; i++) {
            int zero = numbers[i].intValue;
            if (zero != 0){
                if (i == count - 2) {
                    
                    if (zero > 0 && zero != 1) {
                        if (count != 2) {
                            [result appendString:@"+ "];
                        }
                        NSString *zeroString = [NSString stringWithFormat:@"%dx", zero];
                        [result appendString:zeroString];
                        if (i+1 != count && numbers[count-1].intValue != 0) {
                            [result appendString:@" "];
                        }
                    }
                    if (zero == 1) {
                        if (count != 2) {
                            [result appendString:@"+ "];
                        }
                        NSString *zeroString = [NSString stringWithFormat:@"x"];
                        [result appendString:zeroString];
                        if (i+1 != count && numbers[count-1].intValue != 0) {
                            [result appendString:@" "];
                        }
                    }
                    if (zero < 0 && zero != -1) {
                        if (count != 2) {
                            [result appendString:@"- "];
                        }
                        NSString *zeroMinus = [NSString stringWithFormat:@"%d", zero];
                        NSString *zeroM = [zeroMinus substringFromIndex:1];
                        NSString *zeroString = [NSString stringWithFormat:@"%@x", zeroM];
                        [result appendString:zeroString];
                        if (i+1 != count && numbers[count-1].intValue != 0) {
                            [result appendString:@" "];
                        }
                    }
                    if (zero == -1) {
                        if (count != 2) {
                            [result appendString:@"- "];
                        }
                        NSString *zeroString = [NSString stringWithFormat:@"x"];
                        [result appendString:zeroString];
                        if (i+1 != count && numbers[count-1].intValue != 0) {
                            [result appendString:@" "];
                        }
                    }
                }
                
                if (i == count - 1) {
                    if (zero > 0) {
                        NSString *zeroString = [NSString stringWithFormat:@"+ %d", zero];
                        [result appendString:zeroString];
                        }
                    if (zero < 0) {
                        NSString *zeroMinus = [NSString stringWithFormat:@"%d", zero];
                        NSString *zeroM = [zeroMinus substringFromIndex:1];
                        NSString *zeroString = [NSString stringWithFormat:@"- %@", zeroM];
                        [result appendString:zeroString];
                        }
                }
                
                if (i < count - 2 && zero > 0){
                    if (i != 0) {
                        [result appendString:@"+ "];
                    }
                    NSString *zeroString = [NSString stringWithFormat:@"%dx^%lu", zero, count-i-1];
                    [result appendString:zeroString];
                    if (i+1 != count) {
                        [result appendString:@" "];
                    }
                }
                if (i < count - 2 && zero < 0){
                    if (i != 0) {
                        [result appendString:@"- "];
                    }
                    NSString *zeroMinus = [NSString stringWithFormat:@"%d", zero];
                    NSString *zeroM = [zeroMinus substringFromIndex:1];
                    NSString *zeroString = [NSString stringWithFormat:@"%@x^%lu", zeroM, count-i-1];
                    [result appendString:zeroString];
                    if (i+1 != count) {
                        [result appendString:@" "];
                    }
                }
            }
        }
        NSLog(@"%@", result);
        return result;
    } else {
    return nil;
    }
}
@end


