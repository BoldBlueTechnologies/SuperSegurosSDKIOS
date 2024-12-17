//
//  linkPoliciyViewController.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 16/12/24.
//

import UIKit

class linkPolicyViewController: stylesViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var continueBtn: UIButton!
    
    var email:String?
    
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
        
        if let email = email {
            
            self.txtEmail.text = email
        }
        
        continueBtn.isHidden = true
        
        txtEmail.delegate = self
        txtPassword.delegate = self
        
        txtEmail.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        txtPassword.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        
        txtPassword.isSecureTextEntry = true
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueAction(_ sender: Any) {
        guard let email = txtEmail.text?.trimmingCharacters(in: .whitespaces), isValidEmail(email),
              let password = txtPassword.text?.trimmingCharacters(in: .whitespaces), !password.isEmpty else {
            showAlert(title: "Error", message: "Por favor, ingresa un correo electrónico válido y una contraseña.")
            return
        }
        
        NetworkDataRequest.associateUser(email: email, password: password) { success, message, data in
            DispatchQueue.main.async {
                if success {
                    
                    let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle.module)
                    let switchViewController = storyboard.instantiateViewController(withIdentifier: "paymentSummary") as! paymentSummaryViewController
                    switchViewController.modalPresentationStyle = .fullScreen
                    switchViewController.isModalInPresentation = true
                    self.present(UINavigationController(rootViewController: switchViewController), animated: true, completion: nil)
                } else {
                    
                    self.showAlert(title: "Error", message: message)
                }
            }
        }
    }
    
    @objc func textFieldsDidChange() {
        if let email = txtEmail.text, isValidEmail(email),
           let password = txtPassword.text, !password.trimmingCharacters(in: .whitespaces).isEmpty {
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

extension linkPolicyViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

