# FlobillerSDKIos

IOS SDK and sample for Flocash Ecom API
# How to get SDK lib
1.Open file Flobillersdk.xcworkspace

2.Select FlobillerFramework at scheme build , alse select generic device to build

3.On Menu bar Xcode: Select Product -> Archive

4.Go to root project folder -> _Archive -> Debug -> FlobillerFramework.framework here is the framework file

# How to use SDK lib
1. Add lib to your project application.

2. Use `FlocashService`
	#import <FlobillerFramework/FlocashService.h>
	
  There is two Environment setting on our sdk: `SANDBOX` and `LIVE`. You initial service as below for sandbox
  ```java
  [FlocashService sharedInstance].evironment = SANDBOX;
  ```
  There are four methods in FBApiAccess
  * createOrder: Create ecommerce order
  * updatePaymentOpion: Select payment option for order to process payment
  * updateAdditionField: Some payment options need customer provide more info for process payment as mobile number wallet, otp etc... Call this to add more info for that kind order
  * getOrder: Use this method to query detail about order. Below is code scriptlet for how to use api
	
	Use FlocashSevice with UI flow by using FlocashService:	
```java
      Request *request = [[Request alloc] init];
			
    	CardInfo *card = [[CardInfo alloc] init];
    	card.cardHolder = @"1";
    	card.cardNumber = @"2";
    	card.expireMonth = @"12";
			
	    OrderInfo *order = [[OrderInfo alloc] init];    
			order.amount = 1.0;
	    order.currency = @"GHS";
	    order.item_name =  @"DSTV";
	    order.item_price = @"1";
	    order.orderId = @"645";
	    order.quantity = @"1";
			PayerInfo *payer = [[PayerInfo alloc] init];
	    payer.country = @"GH";
	    payer.firstName = @"pham";
	    payer.lastName = @"binh";
	    payer.email = @"binhpd1@gmail.com";
	    payer.phoneCode = @"+233";
	    payer.phoneNumber = @"87016637251";
	    payer.mobile = [NSString stringWithFormat:@"%@%@",payer.phoneCode,payer.phoneNumber];
    
    MerchantInfo *merchant = [[MerchantInfo alloc] init];
    
    request.order = order;
    request.payer = payer;
    request.merchant = merchant;
    merchant.merchantAccount = @"flobiller@flocash.com";
    [FlocashService sharedInstance].evironment = SANDBOX;
		//Prensent a navigation controller with root view create order.
    [[FlocashService sharedInstance] createOrder:request1 presentCreateOrderViewFrom:self]; 
		
```
  
