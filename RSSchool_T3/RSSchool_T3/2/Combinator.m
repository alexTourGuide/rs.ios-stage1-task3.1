#import "Combinator.h"

@implementation Combinator
- (NSNumber*)chechChooseFromArray:(NSArray <NSNumber*>*)array {
// use double to apply n <= 1030, otherwise - calculated at n <= 62
    double mBinCoef = array[0].intValue;
    double n = array[1].intValue;
    
    if (n == mBinCoef) {
        return @1;
    }
    
    for (int x = 1; x < n; x++) {
        double nFact = [Combinator factorial:n];
        double xDiffNxFact = [Combinator factorial:(n - x)] * [Combinator factorial:x];
        double k = nFact / xDiffNxFact;
        if (k >= mBinCoef) {
           return [NSNumber numberWithInt:x];
        }
    }
    return nil;
}

// factorialOfN calculation
+ (double)factorial:(double)n {
    double fact = 1;
    for (int i = 1; i <= n; i++) {
        fact = fact * i;
    }
    return fact;
}

@end

