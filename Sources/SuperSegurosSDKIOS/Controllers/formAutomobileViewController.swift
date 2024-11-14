//
//  formAutomobileViewController.swift
//  SuperSegurosSDKIOS
//
//  Created by Oscar Aguilar on 12/11/24.
//

import UIKit

protocol selectBrandProtocol {
    func selectBrand(brand: String)
    
    func selectYear(year: String)
    
    func selectModel(model: String)
    
    func selectVersion(version: String)
}

class formAutomobileViewController: stylesViewController, @preconcurrency selectBrandProtocol {

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
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectPickerAction(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle.module)
        let switchViewController = storyboard.instantiateViewController(withIdentifier: "selectPicker") as! selectPickerViewController
        switchViewController.step = sender.tag
        switchViewController.delegate = self
        switchViewController.modalPresentationStyle = .popover
        switchViewController.isModalInPresentation = true
        self.present(UINavigationController(rootViewController: switchViewController), animated: true, completion: nil)
        
    }
    
    @IBAction func sendInformationAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle.module)
        let switchViewController = storyboard.instantiateViewController(withIdentifier: "selectInsuranct") as! selectInsuranceViewController
        switchViewController.modalPresentationStyle = .popover
        switchViewController.isModalInPresentation = true
        self.present(UINavigationController(rootViewController: switchViewController), animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        postalCodeTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        postalCodeTextField.delegate = self
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
    
    // Delegate
    
    func selectBrand(brand: String) {
        brandAutomobileLabel.text = brand
        self.completeBorders(view: brandFormView, label: brandAutomobileLabel)
        
        yearAvailableView.isHidden = false
    }
    
    func selectYear(year: String) {
        yearAutomobileLabel.text = year
        self.completeBorders(view: yearFormView, label: yearAutomobileLabel)
        
        modelAvailableView.isHidden = false
    }
    
    func selectModel(model: String) {
        modelAutomobileLabel.text = model
        self.completeBorders(view: modelFormView, label: modelAutomobileLabel)
    
        versionAvailableView.isHidden = false
    }
    
    func selectVersion(version: String) {
        versionAutomobileLabel.text = version
        self.completeBorders(view: versionFormView, label: versionAutomobileLabel)
        
        postalCodeAvailableView.isHidden = false
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
       
        if postalCodeTextField.text!.isEmpty {
            
            self.emptyBorders(view: postalCodeFormView)
            sendInformationButton.isHidden = true
        } else {
            
            self.completeBorders(view: postalCodeFormView, label: nil)
            sendInformationButton.isHidden = false
        }
        
    }

}
extension formAutomobileViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }

        if textField == postalCodeTextField {
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

            return updatedText.count <= 5
        }else{
            return true
        }
    }
}
