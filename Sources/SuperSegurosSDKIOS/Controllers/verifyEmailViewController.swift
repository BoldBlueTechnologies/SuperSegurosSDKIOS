//
//  verifyEmailViewController.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 16/12/24.
//

import UIKit

class verifyEmailViewController: stylesViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var continueBtn: UIButton!
    
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
    var planSelected : Cotizacion.CoberturaPlan?
    var rfc: String?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        continueBtn.isHidden = true
        txtEmail.delegate = self
        txtEmail.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueAction(_ sender: Any) {
        guard let email = txtEmail.text?.trimmingCharacters(in: .whitespaces), isValidEmail(email) else {
            showAlert(title: "Error", message: "Por favor, ingresa un correo electrónico válido.")
            return
        }
        
        PayQuotationData.shared.email = email
        NetworkDataRequest.verifyEmail(email: email) { success, message, data in
            DispatchQueue.main.async {
                if success {
      
                    
                    if data == 1 {
                        
                        let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle.module)
                        let switchViewController = storyboard.instantiateViewController(withIdentifier: "linkPolicy") as! linkPolicyViewController
                        switchViewController.email = self.txtEmail.text
                        
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
                        switchViewController.planSelected = self.planSelected
                        
                        switchViewController.modalPresentationStyle = .fullScreen
                        switchViewController.isModalInPresentation = true
                        self.present(UINavigationController(rootViewController: switchViewController), animated: true, completion: nil)
                        
                    } else {
                        
                        
                        let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle.module)
                        let switchViewController = storyboard.instantiateViewController(withIdentifier: "signup") as! signupViewController
                        switchViewController.modalPresentationStyle = .fullScreen
                        
                        switchViewController.email = self.txtEmail.text
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
                        switchViewController.planSelected = self.planSelected
                        switchViewController.isModalInPresentation = true
                        self.present(UINavigationController(rootViewController: switchViewController), animated: true, completion: nil)
                        
                    }
             
                } else {
                    
                    
                    let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle.module)
                    let switchViewController = storyboard.instantiateViewController(withIdentifier: "signup") as! signupViewController
                    switchViewController.modalPresentationStyle = .fullScreen
                    
                    switchViewController.email = self.txtEmail.text
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
                    switchViewController.planSelected = self.planSelected
                    switchViewController.isModalInPresentation = true
                    self.present(UINavigationController(rootViewController: switchViewController), animated: true, completion: nil)
                    self.showAlert(title: "Error", message: message)
                }
            }
        }
    }
    
    @objc func textFieldDidChange() {
        if let email = txtEmail.text, isValidEmail(email) {
            continueBtn.isHidden = false
        } else {
            continueBtn.isHidden = true
        }
    }
    
 
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension verifyEmailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


