//
//  CHVariableHeightTilesLayout.h
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

#import <UIKit/UIKit.h>

@protocol CHVariableHeightTilesLayoutDataSource;

/**
 Custom collection view layout that has the same vertical spacing between all cells.
 */
@interface CHVariableHeightTilesLayout : UICollectionViewLayout

/**
 The receiver's data source.
 */
@property (nonatomic, weak) id<CHVariableHeightTilesLayoutDataSource> dataSource;

/**
 The spacing on the top of the collection view. Defaults to 0.
 */
@property (nonatomic, assign) CGFloat topSpacing;

/**
 The spacing on the bottom of the collection view. Defaults to 0.
 */
@property (nonatomic, assign) CGFloat bottomSpacing;

/**
 The spacing on the sides of the collection view. Defaults to 0.
 */
@property (nonatomic, assign) CGFloat sideSpacing;

/**
 The vertical spacing between cells. Defaults to 0.
 */
@property (nonatomic, assign) CGFloat verticalCellSpacing;

/**
 The horizontal spacing between cells. Defaults to 0.
 */
@property (nonatomic, assign) CGFloat horizontalCellSpacing;

@end

/**
 The data source protocol for the `CHVariableHeightTilesLayout`.
 */
@protocol CHVariableHeightTilesLayoutDataSource <NSObject>

@required

/**
 @return The total number of cells that will be displayed by the collection view.
 */
- (NSUInteger)totalItemCount;

/**
 @param index The index.
 
 @return The size of an item for a given index.
 */
- (CGSize)sizeForItemAtIndex:(NSUInteger)index;

@end
