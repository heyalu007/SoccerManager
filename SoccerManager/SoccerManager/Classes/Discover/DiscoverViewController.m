
#import "DiscoverViewController.h"
#import "Util.h"
#import "CellBackgroundView.h"
#import "PictureViewController.h"
#import "OthersViewController.h"
#import "ClearImageCacheTool.h"

#import "TestViewController.h"

@interface DiscoverViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@end

static NSInteger const kCircleCellIndex = 0;
static NSInteger const kDiscussCellIndex = 1;
static NSInteger const kGuessCellIndex = 2;
static NSInteger const kPictureCellIndex = 3;
static NSInteger const kOthersCellIndex = 4;

/**
 *  修改imageView的大小
 *
 *  @param imageView 要修改的imageView
 *  @param size      希望的尺寸
 */
static void drawImageView(UIImageView *imageView, CGSize size) {
    
    UIGraphicsBeginImageContext(size);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    [imageView.image drawInRect:rect];
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndPDFContext();
}

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(240, 239, 245, 1.0);
    //去掉所有分割线;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    //不使用cell的重用机制;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    UIImage *image = nil;
    NSString *title = nil;
    CellLineStyle style;
    switch (indexPath.section) {
        case kCircleCellIndex:
            image = [UIImage imageNamed:@"more_circle.png"];
            title = @"圈子";
            style = CellLineTypeTop | CellLineTypeMiddle;
            break;
            
        case kDiscussCellIndex:
            image = [UIImage imageNamed:@"more_discuss.png"];
            title = @"论坛";
            style = CellLineTypeButtom;
            break;
        case kGuessCellIndex:
            image = [UIImage imageNamed:@"more_guess.png"];
            title = @"竞猜";
            style = CellLineTypeTop | CellLineTypeButtom;
            break;
        case kPictureCellIndex:
            image = [UIImage imageNamed:@"more_pictrue.png"];
            title = @"图片";
            style = CellLineTypeTop | CellLineTypeButtom;
            break;
        case kOthersCellIndex:
            image = [UIImage imageNamed:@"more_pictrue.png"];
            title = @"其它";
            style = CellLineTypeTop | CellLineTypeButtom;
            break;
            
        default:
            break;
    }
    
    //设置图片;
    cell.imageView.image = image;
    //设置图片大小;
    drawImageView(cell.imageView, CGSizeMake(30, 30));
    //设置title;
    cell.textLabel.text = title;
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0];
    //右箭头;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //设置cell的边界线;
    CellBackgroundView *backgroundView = [[CellBackgroundView alloc] initWithFrame:cell.bounds style:style];
    [backgroundView setNeedsDisplay];
    cell.backgroundView = backgroundView;
    return cell;
}



#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if(section == kDiscussCellIndex) {
        return 0;
    }
    return 30.0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case kCircleCellIndex:
        {
            TestViewController *vc = [TestViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            
            break;
        case kDiscussCellIndex:
            ;
            break;
        case kGuessCellIndex:
            ;
            break;
        case kPictureCellIndex:
            {
                PictureViewController *vc = [[PictureViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
        case kOthersCellIndex:
            {
                OthersViewController *vc = [[OthersViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
            
        default:
            break;
    }
    //    [self.navigationController pushViewController:vc animated:YES];
}



@end
