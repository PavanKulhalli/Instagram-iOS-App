//
//  ViewController.h
//  Instagram iOS App
//
//  Created by Pavan Kulhalli on 02/07/2018.
//  Copyright © 2018 Pavan Kulhalli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface LoginViewController : UIViewController<WKNavigationDelegate,WKUIDelegate>
{
    
}
@property (weak, nonatomic) IBOutlet WKWebView *loginWebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loginActivityIndicatorView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

