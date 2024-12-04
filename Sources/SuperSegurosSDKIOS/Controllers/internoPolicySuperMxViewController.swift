//
//  internoPolicySuperMxViewController.swift
//  midoconlineapp
//
//  Created by Christian Martinez on 10/01/24.
//

import UIKit

class internoPolicySuperMxViewController: stylesViewController {


    @IBOutlet weak var viewSpecs: UIView!
    @IBOutlet weak var viewRights: UIView!
    @IBOutlet weak var viewGeneralConditions: UIView!
    @IBOutlet weak var policyCertificate: UIView!
    @IBOutlet weak var viewPlicyapplication: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setStyle()
    }
    
    func setStyle(){
  
        
        self.viewPlicyapplication.applyRoundedShadowStyle()
        self.policyCertificate.applyRoundedShadowStyle()
        self.viewGeneralConditions.applyRoundedShadowStyle()
        self.viewRights.applyRoundedShadowStyle()
        self.viewSpecs.applyRoundedShadowStyle()
        

    }


}
