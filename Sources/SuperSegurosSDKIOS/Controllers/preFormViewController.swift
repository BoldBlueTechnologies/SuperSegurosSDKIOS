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
    
    @IBAction func continueAction(_ sender: Any) {
        
        
        let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle.module)
        let switchViewController = storyboard.instantiateViewController(withIdentifier: "dataVehicle") as! dataVehicleViewController
        switchViewController.modalPresentationStyle = .fullScreen
        switchViewController.isModalInPresentation = true
        self.present(UINavigationController(rootViewController: switchViewController), animated: true, completion: nil)
        
        
    }
}
