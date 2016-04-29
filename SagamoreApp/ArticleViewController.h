//
//  ArticleViewController.h
//  SagamoreApp
//
//  Created by Daniel Katz on 4/28/16.
//  Copyright © 2016 Stratton Design. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
