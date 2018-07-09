//
//  timeline.h
//  Instagram iOS App
//
//  Created by Pavan Kulhalli on 08/07/2018.
//  Copyright © 2018 Pavan Kulhalli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Timeline : NSObject
/**
 * @brief Variable to hold profile id.
 */
@property (nonatomic, strong) NSString *profileID;

/**
 * @brief Variable to hold username.
 */
@property (nonatomic, strong) NSString *timelineImage;

/**
 * @brief Variable to hold type.
 */
@property (nonatomic, strong) NSString *type;

/**
 * @brief Variable to hold likesCount.
 */
@property (nonatomic, strong) NSString *likesCount;

/**
 * @brief Variable to hold commentsCount.
 */
@property (nonatomic, strong) NSString *commentsCount;

/**
 * @brief Variable to hold follows.
 */
@property (nonatomic, strong) NSString *location;

/**
 * @brief Variable to hold followed_by.
 */
@property (nonatomic, strong) NSString *caption;

/**
 * @brief Variable to hold followed_by.
 */
@property (nonatomic, strong) NSString *videoLink;


/**
 * @discussion Method to set the value from dictionary to object model.
 * @return id.
*/
- (id)initWithInfoDictionary:(NSDictionary *)profileInfoDictionary;

 /**
 * @discussion Method to create a model objects.
 * @return V3Patient.
 */
+ (NSArray *)timelineWithInfoArray:(NSArray *)timelineArray;

@end
