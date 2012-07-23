#import "NewFlowLayout.h"

@implementation NewFlowLayout

#pragma mark - Wake
- (void)awakeFromNib {
    self.sectionInset = UIEdgeInsetsMake(15.0, 15.0, 15.0, 15.0);
}

#pragma mark - Stuff
#define DEGREES_TO_RADIANS(degrees) degrees * (M_PI / 180)
- (void)rotateIfSelectedForAttributes:(UICollectionViewLayoutAttributes *)attributes {
    if ([attributes.indexPath isEqual:self.selectedPath]) {
        attributes.alpha = 1.0;
                attributes.size = CGSizeMake(attributes.size.width * 1.2, attributes.size.height * 1.2);
        attributes.transform3D = CATransform3DMakeRotation(DEGREES_TO_RADIANS(12), 0.0, 0.0, 1.0);
        attributes.zIndex = 1;
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *allAttributes = [super layoutAttributesForElementsInRect:rect];
    for (UICollectionViewLayoutAttributes *attributes in allAttributes) {
        attributes.alpha = 1.0;
        [self rotateIfSelectedForAttributes:attributes];
    }
    return allAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    [self rotateIfSelectedForAttributes:attributes];
    return attributes;
}

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForInsertedItemAtIndexPath:(NSIndexPath *)itemIndexPath {
//    NSLog(@"initial");
    UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    attributes.alpha = 0.0;
    attributes.center = self.collectionView.center;
    return attributes;
}

- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDeletedItemAtIndexPath:(NSIndexPath *)itemIndexPath {
//    NSLog(@"final");
    UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    attributes.alpha = 0.0;
    attributes.center = self.collectionView.center;
    attributes.transform3D = CATransform3DMakeScale(0.1, 0.1, 1.0);
    return attributes;
}

- (void)setSelectedPath:(NSIndexPath *)selectedPath {
    _selectedPath = selectedPath;
    [self invalidateLayout];
}
@end