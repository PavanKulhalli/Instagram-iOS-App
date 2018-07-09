//
//  timeline.m
//  Instagram iOS App
//
//  Created by Pavan Kulhalli on 08/07/2018.
//  Copyright © 2018 Pavan Kulhalli. All rights reserved.
//

#import "Timeline.h"

@implementation Timeline

- (id)initWithInfoDictionary:(NSDictionary *)timelineDictionary {
    if ((self = [super init])) {
        if ([[timelineDictionary valueForKey:@"id"] isKindOfClass:[NSString class]]) {
            self.profileID = [timelineDictionary valueForKey:@"id"];
        }
        if ([[timelineDictionary valueForKey:@"type"] isKindOfClass:[NSString class]]) {
            self.type = [timelineDictionary valueForKey:@"type"];
        }
        
        if ([[timelineDictionary valueForKey:@"images"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *imagesDictionary = [timelineDictionary valueForKey:@"images"];
            if ([[imagesDictionary valueForKey:@"standard_resolution"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *resolutionDictionary = [imagesDictionary valueForKey:@"standard_resolution"] ;
                if ([[resolutionDictionary valueForKey:@"url"] isKindOfClass:[NSString class]]) {
                    self.timelineImage = [resolutionDictionary valueForKey:@"url"];
                }
            }
        }
        
        if ([[timelineDictionary valueForKey:@"caption"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *captionDictionary = [timelineDictionary valueForKey:@"caption"];
            if ([[captionDictionary valueForKey:@"text"] isKindOfClass:[NSString class]]) {
                self.caption = [captionDictionary valueForKey:@"text"];
            }
        }
        
        if ([[timelineDictionary valueForKey:@"likes"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *likesDictionary = [timelineDictionary valueForKey:@"likes"];
            if ([[likesDictionary valueForKey:@"count"] isKindOfClass:[NSNumber class]]) {
                self.likesCount = [[likesDictionary valueForKey:@"count"] stringValue];
            }
        }
        
        if ([[timelineDictionary valueForKey:@"comments"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *commentsDictionary = [timelineDictionary valueForKey:@"comments"];
            if ([[commentsDictionary valueForKey:@"count"] isKindOfClass:[NSNumber class]]) {
                self.commentsCount = [[commentsDictionary valueForKey:@"count"] stringValue];
            }
        }
        
        if ([[timelineDictionary valueForKey:@"location"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *locationDictionary = [timelineDictionary valueForKey:@"location"];
            if ([[locationDictionary valueForKey:@"name"] isKindOfClass:[NSString class]]) {
                self.location = [locationDictionary valueForKey:@"name"];
            }
        }
        
        if ([[timelineDictionary valueForKey:@"videos"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *videosDictionary = [timelineDictionary valueForKey:@"videos"];
            if ([[videosDictionary valueForKey:@"standard_resolution"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *resolutionDictionary = [videosDictionary valueForKey:@"standard_resolution"] ;
                if ([[resolutionDictionary valueForKey:@"url"] isKindOfClass:[NSString class]]) {
                    self.videoLink = [resolutionDictionary valueForKey:@"url"];
                }
            }
        }
    }
    return self;
}

+ (Timeline *)timelineWithTimelineInfo:(NSDictionary *)timelineDictionary {
    Timeline *timeline = [[Timeline alloc] initWithInfoDictionary:timelineDictionary];
    return timeline;
}

+ (NSArray *)timelineWithInfoArray:(NSArray *)timelineArray {
    NSArray *returnVal = nil;
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *timelineDictionary in timelineArray) {
        Timeline *timeline = [[Timeline alloc] initWithInfoDictionary:timelineDictionary];
        [array addObject:timeline];
    }
    if (array.count > 0) {
        returnVal = array;
    }
    
    return returnVal;
}


@end
