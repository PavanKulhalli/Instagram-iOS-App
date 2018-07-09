//
//  TimelineTableViewCell.h
//  Instagram iOS App
//
//  Created by Pavan Kulhalli on 07/07/2018.
//  Copyright © 2018 Pavan Kulhalli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimelineTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *timelinePictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profilePictureImageView;
@end
