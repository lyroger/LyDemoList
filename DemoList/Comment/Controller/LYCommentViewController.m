//
//  LYCommentViewController.m
//  DemoList
//
//  Created by Mac on 2018/6/11.
//  Copyright © 2018年 luoyan. All rights reserved.
//

#import "LYCommentViewController.h"
#import "CommentTableHeadView.h"
#import "CommentData.h"
#import "CommentCell.h"
#import "ReplyListCell.h"
#import "CommentFooterView.h"

@interface LYCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableViewComment;
@property (nonatomic,strong) CommentData *comment;
@property (nonatomic,strong) CommentTableHeadView *tableHeadView;
@end

@implementation LYCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubView];
    // Do any additional setup after loading the view.
}

- (CommentTableHeadView*)tableHeadView
{
    if (!_tableHeadView) {
        _tableHeadView = [[CommentTableHeadView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [CommentTableHeadView getHeaderViewHeight:self.comment])];
        [_tableHeadView model:self.comment];
    }
    return _tableHeadView;
}

- (void)loadSubView
{
    self.comment = [CommentData mj_objectWithKeyValues:[self readLocalFileWithName:@"CommentData"]];
    self.tableViewComment = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.tableViewComment registerClass:[CommentCell class] forHeaderFooterViewReuseIdentifier:@"CommentCell"];
    [self.tableViewComment registerClass:[CommentFooterView class] forHeaderFooterViewReuseIdentifier:@"CommentFooterView"];
    [self.tableViewComment registerClass:[ReplyListCell class] forCellReuseIdentifier:@"ReplyListCell"];
    self.tableViewComment.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableViewComment.tableHeaderView = self.tableHeadView;
    self.tableViewComment.tableFooterView = nil;
    self.tableViewComment.delegate = self;
    self.tableViewComment.dataSource = self;
    self.tableViewComment.estimatedRowHeight = 60;
    self.tableViewComment.rowHeight = UITableViewAutomaticDimension;
    [self.contentView addSubview:self.tableViewComment];
    [self.tableViewComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        make.bottom.equalTo(@(-50));
    }];
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CommentCell *cellHead = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CommentCell"];
    ReplyList *reply = [self.comment.comments.replyList objectAtIndex:section];
    [cellHead model:reply];
    return cellHead;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == self.comment.comments.replyList.count-1) {
        return 0.001;
    } else {
        ReplyList *reply = [self.comment.comments.replyList objectAtIndex:section];
        if (reply.replyList.count) {
            return 15;
        } else {
            return 1;
        }
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == self.comment.comments.replyList.count-1) {
        return nil;
    } else {
        CommentFooterView *footerSplitView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CommentFooterView"];
        return footerSplitView;
    }

}

#pragma mark UITableViewDataSouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.comment.comments.replyList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ReplyList *reply = [self.comment.comments.replyList objectAtIndex:section];
    NSInteger count = reply.replyList.count;
    return count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReplyListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReplyListCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ReplyList *replys = [self.comment.comments.replyList objectAtIndex:indexPath.section];
    NSArray *replyArray = [replys.replyList objectAtIndex:indexPath.row];
    NSDictionary *dic = [replyArray objectAtIndex:0];
    ReplyList *reply = [ReplyList mj_objectWithKeyValues:dic];
    [cell model:reply];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 读取本地JSON文件
- (NSDictionary *)readLocalFileWithName:(NSString *)name {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}
@end
