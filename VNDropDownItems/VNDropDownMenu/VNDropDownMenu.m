//
// VNDropDownMenu.m
//  Created by Mac-Vishal on 08/06/17.
//  Copyright © 2017 Vishal. All rights reserved.
//

#import "VNDropDownMenu.h"

@interface VNDropDownMenu () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) UIView *targetView;
@property (strong, nonatomic) UITableView *menuTableView;
@property (copy) VNDropDownMenuCompletionBlock callback;

- (void)setup;
- (void)setupDefaults;
- (void)setupUI;
- (void)addTable;
- (void)reloadTable;

@end

@implementation VNDropDownMenu

#pragma mark - Init methods

- (instancetype)initWithView:(__kindof UIView *)view menuItems:(NSMutableArray *)menuItems
{
  NSAssert(view, @"View must not be nil.");
  self = [super initWithFrame:CGRectZero];
  if (self) {
    _targetView = view;
    _menuItems = menuItems;
    _dummyArray = [[NSMutableArray alloc] initWithArray:menuItems];
    
    [self setup];
  }
  return self;
}

#pragma mark - Setup

- (void)setup
{
  [self setupDefaults];
  [self setupUI];
  [self addTable];
}

- (void)setupDefaults
{
  _menuColor = [[UIColor clearColor] colorWithAlphaComponent:0.8f];
  _itemColor = [UIColor whiteColor];
  _itemFont = [UIFont systemFontOfSize:14.0f];
  _itemHeight = 40.0f;
  _indicatorStyle = VNDropDownMenuScrollIndicatorStyleDefault;
}

- (void)setupUI
{
  self.backgroundColor = _menuColor;
}

- (void)addTable
{
  if (_menuTableView) {
    return;
  }
  _menuTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
  _menuTableView.dataSource = self;
  _menuTableView.delegate = self;
  _menuTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  _menuTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
  _menuTableView.backgroundColor = [UIColor clearColor];
  _menuTableView.indicatorStyle = (UIScrollViewIndicatorStyle)_indicatorStyle;
  _menuTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
  [self addSubview:_menuTableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return _menuItems.count;
}

static NSString *const kCellIdentifier = @"VNDropDownCellIdentifier";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
  
  VNDropDownMenuItem *item = _menuItems[indexPath.row];
  
  if (!cell)
  {
    UITableViewCellStyle style = UITableViewCellStyleDefault;
    cell = [[UITableViewCell alloc] initWithStyle:style reuseIdentifier:kCellIdentifier];
  }
  
  cell.textLabel.textColor = _itemColor;
  cell.textLabel.font = _itemFont;
  cell.backgroundColor = [UIColor clearColor];
  cell.textLabel.text = item.title;
  
  return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (_hidesOnSelection == YES) {
    [self hideMenu];
  }
  
  if (_callback) {
    _callback(self, _menuItems[indexPath.row], indexPath.row);
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return _itemHeight;
}

#pragma mark - Property setters

- (void)setMenuColor:(UIColor *)menuColor
{
  _menuColor = menuColor;
  self.backgroundColor = _menuColor;
}

- (void)setItemColor:(UIColor *)itemColor
{
  _itemColor = itemColor;
  [self reloadTable];
}

- (void)setItemFont:(UIFont *)itemFont
{
  _itemFont = itemFont;
  [self reloadTable];
}

- (void)setItemHeight:(CGFloat)itemHeight
{
  _itemHeight = itemHeight;
  [self reloadTable];
}


- (void)reloadTable
{
  [_menuTableView reloadData];
}

- (void)setIndicatorStyle:(VNDropDownMenuScrollIndicatorStyle)indicatorStyle
{
  _indicatorStyle = indicatorStyle;
  _menuTableView.indicatorStyle = (UIScrollViewIndicatorStyle)_indicatorStyle;
}
- (void)getText:(NSString *)strSearch
{
    [self searchUsingString:strSearch];
}
-(void)searchUsingString:(NSString *)strSearch
{
    [_menuItems removeAllObjects];
    strSearch = [strSearch stringByTrimmingCharactersInSet:
                 [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (strSearch.length == 0)
    {
        [_menuItems addObjectsFromArray:_dummyArray];
    }
    else
    {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Self.title CONTAINS[cd] %@",strSearch];
            NSArray *arrResult = [_dummyArray filteredArrayUsingPredicate:predicate];
            
            if (arrResult.count > 0)
            {
                [_menuItems addObjectsFromArray:arrResult];
            }
        }
    [self reloadTable];
}

#pragma mark - Show-hide

- (void)showMenuWithCompletion:(VNDropDownMenuCompletionBlock)callback
{
  _callback = callback;
  CGFloat x = _targetView.frame.origin.x;
  CGFloat width = _targetView.frame.size.width;
  CGFloat height = _itemHeight * _menuItems.count;
  
  if (_menuItems.count > 5) {
    height = _itemHeight * 5;
  }
  
  CGFloat y = 0.0f;
  if (_direction == VNDropDownMenuDirectionDown) {
    y = _targetView.frame.origin.y + _targetView.frame.size.height;
  }
  else {
    y = _targetView.frame.origin.y - height;
  }
  
  self.frame = CGRectMake(x, y, width, height);
  [_targetView.superview addSubview:self];
}

- (void)hideMenu
{
  [self removeFromSuperview];
  [_menuTableView deselectRowAtIndexPath:_menuTableView.indexPathForSelectedRow animated:NO];
}

@end

#pragma mark - VNDropDownMenuItem

@implementation VNDropDownMenuItem


@end
