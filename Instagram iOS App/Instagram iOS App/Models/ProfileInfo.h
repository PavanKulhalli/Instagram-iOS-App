//
//  ProfileInfo.h
//  Instagram iOS App
//
//  Created by Pavan Kulhalli on 08/07/2018.
//  Copyright © 2018 Pavan Kulhalli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfileInfo : NSObject

/**
 * @brief Variable to hold profile id.
 */
@property (nonatomic, strong) NSString *profileID;

/**
 * @brief Variable to hold username.
 */
@property (nonatomic, strong) NSString *username;

/**
 * @brief Variable to hold profile_picture.
 */
@property (nonatomic, strong) NSString *profile_picture;

/**
 * @brief Variable to hold full_name.
 */
@property (nonatomic, strong) NSString *full_name;

/**
 * @brief Variable to hold mediaCount.
 */
@property (nonatomic, strong) NSString *mediaCount;

/**
 * @brief Variable to hold follows  .
 */
@property (nonatomic, strong) NSString *follows;

/**
 * @brief Variable to hold followed_by  .
 */
@property (nonatomic, strong) NSString *followed_by;

/**
 * @discussion Method to set the value from dictionary to object model.
 * @return id.
 */
- (id)initWithInfoDictionary:(NSDictionary *)profileInfoDictionary;

/**
 * @discussion Method to create a model objects.
 * @return V3Patient.
 */
+ (ProfileInfo *)profileWithProfileInfo:(NSDictionary *)profileInfoDictionary;


@end
