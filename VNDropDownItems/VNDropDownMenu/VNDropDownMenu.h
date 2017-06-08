//
// VNDropDownMenu.h
//  Created by Mac-Vishal on 08/06/17.
//  Copyright © 2017 Vishal. All rights reserved.
//

@import UIKit;

@class VNDropDownMenu;
@class VNDropDownMenuItem;

NS_ASSUME_NONNULL_BEGIN

typedef void (^VNDropDownMenuCompletionBlock)(VNDropDownMenu *dropDownMenu, id menuItem, NSUInteger index);

typedef NS_ENUM(NSUInteger, VNDropDownMenuScrollIndicatorStyle)
{
  VNDropDownMenuScrollIndicatorStyleDefault,
  VNDropDownMenuScrollIndicatorStyleBlack,
  VNDropDownMenuScrollIndicatorStyleWhite
};

typedef NS_ENUM(NSInteger, VNDropDownMenuDirection)
{
  VNDropDownMenuDirectionDown,
  VNDropDownMenuDirectionUp
};

@interface VNDropDownMenu : UIView


@property (nullable, strong, nonatomic) UIColor *menuColor;


@property (nullable, strong, nonatomic) UIColor *itemColor;


@property (nullable, strong, nonatomic) UIFont *itemFont;


@property (assign, nonatomic) CGFloat itemHeight;

@property (assign, nonatomic) BOOL hidesOnSelection;

@property (assign, nonatomic) VNDropDownMenuDirection direction;

@property (assign, nonatomic) VNDropDownMenuScrollIndicatorStyle indicatorStyle;

@property (copy, nonatomic) NSMutableArray *menuItems;
@property (copy, nonatomic) NSMutableArray *dummyArray;

- (instancetype)initWithView:(__kindof UIView *)view menuItems:(NSMutableArray *)menuItems ;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;


- (void)showMenuWithCompletion:(nullable VNDropDownMenuCompletionBlock)callback;

- (void)getText:(NSString *)strSearch;
- (void)hideMenu;

@end

@interface VNDropDownMenuItem : NSObject

@property (copy, nonatomic) NSString *title;

@end

NS_ASSUME_NONNULL_END
