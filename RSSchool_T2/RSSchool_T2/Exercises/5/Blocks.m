#import "Blocks.h"
@interface Blocks()

@property (nonatomic) NSArray *dataArray;

@end

@implementation Blocks

-(instancetype) init {
    self = [super init];
    __weak Blocks* weakSelf = self;
    _blockA = ^void(NSArray * arr) {
        __strong Blocks* strongSelf = weakSelf;
        strongSelf.dataArray = arr;
    };
    _blockB = ^void(Class handleClass) {
           __strong Blocks* strongSelf = weakSelf;
           int num = 0;
           NSString *str = @"";
           NSDate *dat = NSDate.distantPast;
           for(int i = 0; i < strongSelf.dataArray.count; i++){
               if (handleClass == [NSNumber class] && [strongSelf.dataArray[i] isKindOfClass:NSNumber.class] ){
                   num = num  + [strongSelf.dataArray[i] intValue];
               } else if (handleClass == [NSString class] && [strongSelf.dataArray[i] isKindOfClass:NSString.class] ){
                   str = [str  stringByAppendingString: strongSelf.dataArray[i]];
               } else if (handleClass == [NSDate class] && [strongSelf.dataArray[i] isKindOfClass:NSDate.class] ){
                   dat = [dat laterDate: strongSelf.dataArray[i]];
               }
           }
           if (handleClass == [NSNumber class]){
               strongSelf.blockC([NSNumber numberWithInt:num]);
           } else if (handleClass == [NSString class]){
               strongSelf.blockC(str);
           } else if (handleClass == [NSDate class]){
               NSDateFormatter *outputDateFormatter = [[NSDateFormatter alloc] init];
               [outputDateFormatter setDateFormat:@"dd.MM.yyyy"];
               NSString *res = [outputDateFormatter stringFromDate:dat];
               strongSelf.blockC(res);
           }
       };
    return self;
}

@end
