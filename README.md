
# CHVariableHeightTilesLayout

Custom collection view layout that has the same vertical spacing between all cells.

[![Version](https://cocoapod-badges.herokuapp.com/v/CHVariableHeightTilesLayout/badge.png)](http://cocoadocs.org/docsets/CHVariableHeightTilesLayout)
[![Platform](https://cocoapod-badges.herokuapp.com/p/CHVariableHeightTilesLayout/badge.png)](http://cocoadocs.org/docsets/CHVariableHeightTilesLayout)

<img src="https://github.com/chaione/CHVariableHeightTilesLayout/raw/master/Misc/screenshot01.png" width=320>

## Installation

### CocoaPods

CHVariableHeightTilesLayout is available through [CocoaPods](http://cocoapods.org), to install it simply add the following line to your Podfile:

`pod "CHVariableHeightTilesLayout"`

### Manually

To install manually, just copy everything in the `CHVariableHeightTilesLayout` directory into your Xcode project.

_**Important:**_ If your project doesn't use ARC you must add the `-fobjc-arc` compiler flag to all CHCircleGaugeView implementation files in Target Settings > Build Phases > Compile Sources.

## Usage

1. Instantiate, customize, set yourself as the `dataSource`, and assign to a collection view's `collectionViewLayout`.
2. Implement both of the `CHVariableHeightTilesLayoutDataSource` protocol methods.

Setup example:

```objective-c
CHVariableHeightTilesLayout *variableHeightTilesLayout = [[CHVariableHeightTilesLayout alloc] init];
variableHeightTilesLayout.topSpacing = 5.0;
variableHeightTilesLayout.bottomSpacing = 5.0;
variableHeightTilesLayout.sideSpacing = 10.0;
variableHeightTilesLayout.horizontalCellSpacing = 20.0;
variableHeightTilesLayout.verticalCellSpacing = 20.0;
variableHeightTilesLayout.dataSource = self;
self.collectionView.collectionViewLayout = variableHeightTilesLayout;
```

## Contributing

Pull request are welcomed. To add functionality or to make changes:

1. Fork this repo.
2. Open `CHVariableHeightTilesLayoutExample.xcodeproj` in the `CHVariableHeightTilesLayoutExample` directory.
3. Make changes to the necessary files in the `CHVariableHeightTilesLayout` group.
4. Ensure new public methods are documented.
5. Submit a pull request.

## Authors

Created by [Osama Ashawa](http://oashawa.com/), [Matthew Morey](http://matthewmorey.com), [Rogelio Gudino](http://cananito.com/), and other [contributors](https://github.com/chaione/CHCircleGaugeView/graphs/contributors).

## License

CHVariableHeightTilesLayout is available under the MIT license. See the [LICENSE](https://github.com/chaione/CHVariableHeightTilesLayout/blob/master/LICENSE) file for more information. If you're using CHVariableHeightTilesLayout in your project, attribution would be nice.
