#import "CollectionViewController.h"
#import "NewFlowLayout.h"
#import "CollectionCell.h"

@implementation CollectionViewController {
    NSArray *_colors;
}

#pragma mark - Initialization
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _colors = @[[UIColor luscherGrayColor], [UIColor luscherBlackColor], [UIColor luscherBlueColor], [UIColor luscherPurpleColor],
    [UIColor luscherBrownColor], [UIColor luscherOrangeColor], [UIColor luscherYellowColor], [UIColor luscherGreenColor]];
    
    [self.collectionView registerClass:[CollectionCell class] forCellWithReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Collection delegate and datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _colors.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.backgroundColor = _colors[indexPath.row];
    cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, 100, 100);
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NewFlowLayout *layout = (NewFlowLayout *)collectionView.collectionViewLayout;
    
    if ([layout.selectedPath isEqual:indexPath]) {
        [collectionView performBatchUpdates:^{
            layout.selectedPath = nil;
        } completion:nil];
    } else {
        [collectionView performBatchUpdates:^{
            layout.selectedPath = indexPath;
        } completion:nil];
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}
@end