//
//  VendorOrderHistoryTableViewController.swift
//  Capstone_CafeBronco
//
//  Created by Roopa Daga on 9/2/17.
//  Copyright © 2017 SCU. All rights reserved.
//

import UIKit
import Firebase

public struct orderhistory  {
    
    //let key: String!
    let order : String!
    let datetime : String
    let status : String
    let item1 :String!
    let item2 :String!
    let item3 :String!
    let qty1 :String!
    let qty2 :String!
    let qty3 :String!
    let price:String!
    
    
}


class VendorOrderHistoryTableViewController: UITableViewController {
    
    //array to store orders
    var order = [orderhistory]()
    //reference for firebase
    var ref:FIRDatabaseReference?
    


    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.fetchData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return order.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        let label1 = cell?.viewWithTag(1) as! UILabel
        label1.text = order[indexPath.row].order
        let label2 = cell?.viewWithTag(2) as! UILabel
        label2.text = order[indexPath.row].datetime
        let label3 = cell?.viewWithTag(3) as! UILabel
        label3.text = order[indexPath.row].status
        return cell!
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let orderDetailVC = VendorOrderDetailsViewController()
        //orderDetailVC.history = order[indexPath.row]
        orderDetailVC.orderHistory = order[indexPath.row]
        self.present(orderDetailVC, animated: true, completion: nil)
        
        
    }
    
    func fetchData() {
        self.order = [orderhistory]()
        ref = FIRDatabase.database().reference()
        ref?.child("Orderid").queryOrderedByKey().observe(.childAdded, with: { (snapshot) in
            
            
            let snapshotValue = snapshot.value as? NSDictionary
            
            
            let key = snapshotValue!["order_id"] as? String
            let datetime = snapshotValue!["datetime"] as? String
            let status = snapshotValue!["status"] as? String
            let dish1 = snapshotValue!["item1"] as? String
            let dish2 = snapshotValue!["item2"] as? String
            let dish3 = snapshotValue!["item3"] as? String
            let quant1 = snapshotValue!["Qty1"] as? String
            let quant2 = snapshotValue!["Qty2"] as? String
            let quant3 = snapshotValue!["Qty3"] as? String
            let amount = snapshotValue!["price"] as? String
            
            self.order.insert(orderhistory(order:key, datetime:datetime!, status:status!, item1: dish1 ,item2: dish2,item3: dish3, qty1:quant1, qty2:quant2, qty3:quant3, price:amount), at: 0)
            self.tableView.reloadData()
        })
        
    }

}
