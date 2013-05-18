//
//  BIDFirstViewController.h
//  TestKim
//
//  Created by dep2 on 3/29/13.
//  Copyright (c) 2013 dep2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BIDFirstViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) NSArray *dataList;

@property (strong,nonatomic) IBOutlet UITableView *tableView;

@end
