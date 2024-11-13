//
//  stylesViewController.swift
//  SuperSegurosSDKIOS
//
//  Created by Oscar Aguilar on 13/11/24.
//

import UIKit

class stylesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func emptyBorders(view: UIView) {
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 1.0).cgColor
        view.layer.masksToBounds = true
    }
    
    func completeBorders(view: UIView) {
        view.layer.borderColor = UIColor(red: 191/255, green: 148/255, blue: 252/255, alpha: 1.0).cgColor
    }
    
    func roundButton(button: UIButton) {
        button.layer.cornerRadius = 20
    }
    

}
