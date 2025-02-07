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
    var planSelected : Cotizacion.CoberturaPlan?
    var message: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emptyBorders(view: txtEmail)
        
        if let email = email {
            self.txtEmail.text = email
            self.completeBorders(view: txtEmail, label: nil)
        }
        
        continueBtn.isHidden = true
        
        txtEmail.delegate = self
        txtPassword.delegate = self
        
        txtEmail.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        txtPassword.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        
      
        txtPassword.isSecureTextEntry = true
        
        configurePasswordToggle(for: txtPassword)
        
        self.showAlert(title: message ?? "")
    }
    
    private func configurePasswordToggle(for textField: UITextField) {
        let toggleButton = UIButton(type: .custom)
        toggleButton.setImage(UIImage(systemName: "eye"), for: .normal)
        toggleButton.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        toggleButton.addTarget(self, action: #selector(togglePasswordVisibility(_:)), for: .touchUpInside)
        
      
        toggleButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        textField.rightView = toggleButton
        textField.rightViewMode = .always
    }
    
    @objc private func togglePasswordVisibility(_ sender: UIButton) {
        sender.isSelected.toggle()
        if let textField = sender.superview as? UITextField {
            textField.isSecureTextEntry.toggle()
        }
    }
    
    
    // MARK: - Alertas
    
    func showAlert(title: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            guard self.presentedViewController == nil else {
                return
            }
            
            var alertStyle: UIAlertController.Style = .actionSheet
            if UIDevice.current.userInterfaceIdiom == .pad {
                alertStyle = .alert
            }
            
            let alert = UIAlertController(title: title, message: "", preferredStyle: alertStyle)
            self.present(alert, animated: true, completion: nil)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",
                                                style: .default,
                                                handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Botones
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueAction(_ sender: Any) {
        guard let email = txtEmail.text?.trimmingCharacters(in: .whitespaces), isValidEmail(email),
                      let password = txtPassword.text?.trimmingCharacters(in: .whitespaces), !password.isEmpty else {
                    showAlert(title: "Aviso", message: "Por favor, ingresa un correo electrónico válido y una contraseña.")
                    return
                }
        PayQuotationData.shared.email = email
        
        NetworkDataRequest.associateUser(email: email, password: password) { success, message, data in
            DispatchQueue.main.async {
                if success {
                    
                    PayQuotationData.shared.userId = data
                    let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle.module)
                    let switchViewController = storyboard.instantiateViewController(withIdentifier: "paymentSummary") as! paymentSummaryViewController
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
                    self.showAlert(title: "Aviso", message: message)
                }
            }
        }
    }
    
    // MARK: - Lógica de TextFields
    
    @objc func textFieldsDidChange() {
        if let email = txtEmail.text, isValidEmail(email),
           let password = txtPassword.text, !password.trimmingCharacters(in: .whitespaces).isEmpty {
            continueBtn.isHidden = false
        } else {
            continueBtn.isHidden = true
        }
    }
}

// MARK: - UITextFieldDelegate

extension linkPolicyViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


