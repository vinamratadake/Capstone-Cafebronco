//
//  LogInViewController.swift
//  Capstone_CafeBronco
//
//  Created by Roopa Daga on 9/2/17.
//  Copyright © 2017 SCU. All rights reserved.
//

import UIKit
import Firebase

public struct login  {
    
    let emailid : String!
    let password : String
    let role : String
    
    
}
class LogInViewController: UIViewController {
    //reference for firebase
    var ref:FIRDatabaseReference?
    // email id
    @IBOutlet weak var emailid: UITextField!
    //password
    @IBOutlet weak var password: UITextField!
    //array to store login details
    var tb_login = [login]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogIn(_ sender: Any) {
        self.emailid.resignFirstResponder()
        self.password.resignFirstResponder()
       
        ref = FIRDatabase.database().reference()
        ref?.child("Login").observe(.value, with: { (snapshot) in
            
            let snapshotValue = snapshot.value as? NSDictionary
            let emailid = snapshotValue!["emailid"] as? String
            let password = snapshotValue!["password"] as? String
            let role = snapshotValue!["role"] as? String
            self.tb_login.insert(login(emailid:emailid, password:password!, role:role!), at: 0)
            let emailtext = self.tb_login[0].emailid
            let roletext = self.tb_login[0].role
            let pwdtext = self.tb_login[0].password
            
            if(emailtext == self.emailid.text! && pwdtext == self.password.text!)
            {
                if(roletext == "vendor")
                {
                    self.setupOwnerView()
                }
                
            }
            else{
                self.setupCustomerView()
            }
            
            
        })

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func setupOwnerView() {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "OwnerTabBarViewController")
        UIApplication.shared.keyWindow?.rootViewController = vc
        
    }
    
    
    
    func setupCustomerView() {
        self.dismiss(animated: true, completion: nil)
    }


}
