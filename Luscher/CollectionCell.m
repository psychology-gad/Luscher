#import "CollectionCell.h"

@implementation CollectionCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
//    self.layer.cornerRadius = 5.0;
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    return self;
}
@end