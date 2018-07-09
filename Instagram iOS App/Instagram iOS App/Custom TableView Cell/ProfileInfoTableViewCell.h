//
//  ProfileInfoTableViewCell.h
//  Instagram iOS App
//
//  Created by Pavan Kulhalli on 07/07/2018.
//  Copyright © 2018 Pavan Kulhalli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profilePictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *fullName;
@property (weak, nonatomic) IBOutlet UILabel *followers;
@property (weak, nonatomic) IBOutlet UILabel *following;

@end
