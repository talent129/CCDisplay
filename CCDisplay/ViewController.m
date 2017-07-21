//
//  ViewController.m
//  CCDisplay
//
//  Created by luckyCoderCai on 2017/7/21.
//  Copyright © 2017年 luckyCoderCai. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "JianshuController.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
static NSInteger kWidth = 65;
static NSTimeInterval kAnimationInterval = 0.25;

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *displayView;

@end

@implementation ViewController

#pragma mark -lazy load
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 80;
        
    }
    return _tableView;
}

- (UIView *)displayView
{
    if (!_displayView) {
        _displayView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth - kWidth, kScreenHeight/3 * 2.0, 60, 60)];
        _displayView.backgroundColor = [UIColor brownColor];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"致粉丝的一封信";
        label.textColor = [UIColor orangeColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        label.numberOfLines = 0;
        [_displayView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(@3);
            make.trailing.equalTo(@-3);
            make.top.equalTo(@5);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [_displayView addGestureRecognizer:tap];
    }
    return _displayView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"京东金融";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(@0);
        make.top.equalTo(self.mas_topLayoutGuide);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
    
    [self.view addSubview:self.displayView];
    
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *iden = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:iden];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = @"text";
    cell.detailTextLabel.text = @"detail";
    
    return cell;
}

//开始拖拽 隐藏悬浮框
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:kAnimationInterval animations:^{
        self.displayView.frame = CGRectMake(kScreenWidth, kScreenHeight/3 * 2.0, 60, 60);
    }];
}

//结束拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {//当滑动停止后 显示悬浮框
        [UIView animateWithDuration:kAnimationInterval animations:^{
            self.displayView.frame = CGRectMake(kScreenWidth - kWidth, kScreenHeight/3 * 2.0, 60, 60);
        }];
    }
    
    NSLog(@"---");
}

//快速滑动 减速后 响应此代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:kAnimationInterval animations:^{
        self.displayView.frame = CGRectMake(kScreenWidth - kWidth, kScreenHeight/3 * 2.0, 60, 60);
    }];
    
    NSLog(@"---=====");
}

- (void)tapAction
{
    JianshuController *jianshu = [[JianshuController alloc] init];
    jianshu.urlString = @"http://www.jianshu.com";
    [self.navigationController pushViewController:jianshu animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
