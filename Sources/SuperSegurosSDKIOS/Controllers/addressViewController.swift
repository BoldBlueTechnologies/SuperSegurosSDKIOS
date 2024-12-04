//
//  addressViewController.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 26/11/24.
//

import UIKit

protocol selectAddressProtocol {
    
    func selectState(state: String)
    func selectCity(city: String)

}

class addressViewController: stylesViewController, @preconcurrency selectAddressProtocol {


    
    @IBOutlet weak var cityAvailableView: UIView!
    @IBOutlet weak var cityFormView: UIView!
    @IBOutlet weak var cityLabel: UILabel!
    
    
 
    @IBOutlet weak var stateAvailableView: UIView!
    @IBOutlet weak var stateFormView: UIView!
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var txtStreet: UITextField!
    @IBOutlet weak var txtExtNum: UITextField!
    @IBOutlet weak var txtIntNum: UITextField!
    @IBOutlet weak var txtSuburb: UITextField!
    
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
        switchViewController.addressDelegate = self
        switchViewController.modalPresentationStyle = .popover
        switchViewController.isModalInPresentation = true
        self.present(UINavigationController(rootViewController: switchViewController), animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

        postalCodeTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        postalCodeTextField.delegate = self
        setStyle()
    }
    
    func setStyle() {
        self.emptyBorders(view: cityFormView)
        self.emptyBorders(view: stateFormView)
     
   //     self.emptyBorders(view: postalCodeFormView)
        
        self.roundButton(button: sendInformationButton)
    }
    
    // Delegate
    
    func selectState(state: String) {
        stateLabel.text = state
        self.completeBorders(view: stateFormView, label: stateLabel)
        
        cityAvailableView.isHidden = false
    }
    
    func selectCity(city: String) {
        cityLabel.text = city
        self.completeBorders(view: cityFormView, label: cityLabel)
        
   
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
extension addressViewController: UITextFieldDelegate {
    
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
