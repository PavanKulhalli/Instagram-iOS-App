//
//  ViewController.m
//  Instagram iOS App
//
//  Created by Pavan Kulhalli on 02/07/2018.
//  Copyright © 2018 Pavan Kulhalli. All rights reserved.
//
#import "Constant.h"
#import "LoginViewController.h"

@interface LoginViewController ()


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.loginWebView.UIDelegate = self;
    self.loginWebView.navigationDelegate = self;
    if ([[NSUserDefaults standardUserDefaults]
         valueForKey:kINSTAGRAM_ACCESS_TOKEN]) {
        [self performSegueWithIdentifier:@"userProfileSegue" sender:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.loginButton setHidden:false];
    [self.loginWebView setHidden:true];
    [self.loginActivityIndicatorView setHidden:true];
}

- (IBAction)loginButtonPressed:(UIButton *)sender {
    [self.loginButton setHidden:true];
    [self.loginWebView setHidden:false];
    [self.loginActivityIndicatorView setHidden:false];
    [self loadLoginWindow];
}

- (void) loadLoginWindow {
    NSString* authURL = [NSString stringWithFormat: @"%@?client_id=%@&redirect_uri=%@&response_type=token&scope=%@&DEBUG=True",
                   kINSTAGRAM_AUTHURL,
                   kINSTAGRAM_CLIENT_ID,
                   kINSTAGRAM_REDIRECT_URI,
                   kINSTAGRAM_SCOPE];
    [self.loginWebView loadRequest: [NSURLRequest requestWithURL: [NSURL URLWithString: authURL]]];
}

#pragma mark Instagram Authentication method

- (BOOL) checkRequestForCallbackURL: (NSURLRequest*) request {
    NSString* urlString = [[request URL] absoluteString];
    
    // If authentication is succesfull we get redirect URL
    if([urlString hasPrefix: kINSTAGRAM_REDIRECT_URI])
    {
        // We parse access token urlString
        NSRange range = [urlString rangeOfString: @"#access_token="];
        [self getAuth: [urlString substringFromIndex: range.location+range.length]];
        return NO;
    }
    return YES;
}

#pragma mark Get Authorization method

- (void) getAuth: (NSString*) authToken {
    NSLog(@"You have been successfully loggedIn with tocken == %@",authToken);
    [[NSUserDefaults standardUserDefaults] setValue:authToken forKey: kINSTAGRAM_ACCESS_TOKEN]; [[NSUserDefaults standardUserDefaults] synchronize];
    [self.loginButton setHidden:false];
    [self.loginWebView setHidden:true];
    [self.loginActivityIndicatorView setHidden:true];
    [self performSegueWithIdentifier:@"userProfileSegue" sender:nil];
}

#pragma mark - WKWebView Delegate Methods

- (void) webView: (WKWebView *) webView decidePolicyForNavigationAction: (WKNavigationAction *) navigationAction decisionHandler: (void (^)(WKNavigationActionPolicy)) decisionHandler
{
    decisionHandler([self checkRequestForCallbackURL: [navigationAction request]]);
}

- (void) webView: (WKWebView *) webView didStartProvisionalNavigation: (WKNavigation *) navigation
{
    [self.loginActivityIndicatorView startAnimating];
    [self.loginWebView.layer removeAllAnimations];
    self.loginWebView.userInteractionEnabled = NO;
}

- (void) webView:(WKWebView *) webView didFailProvisionalNavigation: (WKNavigation *) navigation withError: (NSError *) error
{
   
}

- (void) webView: (WKWebView *) webView didCommitNavigation: (WKNavigation *) navigation {
    // do nothing
}

- (void) webView: (WKWebView *) webView didFailNavigation: (WKNavigation *) navigation withError: (NSError *) error {
    [self webView:webView didFinishNavigation:navigation];
}

- (void) webView: (WKWebView *) webView didFinishNavigation: (WKNavigation *) navigation
{
    [self.loginActivityIndicatorView stopAnimating];
    [self.loginActivityIndicatorView removeFromSuperview];
    [self.loginWebView.layer removeAllAnimations];
    self.loginWebView.userInteractionEnabled = YES;
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     if ([[segue identifier] isEqualToString:@"userProfileSegue"])
     {
         
     }
 }


@end
