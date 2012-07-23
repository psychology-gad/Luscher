#import "CollectionViewController.h"
#import "NewFlowLayout.h"
#import "CollectionCell.h"

@implementation CollectionViewController {
    NSArray *_colors;
    NSMutableArray *_luscherNumbers;
    BOOL _LuschersSelected;
    BOOL _attempts;
}

#pragma mark - Initialization
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _colors = @[[UIColor luscherBlueColor], [UIColor luscherGreenColor], [UIColor luscherOrangeColor], [UIColor luscherYellowColor],
    [UIColor luscherPurpleColor], [UIColor luscherBrownColor], [UIColor luscherGrayColor], [UIColor luscherBlackColor]];
    
    _luscherNumbers = [NSMutableArray arrayWithCapacity:_colors.count];
    
    [self.collectionView registerClass:[CollectionCell class] forCellWithReuseIdentifier:@"Cell"];
    
    _LuschersSelected = 0;
    _attempts = 0;
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
//    NewFlowLayout *layout = (NewFlowLayout *)collectionView.collectionViewLayout;
//    
//    if ([layout.selectedPath isEqual:indexPath]) {
//        [collectionView performBatchUpdates:^{
//            layout.selectedPath = nil;
//        } completion:nil];
//    } else {
//        [collectionView performBatchUpdates:^{
//            layout.selectedPath = indexPath;
//        } completion:nil];
//    }
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.alpha = 0.0;
    
    [_luscherNumbers addObject:@(indexPath.row)];
    
    _LuschersSelected++;
    if (_LuschersSelected == _colors.count) {
        
        if (_attempts == 0) {
            _attempts++;
            [[[BSAlert alloc] initWithTitle:@"Luschers" message:@"Once more" delegate:nil
                          cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
            [self newLuscher];
        } else {
            NSString *luscherString = @"";
            for (int i = 0; i < _luscherNumbers.count; i++) {
                if (i != (_luscherNumbers.count - 1))
                    luscherString = [luscherString stringByAppendingFormat:@"%@ - ",_luscherNumbers[i]];
                else
                    luscherString = [luscherString stringByAppendingFormat:@"%@",_luscherNumbers[i]];
            }
            
            [[[BSAlert alloc] initWithTitle:@"Luschers" message:luscherString delegate:self
                          cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
        }
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)newLuscher {
    _LuschersSelected = 0;
    for (int i = 0; i < 8; i++) {
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        cell.alpha = 1.0;
    }
}

#pragma mark - Alert delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    _LuschersSelected = 0;
    [_luscherNumbers removeAllObjects];
    _attempts = 0;
    for (int i = 0; i < 8; i++) {
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        cell.alpha = 1.0;
    }
}
@end