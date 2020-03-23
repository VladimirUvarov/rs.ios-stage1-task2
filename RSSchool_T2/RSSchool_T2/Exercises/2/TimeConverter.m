#import "TimeConverter.h"

@implementation TimeConverter

NSString* intToString(int digits) {
    NSArray *fArray = [NSArray arrayWithObjects:  @"zero", @"one", @"two", @"three", @"four", @"five", @"six", @"seven", @"eight" , @"nine",  @"ten", @"eleven", @"twelve", @"thirteen", @"fourteen", @"fifteen", @"sixteen", @"seventeen", @"eighteen", @"nineteen", nil];
    NSArray *sArray = [NSArray arrayWithObjects:  @"", @"", @"twenty", @"thirty", @"fourty", @"fifty", @"sixty", @"seventy", @"eighty", @"ninety", nil];
    NSString* res = @"";
    if (digits < 20) {
        res = fArray[digits];
    } else if (digits < 100) {
        int g = digits % 10;
        int k = (digits - g) / 10;
        if (g == 0) {
            res = [sArray[k] stringValue];
        } else {
            res = [[sArray[k] stringByAppendingString:@" "] stringByAppendingString: fArray[g]];
        }
    }
    return res;
}

- (NSString*)convertFromHours:(NSString*)hours minutes:(NSString*)minutes {
    int hourInt = [hours intValue];
    int minutesInt = [minutes intValue];
    NSString* res = @"";
    if (hourInt > 0 && hourInt <= 12 && minutesInt >= 0 && minutesInt < 60) {
        if (minutesInt == 0)  {
            res = [intToString (hourInt) stringByAppendingString: @" o' clock"];
        } else if (minutesInt == 15) {
            res =  [@"quarter past " stringByAppendingString: intToString (hourInt)];
        } else if (minutesInt == 30) {
            res =  [@"half past " stringByAppendingString: intToString (hourInt)];
        } else if (minutesInt < 30) {
            res = [[intToString (minutesInt) stringByAppendingString: @" minutes past "] stringByAppendingString: intToString (hourInt)];
        } else if (minutesInt == 45) {
            res =  [@"quarter to " stringByAppendingString: intToString (hourInt + 1)];
        } else if (minutesInt > 30) {
            res = [[intToString (60 - minutesInt) stringByAppendingString: @" minutes to "] stringByAppendingString: intToString (hourInt + 1)];
        }
    }
    return res;
}

@end

