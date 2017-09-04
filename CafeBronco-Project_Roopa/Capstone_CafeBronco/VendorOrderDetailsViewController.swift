//
//  VendorOrderDetailsViewController.swift
//  Capstone_CafeBronco
//
//  Created by Roopa Daga on 9/2/17.
//  Copyright © 2017 SCU. All rights reserved.
//

import UIKit
import Firebase

class VendorOrderDetailsViewController: UIViewController {
    
    var orderHistory: orderhistory?
    //reference for firebase
    var ref:FIRDatabaseReference?
    var autokey : String!
    
    @IBOutlet weak var orderid: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var item1: UILabel!
    @IBOutlet weak var item2: UILabel!
    @IBOutlet weak var item3: UILabel!
    @IBOutlet weak var qty1: UILabel!
    @IBOutlet weak var qty2: UILabel!
    @IBOutlet weak var qty3: UILabel!
    
    @IBOutlet weak var qrCodeImage: UIImageView!
    
    
    var qrImage: CIImage!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
        
        orderid.text = orderHistory?.order
        time.text = orderHistory?.datetime
        status.text = orderHistory?.status
        price.text = orderHistory?.price
        item1.text = orderHistory?.item1
        item2.text = orderHistory?.item2
        item3.text = orderHistory?.item3
        qty1.text = orderHistory?.qty1
        qty2.text = orderHistory?.qty2
        qty3.text = orderHistory?.qty3
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBAction func onCloseClk(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onReadyToPick(_ sender: Any) {
        ref = FIRDatabase.database().reference()
        
        let statusinfo = ["status":"Ready to pick"]
        let statusref = ref?.child("Orderid").child(orderid.text!)
        statusref?.updateChildValues(statusinfo)
        
        //Start of QR code generator code
        
        // Once order is ready to pick, send notification to customer -> Optional
        
        // OR
        
        // Once order is ready to pick, generate QR code.
        
        //........working code
        
        let data = orderid.text?.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
        
        let filter = CIFilter(name: "CIQRCodeGenerator")
        
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("Q", forKey: "inputCorrectionLevel")
        
        let transform = CGAffineTransform(scaleX: 3, y: 3)
        
        qrImage = filter?.outputImage?.applying(transform)
        
        qrCodeImage.image = UIImage(ciImage: qrImage)
        
        // modify the scales of 
        
        //End of QR code generator code

    }
    
    @IBAction func onComplete(_ sender: Any) {
        ref = FIRDatabase.database().reference()
        
        let statusinfo = ["status":"Completed"]
        let statusref = ref?.child("Orderid").child(orderid.text!)
        statusref?.updateChildValues(statusinfo)
    }
    
}
