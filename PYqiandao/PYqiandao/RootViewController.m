//
//  RootViewController.m
//  PYqiandao
//
//  Created by Apple on 16/8/26.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
@property (nonatomic, strong) UIButton *button;

@end
static  NSString *s;
@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    _button.frame = CGRectMake(100, 100, 100, 100);
    
    //上次签到日期
//    NSDate *date_1 = [self dateStringToDate:s];
    NSLog(@"上次签到日期(0点)%@", s);
    //获取今天
    NSDate *date = [self getInternetDate];
        NSString *str = [self dateToDateString:date];
    NSLog(@"获取今天日期%@", str);
    
    /*
     NSComparisonResult取值
     NSOrderedAscending = -1L, 升序（右>左）
     NSOrderedSame, 相同
     NSOrderedDescending, 降序（右<左）
     */
    //日期比较
    NSComparisonResult result = [s compare:str];
    if (result == NSOrderedAscending) {
        [_button setTitle:@"签到" forState:(UIControlStateNormal)];

    } else {
        if (s == nil) {
            [_button setTitle:@"签到" forState:(UIControlStateNormal)];

        } else {
            [_button setTitle:@"已签到" forState:(UIControlStateNormal)];
            _button.userInteractionEnabled = NO;
        }

    }
    
    [_button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_button];
    
    //返回按钮
    UIButton *butt = [UIButton buttonWithType:(UIButtonTypeSystem)];
    butt.frame = CGRectMake(100, 200, 100, 100);
    [butt setTitle:@"返回" forState:(UIControlStateNormal)];
    [butt addTarget:self action:@selector(buttonfanhui) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:butt];
}

//签到
- (void)buttonAction:(UIButton *)button {
//    if (!button.selected) {
        [button setTitle:@"已签到" forState:(UIControlStateNormal)];
        NSLog(@"签到成功, 积分+10");
        button.userInteractionEnabled = NO;
        NSDate *date = [self getInternetDate];
        s = [self dateToDateString:date];
        NSLog(@"记录签到日期%@", s);//日期
//    }
}
//返回
- (void)buttonfanhui {
    [self dismissViewControllerAnimated:NO completion:nil];
}

//获取网络时间
- (NSDate *)getInternetDate
{
    NSString *urlString = @"http://m.baidu.com";
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString: urlString]];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request setTimeoutInterval: 2];
    [request setHTTPShouldHandleCookies:FALSE];
    [request setHTTPMethod:@"GET"];
    NSHTTPURLResponse *response;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    NSString *date = [[response allHeaderFields] objectForKey:@"Date"];
    date = [date substringFromIndex:5];
    date = [date substringToIndex:[date length]-4];
    NSDateFormatter *dMatter = [[NSDateFormatter alloc] init];
    dMatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dMatter setDateFormat:@"dd MMM yyyy HH:mm:ss"];
    NSDate *netDate = [[dMatter dateFromString:date] dateByAddingTimeInterval:60*60*8];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: netDate];
    NSDate *localeDate = [netDate  dateByAddingTimeInterval: interval];
    return localeDate;
}
//获取当地时间
- (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}
//将字符串转成NSDate类型
- (NSDate *)dateStringToDate:(NSString *)dateString{ //字符串转化为日期
    //实例化一个NSDateFormatter对象
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //设置GMT市区，保证转化后日期字符串与日期一致
    
    NSTimeZone *timezone = [[NSTimeZone alloc] initWithName:@"GMT"];
    
    [dateFormatter setTimeZone:timezone];
    
    //转化date为日期字符串
    
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    return date;
    
}
//日期转化为字符串
- (NSString *)dateToDateString:(NSDate *)date{
    //实例化一个NSDateFormatter对象
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //设置GMT市区，保证转化后日期字符串与日期一致
    
    NSTimeZone *timezone = [[NSTimeZone alloc] initWithName:@"GMT"];
    
    [dateFormatter setTimeZone:timezone];
    
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    return dateString;
    
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
