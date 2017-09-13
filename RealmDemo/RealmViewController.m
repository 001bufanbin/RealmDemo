//
//  RealmViewController.m
//  RealmDemo
//
//  Created by bufb on 2017/9/12.
//  Copyright © 2017年 kris. All rights reserved.
//

#import "RealmViewController.h"

#import "PersonModel.h"

@interface RealmViewController ()

@end

@implementation RealmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"RealmData" ofType:@"plist"];
    id returnData = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    NSArray *data = [returnData objectForKey:@"data"];

    // Mark : - 增
    for (NSDictionary *dic in data) {
        PersonModel *person = [[PersonModel alloc]initWithValue:dic];
        person.languages = [dic objectForKey:@"languages"];
        [PersonModel addObject:person];
    }

//    // MARK: - 查、改
//    RLMResults *models = [PersonModel allObjects];
//    for (PersonModel *person in models) {
//        [PersonModel updateWithBlock:^{
//            person.firstName = @"Wang";
//        }];
//    }

//    // MARK: - 删
//    [PersonModel deleteAllObjects];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
