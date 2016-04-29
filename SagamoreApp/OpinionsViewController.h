//
//  OpinionsViewController.h
//  SagamoreApp
//
//  Created by Daniel Katz on 4/28/16.
//  Copyright © 2016 Stratton Design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWFeedParser.h"
#import "NSString+HTML.h"
#import "GTMNSString+HTML.h"
#import "dataClass.h"
@interface OpinionsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
