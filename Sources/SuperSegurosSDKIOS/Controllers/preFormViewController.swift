//
//  preFormViewController.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 25/11/24.
//

import UIKit

class preFormViewController: UIViewController {
 
        
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    
    }
    
}
