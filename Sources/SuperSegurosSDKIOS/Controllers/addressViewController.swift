//
//  addressViewController.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 26/11/24.
//

import UIKit

class addressViewController: stylesViewController {
    
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
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtState: UITextField!
    
    @IBOutlet weak var postalCodeAvailableView: UIView!
    @IBOutlet weak var subTitleFormFiveLabel: UILabel!
    @IBOutlet weak var postalCodeFormView: UIView!
    @IBOutlet weak var postalCodeTextField: UITextField!
    
    @IBOutlet weak var sendInformationButton: UIButton!
    
    var idDriver: Int = 0
    
    var vehicleType:TipoVehiculo?
    var modelSelected:Modelo?
    var brandSelected: Marcas?
    var subBrandSelected: SubMarcas?
    var versionSelected: Version?
    var postalCode: String?
    var name: String?
    var paternalSurName: String?
    var maternalSurName: String?
    var insurance:BasicQuotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
     
        
        if let postalCode = self.postalCode {
            
            self.postalCodeTextField.text = postalCode
        }
        
        txtStreet.delegate = self
        txtExtNum.delegate = self
        txtIntNum.delegate = self
        txtSuburb.delegate = self
        txtCity.delegate = self
        txtState.delegate = self
        postalCodeTextField.delegate = self
        
        txtStreet.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        txtExtNum.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        txtIntNum.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        txtSuburb.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        txtCity.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        txtState.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        postalCodeTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
    }
    
    func setStyle() {
        self.roundButton(button: sendInformationButton)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendInformationAction(_ sender: Any) {
        guard let street = txtStreet.text?.trimmingCharacters(in: .whitespaces), !street.isEmpty,
              let extNum = txtExtNum.text?.trimmingCharacters(in: .whitespaces), !extNum.isEmpty,
              let state = txtState.text?.trimmingCharacters(in: .whitespaces), !state.isEmpty,
              let city = txtCity.text?.trimmingCharacters(in: .whitespaces), !city.isEmpty,
              let suburb = txtSuburb.text?.trimmingCharacters(in: .whitespaces), !suburb.isEmpty,
              let postalCode = postalCodeTextField.text?.trimmingCharacters(in: .whitespaces), postalCode.count >= 5 else {
            showAlert(title: "Error", message: "Por favor, completa todos los campos correctamente.")
            return
        }
        
        let intNum = txtIntNum.text?.trimmingCharacters(in: .whitespaces) ?? ""
        
        NetworkDataRequest.setDataAddress(idDriver: idDriver, street: street, apartmentNumber: intNum, streetNumber: extNum, state: state, city: city, zipCode: postalCode, neighborhood: suburb) { success, message, data in
            DispatchQueue.main.async {
                if success {
                    let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle.module)
                    let switchViewController = storyboard.instantiateViewController(withIdentifier: "verifyEmail") as! verifyEmailViewController
                    switchViewController.modalPresentationStyle = .fullScreen
                    switchViewController.isModalInPresentation = true
                    switchViewController.insurance = self.insurance
                    switchViewController.brandSelected = self.brandSelected
                    switchViewController.vehicleType = self.vehicleType
                    switchViewController.modelSelected = self.modelSelected
                    switchViewController.subBrandSelected = self.subBrandSelected
                    switchViewController.versionSelected = self.versionSelected
                    switchViewController.postalCode = self.postalCode
                    switchViewController.name = self.name
                    switchViewController.maternalSurName = self.maternalSurName
                    switchViewController.paternalSurName = self.paternalSurName
                    
                    self.present(UINavigationController(rootViewController: switchViewController), animated: true, completion: nil)
                } else {
                    self.showAlert(title: "Error", message: message)
                }
            }
        }
    }
    
    @objc func textFieldsDidChange() {
        let isStreetValid = !(txtStreet.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
        let isExtNumValid = !(txtExtNum.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
        let isStateValid = !(txtState.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
        let isCityValid = !(txtCity.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
        let isSuburbValid = !(txtSuburb.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
        let isPostalCodeValid = (postalCodeTextField.text?.trimmingCharacters(in: .whitespaces).count ?? 0) >= 5
        
        sendInformationButton.isHidden = !(isStreetValid && isExtNumValid && isStateValid && isCityValid && isSuburbValid && isPostalCodeValid)
                                           
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension addressViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}
