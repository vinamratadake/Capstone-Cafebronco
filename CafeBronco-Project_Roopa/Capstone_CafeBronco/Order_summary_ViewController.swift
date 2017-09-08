//
//  Order_history_ViewController.swift
//  Capstone_CafeBronco
//
//  Created by Vinamrata on 8/13/17.
//  Copyright © 2017 SCU. All rights reserved.
//

import UIKit
import PassKit
import FirebaseDatabase

class Order_summary_ViewController: UIViewController, PKPaymentAuthorizationViewControllerDelegate {
    
    @IBOutlet weak var os_item1: UILabel!
    @IBOutlet weak var os_quantity1: UILabel!
    @IBOutlet weak var os_price1: UILabel!
    
    @IBOutlet weak var os_item2: UILabel!
    @IBOutlet weak var os_quantity2: UILabel!
    @IBOutlet weak var os_price2: UILabel!
    
    @IBOutlet weak var os_item3: UILabel!
    @IBOutlet weak var os_quantity3: UILabel!
    @IBOutlet weak var os_price3: UILabel!
    
    @IBOutlet weak var os_subTotal: UILabel!
    @IBOutlet weak var os_finalTotal: UILabel!
    
    @IBOutlet weak var datePicker: UITextField!
    
    @IBOutlet weak var discountApplied: UILabel!
    
    let pickupTime = UIDatePicker()
    
    var paymentRequest: PKPaymentRequest!
    
    var pretax: Float = 0.0
    
    //reference for firebase
    var ref : FIRDatabaseReference?

   
    //To display menu items on order summary page
    
    var itemname1 = String()
    var itemname2 = String()
    var itemname3 = String()
    
    var tax : Float = (8.75/100)
    var var_finaltotal : Float = 0.0
    var taxprice: Float = 0.0

    var sign = "$ "
    var temp: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //firebase reference
        ref = FIRDatabase.database().reference()
        
        // Display the items selected by user on Order summary page
        
        if(var_quantity1 != 0){
            os_item1.text = itemname1
            os_quantity1.text = String(var_quantity1)
            os_price1.text = sign.appending(String(var_itemprice1))
        }
        if(var_quantity2 != 0){
            os_item2.text = itemname2
            os_quantity2.text = String(var_quantity2)
            os_price2.text = sign.appending(String(var_itemprice2))
        }
        if(var_quantity3 != 0){
            os_item3.text = itemname3
            os_quantity3.text = String(var_quantity3)
            os_price3.text = sign.appending(String(var_itemprice3))
        }
        
        
        temp = var_itemprice1 + var_itemprice2 + var_itemprice3

        os_subTotal.text = sign.appending(String(temp))
        
        pretax = temp
        
        if qrFlag == true{
            
            pretax = pretax * 0.9
        
            discountApplied.text = "Hurray!!10% discount applied"
        }
        
        taxprice = pretax * tax
        
        //var_finaltotal = temp + (temp * tax)
        var_finaltotal = pretax + taxprice
        
        os_finalTotal.text = sign.appending(String(var_finaltotal))
        
        // Function call to initiate datepicker
        createDatePicker()

    }

    
    
    func createDatePicker() {
        // format for date picker
        pickupTime.datePickerMode = .dateAndTime
        
        // toolbar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        // bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
        
        // Adding this button to toolbar
        toolBar.setItems([doneButton], animated: false)
        
        // binding this toolbar with datePicker text field
        datePicker.inputAccessoryView = toolBar
        
        // Assigning date picker to text field
        datePicker.inputView = pickupTime
        
        // Setting date to current date and time to 15 minutes later
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .minute, value: 15, to: NSDate() as Date)
        
        pickupTime.minimumDate = date
        
    }
    
    func doneButtonPressed() {
        
        // format date and time
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        
        datePicker.text = dateFormatter.string(from: pickupTime.date)
        self.view.endEditing(true)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func orderSummay(pretax: Double, taxPrice: Double, finalPrice: Double) -> [PKPaymentSummaryItem] {
        
        let pretax = PKPaymentSummaryItem(label: "Subtotal", amount: NSDecimalNumber(string: "\(pretax)"))
        
        let taxes = PKPaymentSummaryItem(label: "Tax", amount: NSDecimalNumber(string: "\(taxPrice)"))
        
        let total = PKPaymentSummaryItem(label: "CafeBronco", amount:NSDecimalNumber(string: "\(finalPrice)"))
        
        return [pretax,taxes,total]
        
    }
    
    //function to generate order id which is primary key for all the orders placed
    fileprivate func generateOrderId() -> String {
        let dateValue = Date()
        let dateFormatter = DateFormatter()
        // dateFormatter.dateFormat = "yymmddhhmm"
        dateFormatter.dateFormat = "yymmddhhmmss"
        return dateFormatter.string(from: dateValue)
    }
    

    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        completion(PKPaymentAuthorizationStatus.success)
        
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        
        controller.dismiss(animated: true, completion: nil )
        
        // To display success message after payment
        let alertController = UIAlertController(title: "Done", message: "Your payment is done successfully!", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            
        }
        
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
        
    }
    
    
    @IBAction func ApplePayAction(_ sender: Any) {
        
        //Start of Firebase Code
        //post the data to database
        
        let status = "In process"
        let orderid = generateOrderId()
    
        let data : [String : AnyObject] = ["item1" : os_item1.text as AnyObject,
                                           "item2" : os_item2.text as AnyObject,
                                           "item3" : os_item3.text as AnyObject,
                                           "Qty1"  : os_quantity1.text as AnyObject,
                                           "Qty2"  : os_quantity2.text as AnyObject,
                                           "Qty3"  : os_quantity3.text as AnyObject,
                                           "price" : os_finalTotal.text as AnyObject,
                                           "datetime":datePicker.text as AnyObject,
                                           "order_id":orderid as AnyObject,
                                           "status" : status as AnyObject]
    
        ref?.child("Orderid").child(orderid).setValue(data)
        
        //End of firebase code

        // Start of Apple Pay Code
        let paymentNetworks = [PKPaymentNetwork.amex,.discover,.visa,.masterCard,.JCB]
        
        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: paymentNetworks){
            
            paymentRequest = PKPaymentRequest()
            
            paymentRequest.currencyCode = "USD"
            
            paymentRequest.countryCode = "US"
            
            paymentRequest.merchantIdentifier = "merchant.com.myApp.CafeBronco"
            
            
            paymentRequest.supportedNetworks = paymentNetworks
            
            paymentRequest.merchantCapabilities = .capability3DS
            
            paymentRequest.requiredShippingAddressFields = [.email,.phone]
            
            paymentRequest.paymentSummaryItems = self.orderSummay(pretax: Double(temp), taxPrice: Double(taxprice), finalPrice: Double(var_finaltotal))
            
            
            let applePayVC = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)
            
            applePayVC.delegate = self
            
            self.present(applePayVC, animated: true, completion: nil)
            
            
        } else {
            
            print("Kindly set up Apple Pay")
            
        }
        

    }
    
    

}
