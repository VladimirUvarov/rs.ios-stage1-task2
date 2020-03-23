#import "Dates.h"

@implementation Dates

- (NSString *)textForDay:(NSString *)day month:(NSString *)month year:(NSString *)year {
    NSString *dateString = [NSString stringWithFormat:@"%@ %@ %@", day, month, year];
    NSDateFormatter *inputDateFormatter = [[NSDateFormatter alloc] init];
    [inputDateFormatter setDateFormat:@"dd MM yyyy"];
    NSDate *date = [inputDateFormatter dateFromString:dateString];
    if (date == nil){
        return @"Такого дня не существует";
    }
    NSDateFormatter *outputDateFormatter = [[NSDateFormatter alloc] init];
    [outputDateFormatter setDateFormat:@"d MMMM, EEEE"];
    outputDateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"];
    NSString *res = [outputDateFormatter stringFromDate:date];
    return res;
}

@end
