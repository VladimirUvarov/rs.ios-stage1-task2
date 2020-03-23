#import "NSString+Transform.h"

@implementation NSString (Transform)

bool isEveryChar(NSSet *characters, NSString *sstring ) {
    for (NSString *chr in characters) {
        if (![[sstring uppercaseString] containsString:[chr uppercaseString]]) {
            return false;
        }
    }
    return true;
}

int charCounter(NSSet *characters, NSString *sstring ) {
    int res = 0;
    for (int u = 0; u < sstring.length; u++) {
        NSString *m = [sstring substringWithRange:NSMakeRange(u, 1)];
        if ([characters containsObject:[m lowercaseString]]) {
            res++;
        }
    }
    return res;
}

NSString* transformPangrams(NSString *source) {
    NSSet *vowels = [[NSSet alloc] initWithObjects:@"a", @"e", @"i", @"o", @"u", @"y", nil];
    NSSet *consonants = [[NSSet alloc] initWithObjects: @"b", @"c", @"d", @"f", @"g", @"h", @"j", @"k", @"l", @"m", @"n", @"p", @"q", @"r", @"s", @"t", @"v", @"w", @"x", @"z", nil];
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern: @"\\s{2,}+" options:NSRegularExpressionCaseInsensitive error: &error];
    source = [[regex stringByReplacingMatchesInString: source options: 0 range: NSMakeRange(0, [source length]) withTemplate: @" "] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    NSArray *words = [source componentsSeparatedByString:@" "];
    bool isPangram = isEveryChar(vowels, source) && isEveryChar(consonants, source);
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    for (NSString *chr in words) {
        if (![chr isEqualToString:@""]){
            NSNumber * count = [NSNumber numberWithInt: charCounter(isPangram ? vowels : consonants, chr)];
            id v = [dict objectForKey: count];
            NSString *newChr = @"";
            for (int u = 0; u < chr.length; u++) {
                NSString *m = [chr substringWithRange:NSMakeRange(u, 1)];
                if (isPangram && [vowels containsObject:m]) {
                    newChr = [newChr stringByAppendingString: [m uppercaseString]];
                } else if (!isPangram && [consonants containsObject:m]) {
                    newChr = [newChr stringByAppendingString: [m uppercaseString]];
                } else {
                    newChr = [newChr stringByAppendingString: m];
                }
            }
            if (v == nil) {
                NSMutableArray * a = [[NSMutableArray alloc] initWithObjects:newChr, nil];
                [dict setObject:a forKey:count];
            } else {
                [v addObject: newChr];
            }
        }
    }
    NSArray *sortedKeys = [dict.allKeys sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES]]];
    NSArray *sortedValues = [dict objectsForKeys:sortedKeys notFoundMarker:@""];
    NSString *dest = @"";
    for (int i = 0; i < sortedValues.count; i++) {
        NSArray *arr = sortedValues[i];
        for (int j = 0; j < arr.count; j++) {
            NSString *chr = arr[j];
            if (![dest isEqualToString:@""]) {
                dest = [dest stringByAppendingString:@" "];
            }
            dest = [dest stringByAppendingString: [sortedKeys[i] stringValue]];
            dest = [dest stringByAppendingString:chr];
        }
    }
    return dest;
}

-(NSString*)transform {
    return transformPangrams(self);
}

@end

/*
 
 Pangram - a sentence that contains each letter of the alphabet at least one time
 Pangram example: "Farmer jack realized that big yellow quilts were expensive"
 Сonvert method should transform string according to the
 following rules:
 a. if the given string is pangram :
 - all words of a given string should be sorted by count of
 vowels; notes: (vowels: a,e,i,o,u,y), (words: all substrings of a given string separated by space), words shouldn't have 0 lengths, a word may contain a punctuation character ("someWord," or even ",").
 - all vowels should be capitalized (no need to change letters that are already capitalized)
 - each word should begin with a count of vowels (before: name, after: 2name)
 b. if the given string is not pangram
 - all words of a given string should be sorted by count of
 consonants; notes: (consonants: all letters of English alphabet excluding vowels), (words: all substrings of a given string separated by space), words shouldn't have 0 lengths, a word may contain a punctuation character ("someWord," or even ",").
 - all consonants should be capitalized (no need to change letters that are already capitalized)
 - each word should begin with a count of consonants (before: name, after: 2name)
 newline characters should be replaced with spaces
 EXAMPLE:
 pangrams
 [@"The five boxing wizards jump quickly." convert] should return "1ThE 1jUmp 2fIvE 2bOxIng 2wIzArds 3qUIcklY."
 [@"A mad boxer shot a quick, gloved jab to the jaw of his dizzy opponent." convert] should return "1A 1mAd 1shOt 1A 1jAb 1tO 1thE 1jAw 1Of 1hIs 2bOxEr 2qUIck, 2glOvEd 2dIzzY 3OppOnEnt."
 no pangrams
 
 [@"Even the most complicated sentences start with a simple structure." convert] should return "0a 2EVeN 2THe 3MoST 3WiTH 4STaRT 4SiMPLe 6SeNTeNCeS 6STRuCTuRe. 7CoMPLiCaTeD"
 */
