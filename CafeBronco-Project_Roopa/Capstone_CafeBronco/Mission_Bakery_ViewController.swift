//
//  Mission_Bakery_ViewController.swift
//  Capstone_CafeBronco
//
//  Created by Vinamrata on 8/13/17.
//  Copyright © 2017 SCU. All rights reserved.
//

import UIKit

//Global varibales for quantity and price of each menu item

public var var_quantity1 : Int = 0
public var var_itemprice1 : Float = 0.0

public var var_quantity2 : Int = 0
public var var_itemprice2 : Float = 0.0

public var var_quantity3 : Int = 0
public var var_itemprice3 : Float = 0.0

class Mission_Bakery_ViewController: UIViewController {
    
    // item1: coffee
    @IBOutlet weak var item1: UILabel!
    @IBOutlet weak var price1: UILabel!
    @IBOutlet weak var enterQuantity1: UIButton!
    @IBOutlet weak var quantity1: UITextField!
    
    // item2: chai te latte
    @IBOutlet weak var item2: UILabel!
    
    @IBOutlet weak var price2: UILabel!
   
    @IBOutlet weak var enterQuantity2: UIButton!
    @IBOutlet weak var quantity2: UITextField!
    
    
    // item3: iced coffee
    @IBOutlet weak var item3: UILabel!
    @IBOutlet weak var price3: UILabel!
    @IBOutlet weak var quantity3: UITextField!
    @IBOutlet weak var enterQuantity3: UIButton!



    override func viewDidLoad() {
        super.viewDidLoad()
        /*
            Show number pad when user clicks on text field to enter quantity
        */
        quantity1.keyboardType = UIKeyboardType.numberPad
        quantity2.keyboardType = UIKeyboardType.numberPad
        quantity3.keyboardType = UIKeyboardType.numberPad
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Hide number pad when user touches anywhere on screen other that text field
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    // User enters quantity and hit 'Quantity' button for item1
    @IBAction func quantity1_pressed(_ sender: UIButton) {
        /*
         
            Accept the quantity entered by user when 'Quantity' button is pressed.
            Otherwise generate alert if 'Quantity' is pressed without entering the quantity
         
        */
        
        if(quantity1.text == ""){
            let alertController = UIAlertController(title: "Error", message: "Please enter quantity", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                print("You've pressed OK button");
            }
            
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
            
        }
        else {
            
            self.quantity1.resignFirstResponder()
            var_quantity1 = Int(quantity1.text!)!
            
            // Split the given price "$ 4.00" to get actual price value i.e. 4.00
            let splitPrice = price1.text?.components(separatedBy: " ")
            let splitActualPrice = Float((splitPrice?[1])!)
            
            var_itemprice1 = Float(var_quantity1) * (splitActualPrice)!
            
        }
    }
    
    // User enters quantity and hit 'Quantity' button for item2
    @IBAction func quantity2_pressed(_ sender: UIButton) {
        
        /*
         
         Accept the quantity entered by user when 'Quantity' button is pressed.
         Otherwise generate alert if 'Quantity' is pressed without entering the quantity
         
        */
        
        if(quantity2.text == ""){
            let alertController = UIAlertController(title: "Error", message: "Please enter quantity", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                print("You've pressed OK button");
            }
            
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
            
        }
        else {
            
            self.quantity2.resignFirstResponder()
            var_quantity2 = Int(quantity2.text!)!
            
            // Split the given price "$ 4.00" to get actual price value i.e. 4.00
            let splitPrice = price2.text?.components(separatedBy: " ")
            let splitActualPrice = Float((splitPrice?[1])!)
            
            var_itemprice2 = Float(var_quantity2) * (splitActualPrice)!
            
        }
    }

    // User enters quantity and hit 'Quantity' button for item3

    @IBAction func quantity3_pressed(_ sender: UIButton) {
        
        /*
         
         Accept the quantity entered by user when 'Quantity' button is pressed.
         Otherwise generate alert if 'Quantity' is pressed without entering the quantity
         
        */
        
        if(quantity3.text == ""){
            let alertController = UIAlertController(title: "Error", message: "Please enter quantity", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                print("You've pressed OK button");
            }
            
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
            
        }
        else {
            
            self.quantity3.resignFirstResponder()
            var_quantity3 = Int(quantity3.text!)!
            
            // Split the given price "$ 4.00" to get actual price value i.e. 4.00
            let splitPrice = price3.text?.components(separatedBy: " ")
            let splitActualPrice = Float((splitPrice?[1])!)
            
            var_itemprice3 = Float(var_quantity3) * (splitActualPrice)!
            
        }
    }
    
    // Function to pass item names selected by user to order summary
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        let DestViewController: Order_summary_ViewController = segue.destination as! Order_summary_ViewController
        
        if(var_quantity1 != 0){
            DestViewController.itemname1 = item1.text!
        }
        if(var_quantity2 != 0){
            DestViewController.itemname2 = item2.text!
        }
        if(var_quantity3 != 0){
            DestViewController.itemname3 = item3.text!
        }
    }
    
    

    
}
