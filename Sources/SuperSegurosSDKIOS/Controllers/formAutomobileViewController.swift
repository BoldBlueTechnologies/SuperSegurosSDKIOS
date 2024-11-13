//
//  formAutomobileViewController.swift
//  SuperSegurosSDKIOS
//
//  Created by Oscar Aguilar on 12/11/24.
//

import UIKit

class formAutomobileViewController: UIViewController {

    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var titleOneLabel: UILabel!
    @IBOutlet weak var subTtitleOneLabel: UILabel!
    @IBOutlet weak var preSubTitleLabel: UILabel!
    
    @IBOutlet weak var subTitleFormOneLabel: UILabel!
    @IBOutlet weak var brandFormView: UIView!
    @IBOutlet weak var brandAutomobileLabel: UILabel!
    
    @IBOutlet weak var yearAvailableView: UIView!
    @IBOutlet weak var subTitleFormTwoLabel: UILabel!
    @IBOutlet weak var yearFormView: UIView!
    @IBOutlet weak var yearAutomobileLabel: UILabel!
    
    @IBOutlet weak var modelAvailableView: UIView!
    @IBOutlet weak var subTitleFormThreeLabel: UILabel!
    @IBOutlet weak var modelFormView: UIView!
    @IBOutlet weak var modelAutomobileLabel: UILabel!
    
    @IBOutlet weak var versionAvailableView: UIView!
    @IBOutlet weak var subTitleFormFourLabel: UILabel!
    @IBOutlet weak var versionFormView: UIView!
    @IBOutlet weak var versionAutomobileLabel: UILabel!
    
    @IBOutlet weak var postalCodeAvailableView: UIView!
    @IBOutlet weak var subTitleFormFiveLabel: UILabel!
    @IBOutlet weak var postalCodeFormView: UIView!
    @IBOutlet weak var postalCodeTextField: UITextField!
    
    @IBOutlet weak var sendInformationButton: UIButton!
    
    @IBAction func sendInformationAction(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        changeFont()
        setStyle()
    }

    func changeFont() {
        backLabel.font = UIFont(name: "Poppins-Regular", size: 17)
        
//        titleOneLabel.font = UIFont(name: "Poppins-SemiBold", size: 15)
        subTtitleOneLabel.font = UIFont(name: "Poppins-SemiBold", size: 17)
        preSubTitleLabel.font = UIFont(name: "Poppins-Regular", size: 15)
       
        subTitleFormOneLabel.font = UIFont(name: "Poppins-SemiBold", size: 13)
        brandAutomobileLabel.font = UIFont(name: "Poppins-SemiBold", size: 15)
        
        subTitleFormTwoLabel.font = UIFont(name: "Poppins-SemiBold", size: 13)
        yearAutomobileLabel.font = UIFont(name: "Poppins-SemiBold", size: 15)
        
        subTitleFormThreeLabel.font = UIFont(name: "Poppins-SemiBold", size: 13)
        modelAutomobileLabel.font = UIFont(name: "Poppins-SemiBold", size: 15)
        
        subTitleFormFourLabel.font = UIFont(name: "Poppins-SemiBold", size: 13)
        versionAutomobileLabel.font = UIFont(name: "Poppins-SemiBold", size: 15)
        
        subTitleFormFiveLabel.font = UIFont(name: "Poppins-SemiBold", size: 13)
        postalCodeTextField.font = UIFont(name: "Poppins-SemiBold", size: 15)
        
        sendInformationButton.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 17)
      
    }
    
    func setStyle() {
        brandFormView.layer.cornerRadius = 10
        brandFormView.layer.borderWidth = 1
        brandFormView.layer.borderColor = UIColor(red: 191/255, green: 148/255, blue: 252/252, alpha: 1.0).cgColor
        brandFormView.layer.masksToBounds = true
        
        yearFormView.layer.cornerRadius = 10
        yearFormView.layer.borderColor = UIColor(named: "rosaSuper")?.cgColor
        yearFormView.layer.borderWidth = 1
        yearFormView.layer.masksToBounds = true
        
        modelFormView.layer.cornerRadius = 10
        modelFormView.layer.borderColor = UIColor(named: "rosaSuper")?.cgColor
        modelFormView.layer.borderWidth = 1
        modelFormView.layer.masksToBounds = true
        
        versionFormView.layer.cornerRadius = 10
        versionFormView.layer.borderColor = UIColor(named: "rosaSuper")?.cgColor
        versionFormView.layer.borderWidth = 1
        versionFormView.layer.masksToBounds = true
        
        postalCodeFormView.layer.cornerRadius = 10
        postalCodeFormView.layer.borderColor = UIColor(named: "rosaSuper")?.cgColor
        postalCodeFormView.layer.borderWidth = 1
        postalCodeFormView.layer.masksToBounds = true
    }
    
}
