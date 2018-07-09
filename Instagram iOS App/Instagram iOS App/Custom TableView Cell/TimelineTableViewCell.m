//
//  TimelineTableViewCell.m
//  Instagram iOS App
//
//  Created by Pavan Kulhalli on 07/07/2018.
//  Copyright © 2018 Pavan Kulhalli. All rights reserved.
//

#import "TimelineTableViewCell.h"

@implementation TimelineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.profilePictureImageView.layer.cornerRadius = 20;
    self.profilePictureImageView.layer.masksToBounds = true;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
