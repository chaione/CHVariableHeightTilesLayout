//
//  CHViewController.m
//  CHVariableHeightTilesLayoutExample
//
//  Copyright (c) 2014 ChaiOne <http://www.chaione.com/>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "CHViewController.h"
#import "CHCollectionViewCell.h"
#import "CHVariableHeightTilesLayout.h"

static NSString * const CHCollectionViewCellIdentifier = @"CHCollectionViewCellIdentifier";

@interface CHViewController () <UICollectionViewDataSource, CHVariableHeightTilesLayoutDataSource>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end

@implementation CHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CHVariableHeightTilesLayout *variableHeightTilesLayout = [[CHVariableHeightTilesLayout alloc] init];
    variableHeightTilesLayout.topSpacing = 5.0;
    variableHeightTilesLayout.bottomSpacing = 5.0;
    variableHeightTilesLayout.sideSpacing = 10.0;
    variableHeightTilesLayout.horizontalCellSpacing = 20.0;
    variableHeightTilesLayout.verticalCellSpacing = 20.0;
    variableHeightTilesLayout.dataSource = self;
    self.collectionView.collectionViewLayout = variableHeightTilesLayout;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CHCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CHCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.titleLabel.text = [NSString stringWithFormat:@"%li", (long)indexPath.row];
    return cell;
}

#pragma mark - CHVariableHeightTilesLayoutDataSource

- (NSUInteger)totalItemCount {
    return 20;
}

- (CGSize)sizeForItemAtIndex:(NSUInteger)index {
    CGFloat height = 250.0 + (index * 10);
    return CGSizeMake(235.0, height);
}

@end
