//
//  NSString+CommonUtils.m
//  GLClub
//
//  Created by Damian Ferrai on 6/16/16.
//  Copyright © 2016 Maxi Garcia. All rights reserved.
//

#import "NSString+CommonUtils.h"

@implementation NSString (CommonUtils)

- (NSDate *)dateFromRFC822String {
    
    // Create date formatter
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        NSLocale *en_US_POSIX = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:en_US_POSIX];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    }
    
    // Process
    NSDate *date = nil;
    NSString *RFC822String = [[NSString stringWithString:self] uppercaseString];
    if ([RFC822String rangeOfString:@","].location != NSNotFound) {
        if (!date) { // Sun, 19 May 2002 15:21:36 GMT
            [dateFormatter setDateFormat:@"EEE, d MMM yyyy HH:mm:ss zzz"];
            date = [dateFormatter dateFromString:RFC822String];
        }
        if (!date) { // Sun, 19 May 2002 15:21 GMT
            [dateFormatter setDateFormat:@"EEE, d MMM yyyy HH:mm zzz"];
            date = [dateFormatter dateFromString:RFC822String];
        }
        if (!date) { // Sun, 19 May 2002 15:21:36
            [dateFormatter setDateFormat:@"EEE, d MMM yyyy HH:mm:ss"];
            date = [dateFormatter dateFromString:RFC822String];
        }
        if (!date) { // Sun, 19 May 2002 15:21
            [dateFormatter setDateFormat:@"EEE, d MMM yyyy HH:mm"];
            date = [dateFormatter dateFromString:RFC822String];
        }
    } else {
        if (!date) { // 19 May 2002 15:21:36 GMT
            [dateFormatter setDateFormat:@"d MMM yyyy HH:mm:ss zzz"];
            date = [dateFormatter dateFromString:RFC822String];
        }
        if (!date) { // 19 May 2002 15:21 GMT
            [dateFormatter setDateFormat:@"d MMM yyyy HH:mm zzz"];
            date = [dateFormatter dateFromString:RFC822String];
        }
        if (!date) { // 19 May 2002 15:21:36
            [dateFormatter setDateFormat:@"d MMM yyyy HH:mm:ss"];
            date = [dateFormatter dateFromString:RFC822String];
        }
        if (!date) { // 19 May 2002 15:21
            [dateFormatter setDateFormat:@"d MMM yyyy HH:mm"];
            date = [dateFormatter dateFromString:RFC822String];
        }
    }
    if (!date) NSLog(@"Could not parse RFC822 date: \"%@\" Possibly invalid format.", self);
    
    return date;
}

@end
