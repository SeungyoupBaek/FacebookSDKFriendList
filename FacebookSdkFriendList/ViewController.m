//
//  ViewController.m
//  FacebookSdkFriendList
//
//  Created by SDT-1 on 2014. 1. 21..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ViewController{
    NSArray *_friends;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _friends.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FRIEND_CELL"];
    NSDictionary<FBGraphUser> *friendList;
    friendList = _friends[indexPath.row];
    
    cell.textLabel.text = friendList.name;
    
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _friends = [[NSArray alloc] init];
    FBLoginView *loginView = [[FBLoginView alloc] init];
    // Align the button in the center horizontally
    loginView.frame = CGRectOffset(loginView.frame, (self.view.center.x - (loginView.frame.size.width / 2)), 5);
    [self.view addSubview:loginView];
    
    FBRequest* friendsRequest = [FBRequest requestForMyFriends];
    [friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                  NSDictionary* result,
                                                  NSError *error) {
        _friends = [result objectForKey:@"data"];
        NSLog(@"Found: %d friends", (int)_friends.count);
        for (NSDictionary<FBGraphUser>* friend in _friends) {
            NSLog(@"I have a friend named %@ with id %@", friend.name, friend.id);
        }
        [self.table reloadData];
    }];

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
