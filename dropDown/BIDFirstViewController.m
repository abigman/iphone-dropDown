//
//  BIDFirstViewController.m
//  TestKim
//
//  Created by dep2 on 3/29/13.
//  Copyright (c) 2013 dep2. All rights reserved.
//

#import "BIDFirstViewController.h"

@interface BIDFirstViewController ()


@end

@implementation BIDFirstViewController{
    NSMutableDictionary *dicClicked;
}
@synthesize dataList;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"查看日志", @"first");
        //self.tabBarItem.titlePositionAdjustment=UITabBarSystemItemMostRecent;
        //[self.tabBarItem.titlePositionAdjustment];
        //self.tabBarItem.
        //self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //NSArray * arr=[[NSArray alloc]initWithObjects:@"1123123qqq",@"2",@"3",@"1123123qqq",@"2",@"3",@"1123123qqq",@"2",@"3",@"1123123qqq",@"2",@"3", nil];
    //dataList=arr;
    UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg.png"]];
    [self.tableView setBackgroundView:imageview];
    dicClicked = [NSMutableDictionary dictionaryWithCapacity:3];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellWithIdentifier];
    }
    
    
    NSUInteger row = [indexPath row];
    NSDictionary *rowData = [dataList objectAtIndex:row];
    
    
    CGSize size = [[rowData objectForKey:@"body"] sizeWithFont:[UIFont fontWithName:@"Helvetica" size:14] constrainedToSize:CGSizeMake(300,20000)];
    
    float fHeight = size.height + 16.0f;   
    
    for (UIView * subview in [cell.contentView subviews]) {
        [subview removeFromSuperview];
        
    }
    
    UITextView *tView=[[UITextView alloc]initWithFrame:CGRectMake(8,40,285.0f,fHeight)];
    tView.text=[rowData objectForKey:@"body"];
    tView.backgroundColor=[UIColor clearColor];
    tView.editable=NO;
    tView.tag=row;
   
    [cell.contentView addSubview: tView];
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10,10,220.0f,20)];
    titleLabel.text= [rowData objectForKey:@"title"];
    titleLabel.backgroundColor=[UIColor clearColor];
    [cell.contentView addSubview:titleLabel];

    UILabel *dateLabel=[[UILabel alloc]initWithFrame:CGRectMake(230,10,70.0f,20)];
    dateLabel.text= [rowData objectForKey:@"date"];
    dateLabel.textColor=[UIColor grayColor];
    dateLabel.backgroundColor=[UIColor clearColor];
    dateLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(12.0)];
    [cell.contentView addSubview:dateLabel];
    
    if ([dicClicked objectForKey:indexPath]) {
        tView.hidden=NO;
    }else{
        tView.hidden=YES;
    }
    
    //cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([dicClicked objectForKey:indexPath]) {
        NSUInteger row = [indexPath row];
        NSDictionary *rowData = [dataList objectAtIndex:row];
        
        
        CGSize size = [[rowData objectForKey:@"body"] sizeWithFont:[UIFont fontWithName:@"Helvetica" size:14] constrainedToSize:CGSizeMake(300,20000)];
        
        float fHeight = size.height + 45.0f;
        
        return fHeight;
    }else{
        return 45.0f;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //将索引加到数组中
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    //判断选中不同row状态时候
    if (![dicClicked objectForKey:indexPath]) {
        [dicClicked setObject:@"open" forKey:indexPath];
    }else{
        [dicClicked removeObjectForKey:indexPath];
    }

    //刷新
    [tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}
-(void)viewWillAppear:(BOOL)animated{
    NSArray *storeFilePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *doucumentsDirectiory = [storeFilePath objectAtIndex:0];
    NSString *plistPath =[doucumentsDirectiory stringByAppendingPathComponent:@"diary.plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if( [fileManager fileExistsAtPath:plistPath]== NO ) {
        NSError *error;
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"diary" ofType:@"plist"];
        [fileManager copyItemAtPath:bundle toPath:plistPath error:&error];
    }
    //NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"diary" ofType:@"plist"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    NSMutableArray *tmpDataArray = [[NSMutableArray alloc] init];
    
    for (int i=0; i<[dictionary count]; i++) {
        NSString *key = [[NSString alloc] initWithFormat:@"%i", i+1];
        NSDictionary *tmpDic = [dictionary objectForKey:key];
        [tmpDataArray addObject:tmpDic];
    }
    dataList = [tmpDataArray copy];
    [self.tableView reloadData];
}
@end
