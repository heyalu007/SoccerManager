

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, CellLineStyle) {
    CellLineTypeNone        = 0,
    CellLineTypeMiddle      = 1 << 0,
    CellLineTypeButtom      = 1 << 1,
    CellLineTypeTop         = 1 << 2,
};

@interface CellBackgroundView : UIView

- (instancetype)initWithFrame:(CGRect)frame style:(CellLineStyle)style;

@end
