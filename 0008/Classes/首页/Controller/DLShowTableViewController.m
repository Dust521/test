//
//  DLShowTableViewController.m
//  0008
//
//  Created by 董亮 on 2018/11/28.
//  Copyright © 2018 董亮. All rights reserved.
//

#import "DLShowTableViewController.h"
#import "DLVegetable.h"
#import "DLDetailViewController.h"

#import "UIImageView+WebCache.h"

#define MyServer [NSString stringWithFormat:@"http://39.96.8.115/images/201901/201901001.png"]



@interface DLShowTableViewController ()<UITableViewDataSource,UITextViewDelegate>
//
@property (nonatomic, strong) NSArray *vegetables;


@end

@implementation DLShowTableViewController

//

//- (void)setShucai:(NSArray *)shucai
//{
//    _shucai = shucai;
//    [self.tableView reloadData];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // self.tableView.dataSource = self;
    
    
    NSLog(@"shucai顺利传过来，蔬菜是：%@",self.shucai);
    
    
     self.tableView.rowHeight = 100;
     self.tableView.scrollEnabled = YES;
    

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    //return self.vegetables.count;
    return self.shucai.count;
    //NSLog(@"%lu",self.vegetables.count);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *ID = @"veg";
   
    // Configure the cell...
    
    // 1. 获取模型数据
  //  DLVegetable *model = self.vegetables[indexPath.row];
      DLVegetable *model = self.shucai[indexPath.row];
    // 2. 创建单元格
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];

    // 3. 把模型数据设置给单元格  SDWebImage框架
    NSString *string = model.imageUrl;
    NSString *imageStr = [string substringToIndex:6];//截取掉下标6之前的字符串
    
    UIImage *defaultImg = [UIImage imageNamed:@"defaultimage"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://39.96.8.115/images/%@/%@.png",imageStr,model.imageUrl]]placeholderImage:defaultImg options:SDWebImageRefreshCached];
    
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.intro;
    
    NSLog(@"截取掉下标5之前的字符串:%@",imageStr);
    // 要在单元格的最右边显示一个小箭头, 所以要设置单元格对象的某个属性
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // 可以自定义单元格右边的accessory。
    //cell.accessoryView = [[UISwitch alloc] init];
    
    // 4. 返回单元格
    return cell;
}

#pragma mark - 懒加载数据
//- (NSArray *)vegetables
//{
//    if (_vegetables == nil) {
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"vegtable.plist" ofType:nil];
//        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
//        NSMutableArray *arrayModels = [NSMutableArray array];
//        for (NSDictionary *dict in arrayDict) {
//            DLVegetable *model = [DLVegetable vegetablesWithDict:dict];
//            [arrayModels addObject:model];
//        }
//        _vegetables = arrayModels;
//    }
//    return _vegetables;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//      TableViewController *tableVC = (TableViewController*)[self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(self.class)];
    DLDetailViewController *detailViewController = [[DLDetailViewController alloc] init];
    [self.navigationController pushViewController:detailViewController animated:YES];
    NSLog(@"jjjjjjjj");
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
