//
//  ViewController.m
//  PYqiandao
//
//  Created by Apple on 16/8/16.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "RootViewController.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.


}

- (IBAction)buttonAA:(UIButton *)sender {
    RootViewController *rootVC = [[RootViewController alloc] init];
    [self presentViewController:rootVC animated:NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
