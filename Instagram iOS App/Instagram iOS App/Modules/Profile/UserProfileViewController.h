//
//  UserProfileViewController.h
//  Instagram iOS App
//
//  Created by Pavan Kulhalli on 03/07/2018.
//  Copyright © 2018 Pavan Kulhalli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileInfo.h"
#import "Timeline.h"

@interface UserProfileViewController : UIViewController


/**
 * @brief Array to hold all the Profile Info data model objects.
 */
@property (nonatomic, strong) ProfileInfo *profileInfo;
/**
 * @brief Array to hold all the Media data model objects.
 */
@property (nonatomic, strong) NSArray *mediaArray;
@property (weak, nonatomic) IBOutlet UITableView *userProfileTableView;

@end
