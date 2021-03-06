//
//  CustOrderDetailViewController.swift
//  Capstone_CafeBronco
//
//  Created by Roopa Daga on 8/24/17.
//  Copyright © 2017 SCU. All rights reserved.
//

import UIKit
import Firebase
public var order_id_scan: String? = nil


class CustOrderDetailViewController: UIViewController {
    
    var ref: FIRDatabaseReference?
    
    var orderHistory: history?

    @IBOutlet weak var order_id: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var item1: UILabel!
    @IBOutlet weak var qty1: UILabel!
    @IBOutlet weak var item2: UILabel!
    @IBOutlet weak var qty2: UILabel!
    @IBOutlet weak var item3: UILabel!
    @IBOutlet weak var qty3: UILabel!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        order_id.text = orderHistory?.order
        order_id_scan = order_id.text!

        time.text = orderHistory?.datetime
        status.text = orderHistory?.status
        price.text = orderHistory?.price
        item1.text = orderHistory?.item1
        item2.text = orderHistory?.item2
        item3.text = orderHistory?.item3
        qty1.text = orderHistory?.qty1
        qty2.text = orderHistory?.qty2
        qty3.text = orderHistory?.qty3

        // Change order status to Completed when customer scans QR code
        if (flag_qr == true){
            ref = FIRDatabase.database().reference()
            
            let statusinfo = ["status":"Completed"]
            let statusref = ref?.child("Orderid").child(order_id.text!)
            statusref?.updateChildValues(statusinfo)
        }

        
    }
    
    
    @IBAction func onClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // Add code for QR code Scanner
    
    @IBAction func onScanQR(_ sender: Any) {
        let scanVC = ScanQRCode()
        self.present(scanVC, animated: true, completion: nil)
        
    }
    
    
    
    
}
