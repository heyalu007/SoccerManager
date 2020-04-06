//
//  VedioCell.m
//  SoccerManager
//
//  Created by 何亚鲁 on 16/1/31.
//  Copyright © 2016年 ihandysoft. All rights reserved.
//

#import "VedioCell.h"
#import "VedioModel.h"
#import "VedioCellBackgroundView.h"
#import "UIImageView+WebCache.h"
#import "VedioPlayView.h"
#import "Util.h"

@interface VedioCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timelabel;
@property (weak, nonatomic) IBOutlet UIView *playView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation VedioCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    VedioCellBackgroundView *backgroundView = [[VedioCellBackgroundView alloc] init];
    self.backgroundView = backgroundView;
    
//    VedioPlayView *imageView = [[VedioPlayView alloc] initWithFrame:self.playView.bounds];
//    [self.playView addSubview:imageView];
    // 画圆
    self.imageView.layer.cornerRadius = 30;
    // 超出layer边框的全部裁剪掉
    self.imageView.layer.masksToBounds = YES;
    // 边框
    self.imageView.layer.borderColor = RGBColor(108, 180, 247, 0.7).CGColor;
    self.imageView.layer.borderWidth = 2;
}

- (void)loadContent:(VedioModel *)vedioModel {
    self.titleLabel.text = vedioModel.title;
    self.timelabel.text = vedioModel.updatetime;
    NSString *tempString = [self urlFromString:vedioModel.filename];
    NSString *urlString = [NSString stringWithFormat:@"http://tu.zhibo8.cc/uploads/thumb/zuqiu/2016/%@.jpg",tempString];
    NSURL *url = [NSURL URLWithString:urlString];
    //http://tu.zhibo8.cc/uploads/thumb/zuqiu/2016/0204/renyiqiu.jpg
    [self.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"default_new.png"] completed:nil];
}


/**
 *  递归进行字符串计算
 *  比如：把@"0204-guomi-jijin"转换为0204/guomi/jijin
 */
- (NSString *)urlFromString:(NSString *)string {

    NSRange range = [string rangeOfString:@"-"];
    if (range.location != NSNotFound) {
        NSString *string1 = [string substringToIndex:range.location];
        NSString *string2 = [string substringFromIndex:range.location + 1];
        NSString *path = [NSString stringWithFormat:@"%@/%@",string1,string2];
        string = [self urlFromString:path];
    }
    return string;
}




@end
