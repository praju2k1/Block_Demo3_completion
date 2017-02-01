//
//  ViewController.m
//  Block_Demo2
//
//  Created by MANU on 6/25/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@property ( strong,nonatomic) void (^loadingCompleet )(BOOL);
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    self.activityIndicator.color = [ UIColor redColor];
    self.activityIndicator.hidden = YES;
    self.webView.delegate = self;
    
    


    
    
    
}



- (IBAction)handleLoad:(id)sender {
    
    NSURL *url = [ NSURL URLWithString:self.urlTextField.text];
    
    __weak ViewController *blockself = self;
    [self loadWebView:url competionBlock:^(BOOL success) {
        
        if ( success){
            [blockself.activityIndicator  stopAnimating];
            blockself.activityIndicator.hidden = YES;

        }
    }];
    
    
}


-(void)loadWebView:(NSURL *) url competionBlock:(void(^)(BOOL)) completionBlook{
    NSURLRequest * request = [ NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    self.loadingCompleet = completionBlook;
    
    

}



- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    self.activityIndicator.hidden= NO;
    [self.activityIndicator startAnimating];
    
}



- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.loadingCompleet (YES);
    
}





@end
