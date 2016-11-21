//
//  CardInfoViewController.m
//  Flobillersdk
//
//  Created by Do Quoc Lam on 11/4/16.
//  Copyright © 2016 Do Quoc Lam. All rights reserved.
//

#import "CardInfoViewController.h"
#import "Request.h"
#import "FBApiAccess.h"
#import "DoneViewController.h"
#import <AMPopTip/AMPopTip.h>
#import "FBConst.h"
#import "FlocashService.h"

@interface CardInfoViewController () {
    NSArray *dataMonth;
    NSArray *dataYear;
    
    //keep value picker
    NSInteger indexMonthSelected;
    NSInteger indexYearSelected;
    AMPopTip *popTip;
}

@end

@implementation CardInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];
    viewBorder.layer.borderWidth = 1.0f;
    viewBorder.layer.cornerRadius = 3.0f;
    payButton.layer.cornerRadius = 3.0f;
    pickerMonth.dataSource = self;
    pickerYear.dataSource = self;

    pickerMonth.delegate = self;
    pickerYear.delegate = self;
    cardNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    errorLabelCardNumber.hidden = YES;
    [self hidePicker];
    
    
    dataMonth =  @[@"01", @"02", @"03", @"04",@"05", @"06", @"07", @"08",@"09",@"10",@"11",@"12"];
    dataYear = [self getYearArray];
    
    [pickerMonth selectRow:6 inComponent:0 animated:NO];
    [pickerYear selectRow:10 inComponent:0 animated:NO];
    indexMonthSelected = 6;
    indexYearSelected = 10;
    
    [expireDateLabel setPlaceholder:@"mm/yy"];
    
    
    // setup Pop Tip
   
    popTip = [AMPopTip popTip];
    popTip.entranceAnimation = AMPopTipEntranceAnimationFadeIn;
    popTip.shouldDismissOnTapOutside = YES;
    popTip.shouldDismissOnTap =     YES;
    popTip.popoverColor = [UIColor lightGrayColor];
    popTip.padding = 2;
    
}
- (NSMutableArray *)getYearArray {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSDateFormatter *yearFormater = [[NSDateFormatter alloc] init];
    yearFormater.dateFormat = @"yyyy";
    
    NSString *currentYear = [yearFormater stringFromDate:[NSDate date]];
    NSInteger currentYearInteger = [currentYear integerValue];
    for (int i =0; i <=20; i++) {
        
        [result addObject:[NSString stringWithFormat:@"%ld",(long)(currentYearInteger - 10 + i)]];
        
    }
    return  result;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpView {
    nameOnCardTextField.delegate = self;
    cardNumberTextField.delegate = self;
    expireDateLabel.delegate = self;
    securityCodeTextField.delegate = self;
    
    
    
}
- (IBAction)payButtonAction:(id)sender {
    if (![self validateInput]) {
        return;
    }
    [self endEditAllTextField];
    [self hidePicker];
    CardInfo *card = [[CardInfo alloc] init];
    card.cvv = securityCodeTextField.text;
    card.cardHolder = nameOnCardTextField.text;
    card.cardNumber =   cardNumberTextField.text;
    card.expireMonth = expireMonth;
    card.expireYear = expireYear;
    Request *request = [[Request alloc] init];
    request.cardInfo = card;
    request.order = self.orderInfo;
    request.payOption = self.paymenMethod;
    if (![FlocashService sharedInstance].networkStatus) {
        [self showAlertError:FBNoInternet];
        return;
    }
    [self showLoadingView];
    [FBApiAccess updatePaymentOpion:self.orderInfo.traceNumber idPayment:self.paymenMethod.idPayment cardInfo:card completionBlock:^(OrderInfo *order) {
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        UIStoryboard *main = [UIStoryboard storyboardWithName:@"FBFlobillerSdkStoryboard" bundle:bundle];
        DoneViewController *doneVC = [main instantiateViewControllerWithIdentifier:@"doneVC"];
        doneVC.orderDone = order;
        [self.navigationController pushViewController:doneVC animated:YES];
        [self dismissLoadingView];
    } failureBlock:^(NSString *errMsg) {
        [self showAlertError:errMsg];
        [self dismissLoadingView];
    }];
   
}- (IBAction)showPickerButtonAction:(id)sender {
    if (expireYear && expireMonth) {
        [pickerMonth selectRow:indexMonthSelected inComponent:0 animated:NO];
        
        [pickerYear selectRow:indexYearSelected inComponent:0 animated:NO];
    }
    
    [self showPicker];
}
- (IBAction)cancelButtonAction:(id)sender {
    [self hidePicker];
}
- (IBAction)doneButtonAction:(id)sender {
    [self endEditAllTextField];
    [self hidePicker];
    expireMonth = [dataMonth objectAtIndex:indexMonthSelected];
    NSString *yearSelect = [dataYear objectAtIndex:indexYearSelected];
    NSString *twoLastCharacter = [yearSelect substringFromIndex: [yearSelect length] - 2];
    expireYear  = twoLastCharacter;
    expireDateLabel.text = [NSString stringWithFormat:@"%@/%@",expireMonth,twoLastCharacter];
}
- (IBAction)buttonQuestionAction:(id)sender {
    [self endEditAllTextField];
    [self hidePicker];
    if (!popTip.isVisible) {
        [popTip showCustomView:viewGuide direction:AMPopTipDirectionUp inView:self.view fromFrame:securityCodeTextField.frame];
        
    }
   
}

#pragma mark - textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField*)aTextField
{
    [aTextField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    keyboardAvoiding.contentOffset = CGPointZero;
    if ([textField isEqual:cardNumberTextField]) {
        if (textField.text.length < 16) {
            errorLabelCardNumber.hidden = NO;
        } else {
            errorLabelCardNumber.hidden = YES;

        }
    }
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [popTip hide];
    [self hidePicker];
    
}
- (void)showPicker {
    [self endEditAllTextField];
    [popTip hide];
    constraintBottomPickerView.constant = 0;
}
- (void)hidePicker {
    constraintBottomPickerView.constant = 300;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([pickerView isEqual:pickerMonth]) {
        return dataMonth[row];
    }
    return dataYear[row];
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([pickerView isEqual:pickerMonth]) {
        return dataMonth.count;
    }
    return dataYear.count;
}

#pragma mark - picker delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if ([pickerView isEqual:pickerMonth]) {
        indexMonthSelected = row;
    } else {
        indexYearSelected = row;
    }
    
}
- (BOOL)validateInput {
    UIAlertView *alert;
    if ([self trimString:cardNumberTextField.text].length < 16) {
        errorLabelCardNumber.hidden = NO;
        return NO;
    }
    if ( [self trimString:nameOnCardTextField.text].length == 0 || [self trimString:cardNumberTextField.text].length == 0 || [self trimString:securityCodeTextField.text].length == 0 || [self trimString:expireDateLabel.text].length == 0 ) {
        alert = [[UIAlertView alloc] initWithTitle:@"" message:@"You must be fill all fields" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return NO;
    }
    return YES;
}
- (void)endEditAllTextField {
    [cardNumberTextField endEditing:YES];
     [securityCodeTextField endEditing:YES];
     [nameOnCardTextField endEditing:YES];
}

- (NSString *)trimString:(NSString *)string {
    if (!string) {
        return @"";
    }
    return [string stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceCharacterSet]];
}

@end
