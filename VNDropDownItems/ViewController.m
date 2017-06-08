//
//  ViewController.m
//  VNDropDownItems
//
//  Created by Mac-Vishal on 08/06/17.
//  Copyright © 2017 Vishal. All rights reserved.
//

#import "ViewController.h"

#import "ViewController.h"
#import "VNDropDownMenu.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *myTextField;
@property (strong, nonatomic) VNDropDownMenu *dropDown;
@property (readonly, copy, nonatomic) NSMutableArray *menuItems;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self textFieldChanged:textField];
}
- (IBAction)textFieldChanged:(UITextField *)sender
{
    if (!_dropDown)
    {
        _dropDown = [[VNDropDownMenu alloc] initWithView:_myTextField menuItems:self.menuItems];
        _dropDown.menuColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
        _dropDown.itemColor = [UIColor blackColor];
        _dropDown.itemHeight = 40.0f;
        _dropDown.hidesOnSelection = YES;
        _dropDown.direction = VNDropDownMenuDirectionDown;
        _dropDown.indicatorStyle = VNDropDownMenuScrollIndicatorStyleDefault;
    }
    [_dropDown getText:_myTextField.text];
    [_dropDown showMenuWithCompletion:^(VNDropDownMenu *dropDownMenu, id menuItem, NSUInteger index)
     {
         VNDropDownMenuItem *item = menuItem;
         _myTextField.text = item.title;
     }];
}

#pragma mark - Hide DropDown

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event  {
    NSLog(@"touches began");
    UITouch *touch = [touches anyObject];
    if(touch.view!=_dropDown){
        [_dropDown removeFromSuperview];
    }
}
#pragma mark - Custom Items

- (NSMutableArray *)menuItems
{
    NSMutableArray *arrTemp = [[NSMutableArray alloc] init];
    NSArray *arr = @[@{@"Title":@"Afghanistan"},
                     @{@"Title":@"Bahrain"},
                     @{@"Title":@"Bangladesh"},
                     @{@"Title":@"Belgium"},
                     @{@"Title":@"Colombia"},
                     @{@"Title":@"Democratic"},
                     @{@"Title":@"Ecuador"},
                     @{@"Title":@"Finland"},
                     ];
    for (NSDictionary *dic in arr) {
        VNDropDownMenuItem *item = [[VNDropDownMenuItem alloc] init];
        item.title = [dic valueForKey:@"Title"];
        [arrTemp addObject:item];
    }
    return arrTemp;
}


@end
