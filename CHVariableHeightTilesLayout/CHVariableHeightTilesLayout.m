//
//  CHVariableHeightTilesLayout.m
//  CHVariableHeightTilesLayout
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

#import "CHVariableHeightTilesLayout.h"

@interface CHVariableHeightTilesLayout ()

@property (nonatomic, strong) NSMutableArray *indexPathGrid;
@property (nonatomic, strong) NSMutableDictionary *layoutAttributesDictionary;

@end

@implementation CHVariableHeightTilesLayout

- (CGSize)collectionViewContentSize {
    
    CGFloat contentWidth = CGRectGetWidth(self.collectionView.frame);
    CGFloat contentHeight = [self maxColumnHeightForCurrentIndexPathGrid] + self.bottomSpacing;
    
    return CGSizeMake(contentWidth, contentHeight);
}

- (CGFloat)maxColumnHeightForCurrentIndexPathGrid {
    
    CGFloat maxColumnHeight = 0.0;
    NSUInteger gridColumnCount = 0;
    
    if (self.indexPathGrid.count > 0) {
        
        gridColumnCount = [[self.indexPathGrid firstObject] count];
    }
    
    for (NSUInteger columnIndex = 0; columnIndex < gridColumnCount; columnIndex++) {
        
        CGFloat columnHeight = self.topSpacing;
        
        for (NSMutableArray *rowArray in self.indexPathGrid) {
            
            if (columnIndex < rowArray.count) {
                NSIndexPath *indexPath = rowArray[columnIndex];
                CGSize itemSize = [self sizeForItemAtIndex:indexPath.row];
                columnHeight += itemSize.height + self.verticalCellSpacing;
            }
        }
        
        if (columnHeight > maxColumnHeight) {
            
            maxColumnHeight = columnHeight;
        }
    }
    
    return maxColumnHeight;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray *layoutAttributes = [NSMutableArray array];
    NSInteger gridColumnCount = 0;
    
    if (self.indexPathGrid.count > 0) {
        
        gridColumnCount = [[self.indexPathGrid firstObject] count];
    }
    
    for (NSInteger columnIndex = 0; columnIndex < gridColumnCount; columnIndex++) {
        
        for (NSMutableArray *rowArray in self.indexPathGrid) {
            
            if ((NSInteger)rowArray.count <= columnIndex) {
                
                continue;
            }
            
            NSIndexPath *indexPath = rowArray[columnIndex];
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            
            if (CGRectIntersectsRect(attributes.frame, rect) == YES) {
                
                [layoutAttributes addObject:attributes];
            }
        }
    }
    
    return [layoutAttributes copy];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *indexString = [self indexStringForIndexPath:indexPath];
    UICollectionViewLayoutAttributes *attributes = self.layoutAttributesDictionary[indexString];
    
    if (attributes != nil) {
        
        return attributes;
    }
    
    CGRect frame;
    frame.origin = [self originForItemAtIndexPath:indexPath];
    frame.size = [self sizeForItemAtIndex:indexPath.row];
    
    attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = frame;
    
    self.layoutAttributesDictionary[indexString] = attributes;
    
    return attributes;
}

- (CGPoint)originForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat x = self.sideSpacing;
    CGFloat y = self.topSpacing;
    
    for (NSMutableArray *rowArray in self.indexPathGrid) {
        
        if ([rowArray containsObject:indexPath] == NO) {
            
            continue;
        }
        
        NSInteger row = [self.indexPathGrid indexOfObject:rowArray];
        NSInteger column = [rowArray indexOfObject:indexPath];
        
        if (row != 0) {
            
            NSIndexPath *indexPath = self.indexPathGrid[row - 1][column];
            NSString *indexString = [self indexStringForIndexPath:indexPath];
            UICollectionViewLayoutAttributes *attributes = self.layoutAttributesDictionary[indexString];
            y = CGRectGetMaxY(attributes.frame) + self.verticalCellSpacing;
        }
        
        if (column != 0) {
            
            NSIndexPath *indexPath = self.indexPathGrid[row][column - 1];
            NSString *indexString = [self indexStringForIndexPath:indexPath];
            UICollectionViewLayoutAttributes *attributes = self.layoutAttributesDictionary[indexString];
            x = CGRectGetMaxX(attributes.frame) + self.horizontalCellSpacing;
        }
    }
    
    return CGPointMake(x, y);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    [self clearLayoutData];
    
    return YES;
}

- (void)invalidateLayout {
    
    [self clearLayoutData];
    [super invalidateLayout];
}

- (void)clearLayoutData {
    
    _indexPathGrid = nil;
    _layoutAttributesDictionary = nil;
}

#pragma mark - Lazy Initializer

- (NSMutableArray *)indexPathGrid {
    
    if (_indexPathGrid == nil) {
        
        _indexPathGrid = [self buildIndexPathGrid];
    }
    
    return _indexPathGrid;
}

- (NSMutableDictionary *)layoutAttributesDictionary {
    
    if (_layoutAttributesDictionary == nil) {
        
        _layoutAttributesDictionary = [NSMutableDictionary dictionary];
    }
    
    return _layoutAttributesDictionary;
}

#pragma mark - Grid Building

- (NSMutableArray *)buildIndexPathGrid {
    
    NSMutableArray *indexPathGrid = [NSMutableArray array];
    
    NSInteger itemCount = [self totalItemCount];
    CGFloat accumulatedRowWidth = self.sideSpacing;
    
    NSMutableArray *newRowArray = [NSMutableArray array];
    [indexPathGrid addObject:newRowArray];
    
    for (NSInteger index = 0; index < itemCount; index++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        CGSize itemSize = [self sizeForItemAtIndex:indexPath.row];
        CGFloat newWidth = accumulatedRowWidth + itemSize.width;
        
        if (newWidth < (CGRectGetWidth(self.collectionView.frame) - self.sideSpacing)) {
            
            accumulatedRowWidth = newWidth + self.horizontalCellSpacing;
            NSMutableArray *currentRow = [indexPathGrid lastObject];
            [currentRow addObject:indexPath];
        } else {
            
            accumulatedRowWidth = self.sideSpacing + itemSize.width;
            NSMutableArray *newRowArray = [NSMutableArray array];
            [newRowArray addObject:indexPath];
            [indexPathGrid addObject:newRowArray];
        }
    }
    
    return indexPathGrid;
}

#pragma mark - Helper Methods

- (NSUInteger)totalItemCount {
    
    if (self.dataSource != nil) {
        
        return [self.dataSource totalItemCount];
    }
    
    return 0;
}

- (CGSize)sizeForItemAtIndex:(NSUInteger)index {
    
    if (self.dataSource != nil) {
        
        return [self.dataSource sizeForItemAtIndex:index];
    }
    
    return CGSizeZero;
}

- (NSString *)indexStringForIndexPath:(NSIndexPath *)indexPath {
    
    return [NSString stringWithFormat:@"%li", (long)indexPath.row];
}

@end
