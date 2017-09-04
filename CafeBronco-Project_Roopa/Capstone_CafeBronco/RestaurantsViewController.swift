//
//  FirstViewController.swift
//  Capstone_CafeBronco
//
//  Created by Roopa Daga on 5/28/17.
//  Copyright © 2017 SCU. All rights reserved.
//

import UIKit

class RestaurantsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Display first the loginviewcontroller
        
        let orderDetailVC = LogInViewController()
        self.present(orderDetailVC, animated: true, completion: nil);
        //        }
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

