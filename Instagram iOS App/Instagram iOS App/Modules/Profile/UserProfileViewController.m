//
//  UserProfileViewController.m
//  Instagram iOS App
//
//  Created by Pavan Kulhalli on 03/07/2018.
//  Copyright © 2018 Pavan Kulhalli. All rights reserved.
//

#import "Constant.h"
#import "UserProfileViewController.h"
#import "ProfileInfoTableViewCell.h"
#import "TimelineTableViewCell.h"
#import <AVKit/AVKit.h>

@interface UserProfileViewController ()

@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Logout"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(logout)];
    self.navigationItem.rightBarButtonItem = logoutButton;
    [self.navigationItem setHidesBackButton:YES];
    
    [self getDataForURL:kINSTAGRAM_PROFILEURL];
    [self getDataForURL:kINSTAGRAM_MEDIAURL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)logout {
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        NSString *domainName = [cookie domain];
        NSRange domainRange = [domainName rangeOfString:@"instagram.com"];
        if(domainRange.length > 0) {
            [storage deleteCookie:cookie];
        }
    }
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey: kINSTAGRAM_ACCESS_TOKEN]; [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Get Data
-(void)getDataForURL:(NSString *) urlString {
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSError* error;
    NSString* completeURLString = [NSString stringWithFormat: @"%@%@",
                         urlString,
                          [[NSUserDefaults standardUserDefaults]
                           valueForKey:kINSTAGRAM_ACCESS_TOKEN]];
    NSData* responseData = [NSData dataWithContentsOfURL: [NSURL URLWithString:completeURLString]];
    NSDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:responseData //1
                                                         options:kNilOptions
                                                           error:&error];
    //NSDictionary* pagination = [json objectForKey:@"pagination"];
    NSNumber * code = [[jsonData objectForKey:@"meta"]objectForKey:@"code"];
    dispatch_async(dispatch_get_main_queue(), ^(void){
        if (!error) {
            if (code.integerValue == 200) {
                if ([jsonData valueForKey:@"data"]) {
                    if ([[jsonData valueForKey:@"data"] isKindOfClass:[NSArray class]]) {
                        [self parseMediaData:[jsonData valueForKey:@"data"]];
                    } else {
                        [self parseProfileData:[jsonData valueForKey:@"data"]];
                    }
                }
            }
        }
    });
});
}

- (void)parseProfileData:(NSDictionary *)responseDataDictionary {
    self.profileInfo = [ProfileInfo profileWithProfileInfo:responseDataDictionary];
    [self.userProfileTableView reloadData];
}

- (void)parseMediaData:(NSArray *)responseDataArray {
    self.mediaArray = [Timeline timelineWithInfoArray:responseDataArray];
    [self.userProfileTableView reloadData];
}




#pragma mark - Table View Data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height;
    if (indexPath.row == 0) {
        height = 150;
    } else {
        height = 400;
    }
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section {
    return self.mediaArray.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath {
    if (indexPath.row == 0)
    {
        ProfileInfoTableViewCell *cell = (ProfileInfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"profileInfoIdentifier"];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.userName.text = self.profileInfo.username;
        cell.fullName.text = self.profileInfo.full_name;
        cell.userName.text = self.profileInfo.username;
        cell.followers.text = self.profileInfo.followed_by;
        cell.following.text = self.profileInfo.follows;
        cell.profilePictureImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.profileInfo.profile_picture]]];
        
        return cell;
        
    }
    else
    {
        TimelineTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"timelineIdentifier"];
        Timeline *timeline = [self.mediaArray objectAtIndex:indexPath.row -1];
        cell.timelinePictureImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:timeline.timelineImage]]];
        cell.likeLabel.text = timeline.likesCount;
        cell.commentsLabel.text = timeline.commentsCount;
        if (timeline.caption) {
            cell.captionLabel.text = [NSString stringWithFormat:@"%@: %@", self.profileInfo.username, timeline.caption];
            NSRange range1 = [cell.captionLabel.text rangeOfString:self.profileInfo.username];
            
            NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:cell.captionLabel.text];
            
            [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16]}
                                    range:range1];
            
            cell.captionLabel.attributedText = attributedText;
        } else {
            cell.captionLabel.text = @"";
        }
        cell.profilePictureImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.profileInfo.profile_picture]]];
        cell.locationLabel.text = timeline.location;
    return cell;
    }
}

#pragma mark - TableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath {
    if (indexPath.row != 0) {
        Timeline *timeline = [self.mediaArray objectAtIndex:indexPath.row -1];
        if ([timeline.type isEqualToString:@"video"]) {
            NSURL *videoURL = [NSURL URLWithString:timeline.videoLink];
            AVPlayer *player = [AVPlayer playerWithURL:videoURL];
            AVPlayerViewController *playerViewController = [AVPlayerViewController new];
            playerViewController.player = player;
            [self.view addSubview:playerViewController.view];
            [self presentViewController:playerViewController animated:YES completion:nil];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        } else {
            [self addImageViewWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:timeline.timelineImage]]]];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
    }
}

-(void)removeImage:(UITapGestureRecognizer *) dismissTap {
    UIImageView *imgView = (UIImageView*)[self.view viewWithTag:100];
    [imgView removeFromSuperview];
   [self.view removeGestureRecognizer:dismissTap];
    self.userProfileTableView.allowsSelection = YES;
}

-(void)addImageViewWithImage:(UIImage*)image {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.view.frame];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.backgroundColor = [UIColor blackColor];
    imgView.image = image;
    imgView.tag = 100;
    UITapGestureRecognizer *dismissTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeImage:)];
    dismissTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:dismissTap];
    self.userProfileTableView.allowsSelection = NO;
    [self.view addSubview:imgView];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
