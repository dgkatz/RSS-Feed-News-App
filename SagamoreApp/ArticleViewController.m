//
//  ArticleViewController.m
//  SagamoreApp
//
//  Created by Daniel Katz on 4/28/16.
//  Copyright © 2016 Stratton Design. All rights reserved.
//

#import "ArticleViewController.h"
#import "dataClass.h"
@interface ArticleViewController ()

@end

@implementation ArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
    self.webView.delegate = self;

    
    dataClass *obj = [dataClass getInstance];
    

    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:obj.feedItem.link]]];

    // Do any additional setup after loading the view.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webview method called");
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('mobile_menu_icon').style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('sitetitle')[0].style.visibility = 'hidden'"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
