//
//  ViewController.m
//  ExBlock
//
//  Created by Pavel Tsybulin on 10/7/16.
//  Copyright © 2016 Pavel Tsybulin. All rights reserved.
//

#import "ViewController.h"
#import "BlockRule.h"
#import <SafariServices/SafariServices.h>

#define BLOCKER_EXTENSION @"com.tsybulin.ExBlock.ExBlocker"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray<BlockRule *> *rules ;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *teUrl;
@property (weak, nonatomic) IBOutlet UISwitch *swBlock;

- (IBAction)onSave:(id)sender;
- (IBAction)onDone:(id)sender;
- (IBAction)onAdd:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad] ;
    
    rules = [NSMutableArray array] ;
    [self loadRules] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loadRules {
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] ;
    NSString *path = [documentDirectory stringByAppendingPathComponent:@"blockerList.json"] ;
    NSData *data ;
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        data = [NSData dataWithContentsOfFile:path] ;
    } else {
        data = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"blockerList" withExtension:@"json"]] ;
    }
    NSError *error = nil ;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error] ;
    for (NSDictionary *dic in array) {
        [rules addObject:[[BlockRule alloc] initWithDictionary:dic]] ;
    }
    
    [SFContentBlockerManager reloadContentBlockerWithIdentifier:BLOCKER_EXTENSION completionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Reload error %@", error) ;
        }
    }] ;
}

#pragma mark Actions

- (IBAction)onSave:(id)sender {
    NSError *error = nil ;
    
    NSMutableArray<NSDictionary *> *dicts = [NSMutableArray array] ;
    for (BlockRule *rule in rules) {
        [dicts addObject:[rule toDictionary]] ;
    }
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dicts options:NSJSONWritingPrettyPrinted error:&error] ;
    
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] ;
    NSString *path = [documentDirectory stringByAppendingPathComponent:@"blockerList.json"] ;
    
    if (![data writeToFile:path options:NSDataWritingFileProtectionNone error:&error]) {
        NSLog(@"Write error: %@", error) ;
    } else {
        [SFContentBlockerManager reloadContentBlockerWithIdentifier:BLOCKER_EXTENSION completionHandler:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"Reload error %@", error) ;
            }
        }] ;
    }
}

- (IBAction)onDone:(id)sender {
    self.editing = NO ;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow] ;
    if (!indexPath) {
        return ;
    }
    rules[indexPath.row].action.type = self.swBlock.isOn ? @"block" : @"allow" ;
    rules[indexPath.row].trigger.urlFilter = self.teUrl.text ;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle] ;
    self.teUrl.text = @"" ;
}

- (IBAction)onAdd:(id)sender {
    [rules addObject:[[BlockRule alloc] init]] ;
    [self.tableView reloadData] ;
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return rules.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RuleCell"] ;
    return cell ;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [rules removeObjectAtIndex:indexPath.row] ;
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade] ;
    }
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = rules[indexPath.row].trigger.urlFilter ;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.teUrl.text = rules[indexPath.row].trigger.urlFilter ;
    self.swBlock.on = [rules[indexPath.row].action.type isEqualToString:@"block"] ;
}

@end
