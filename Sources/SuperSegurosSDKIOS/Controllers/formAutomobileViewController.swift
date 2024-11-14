//
//  formAutomobileViewController.swift
//  SuperSegurosSDKIOS
//
//  Created by Oscar Aguilar on 12/11/24.
//

import UIKit

protocol selectBrandProtocol {
    func selectBrand(brand: String)
}

class formAutomobileViewController: stylesViewController, @preconcurrency selectBrandProtocol {
    func selectBrand(brand: String) {
        brandAutomobileLabel.text = brand
        yearAvailableView.isHidden = false
    }
    
    
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
    
    @IBAction func selectPickerAction(_ sender: UIButton) {
        print("STEP.......")
        print(sender.tag)
        print("-----------")
        
        let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle.module)
        let switchViewController = storyboard.instantiateViewController(withIdentifier: "selectPicker") as! selectPickerViewController
        switchViewController.delegate = self
        switchViewController.modalPresentationStyle = .popover
        switchViewController.isModalInPresentation = true
        self.present(UINavigationController(rootViewController: switchViewController), animated: true, completion: nil)
    }
    
    @IBAction func sendInformationAction(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        setStyle()
    }
    
    func setStyle() {
        self.emptyBorders(view: brandFormView)
        self.emptyBorders(view: yearFormView)
        self.emptyBorders(view: modelFormView)
        self.emptyBorders(view: versionFormView)
        self.emptyBorders(view: postalCodeFormView)
        
        self.roundButton(button: sendInformationButton)
    }
    
}
