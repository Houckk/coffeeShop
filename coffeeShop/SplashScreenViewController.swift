//
//  SplashScreenViewController.swift
//  coffeeShop
//
//  Created by Kenyan Houck on 4/29/19.
//  Copyright © 2019 Kenyan Houck. All rights reserved.
//

import UIKit
import Foundation

class SplashScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UIView.animate(withDuration: 4) {
            //self.instructionLabel.textColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "ShowTableView", sender: nil)
    }
    

}
