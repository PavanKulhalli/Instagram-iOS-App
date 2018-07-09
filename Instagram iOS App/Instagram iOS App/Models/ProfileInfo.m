//
//  ProfileInfo.m
//  Instagram iOS App
//
//  Created by Pavan Kulhalli on 08/07/2018.
//  Copyright © 2018 Pavan Kulhalli. All rights reserved.
//

#import "ProfileInfo.h"

@implementation ProfileInfo


- (id)initWithInfoDictionary:(NSDictionary *)profileInfoDictionary {
    if ((self = [super init])) {
        if ([[profileInfoDictionary valueForKey:@"id"] isKindOfClass:[NSString class]]) {
            self.profileID = [profileInfoDictionary valueForKey:@"id"];
        }
        if ([[profileInfoDictionary valueForKey:@"username"] isKindOfClass:[NSString class]]) {
            self.username = [profileInfoDictionary valueForKey:@"username"];
        }
        if ([[profileInfoDictionary valueForKey:@"profile_picture"] isKindOfClass:[NSString class]]) {
            self.profile_picture = [profileInfoDictionary valueForKey:@"profile_picture"];
        }
        if ([[profileInfoDictionary valueForKey:@"full_name"] isKindOfClass:[NSString class]]) {
            self.full_name = [profileInfoDictionary valueForKey:@"full_name"];
        }
        
        if ([[profileInfoDictionary valueForKey:@"counts"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *countsDictionary = [profileInfoDictionary valueForKey:@"counts"];
            if ([[countsDictionary valueForKey:@"media"] isKindOfClass:[NSNumber class]]) {
                self.mediaCount = [[countsDictionary valueForKey:@"media"] stringValue];
            }
            if ([[countsDictionary valueForKey:@"follows"] isKindOfClass:[NSNumber class]]) {
                self.follows = [[countsDictionary valueForKey:@"follows"] stringValue];
            }
            if ([[countsDictionary valueForKey:@"followed_by"] isKindOfClass:[NSNumber class]]) {
                self.followed_by = [[countsDictionary valueForKey:@"followed_by"] stringValue];
            }
        }
    }
    return self;
}


+ (ProfileInfo *)profileWithProfileInfo:(NSDictionary *)profileInfoDictionary {
    ProfileInfo *profileInfo = [[ProfileInfo alloc] initWithInfoDictionary:profileInfoDictionary];
    return profileInfo;
}

@end
