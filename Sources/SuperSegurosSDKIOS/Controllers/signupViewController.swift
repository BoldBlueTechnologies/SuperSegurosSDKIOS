//
//  signupViewController.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 27/11/24.
//



import UIKit

class signupViewController: stylesViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPaternalLastName: UITextField!
    @IBOutlet weak var txtMaternalLastName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var btnPrivacy: UIButton!
    
    var isPrivacyAccepted: Bool = false
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnContinue.isHidden = true
        
        if let email = email {
            txtEmail.text = email
        }
        
        if let name = name {
            txtName.text = name
        }
        
        if let paternalSurName = paternalSurName {
            txtPaternalLastName.text = paternalSurName
        }
        
        if let maternalSurName = maternalSurName {
            txtMaternalLastName.text = maternalSurName
        }
        
        txtEmail.delegate = self
        txtName.delegate = self
        txtPaternalLastName.delegate = self
        txtMaternalLastName.delegate = self
        txtPassword.delegate = self
        txtConfirmPassword.delegate = self
        txtPhone.delegate = self
        
        txtEmail.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        txtName.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        txtPaternalLastName.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        txtMaternalLastName.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        txtPassword.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        txtConfirmPassword.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        txtPhone.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        
        txtPassword.isSecureTextEntry = true
        txtConfirmPassword.isSecureTextEntry = true
        txtPhone.keyboardType = .numberPad
        
        // Configurar iconos de ojo en txtPassword y txtConfirmPassword
        configurePasswordToggle(for: txtPassword)
        configurePasswordToggle(for: txtConfirmPassword)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueAction(_ sender: Any) {
        guard let email = txtEmail.text?.trimmingCharacters(in: .whitespaces), isValidEmail(email),
              let name = txtName.text?.trimmingCharacters(in: .whitespaces), !name.isEmpty,
              let paternalLastName = txtPaternalLastName.text?.trimmingCharacters(in: .whitespaces), !paternalLastName.isEmpty,
              let maternalLastName = txtMaternalLastName.text?.trimmingCharacters(in: .whitespaces), !maternalLastName.isEmpty,
              let password = txtPassword.text, !password.isEmpty,
              let confirmPassword = txtConfirmPassword.text, !confirmPassword.isEmpty,
              let phone = txtPhone.text?.trimmingCharacters(in: .whitespaces), phone.count == 10,
              isPasswordMatching(password, confirmPassword),
              isPrivacyAccepted else {
            showAlert(title: "Aviso", message: "Por favor, completa todos los campos correctamente y acepta la política de privacidad.")
            return
        }
        
        guard let uidString = UIDevice.current.identifierForVendor?.uuidString else {
            showAlert(title: "Aviso", message: "No se pudo obtener el identificador del dispositivo.")
            return
        }
        
        let uid = uidString.hashValue
        let prefijo = "52"
        let latitud = "0.0"
        let longitud = "0.0"
        let comoConocio = "Super"
        let origen = "Super"
        
        PayQuotationData.shared.name = name
        PayQuotationData.shared.paternalSurname = paternalSurName
        PayQuotationData.shared.maternalSurname = maternalSurName
        
        NetworkDataRequest.registerUser(uid: uid, name: name, paternalSurname: paternalLastName, maternalSurname: maternalLastName, email: email, password: password, prefijo: prefijo, phoneNumber: phone, latitud: latitud, longitud: longitud, comoConocio: comoConocio, origen: origen) { success, message, data in
            DispatchQueue.main.async {
                if success {
                    
                    PayQuotationData.shared.userId = data
                    let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle.module)
                    let switchViewController = storyboard.instantiateViewController(withIdentifier: "paymentSummary") as! paymentSummaryViewController
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
                    switchViewController.planSelected = self.planSelected
                    self.present(UINavigationController(rootViewController: switchViewController), animated: true, completion: nil)
                    
                    
                } else {
                    self.showAlert(title: "Aviso", message: message)
                }
            }
        }
    }
    
    @IBAction func privacyButtonTapped(_ sender: UIButton) {
        isPrivacyAccepted.toggle()
        let imageName = isPrivacyAccepted ? "casilla_on" : "casilla_off"
        btnPrivacy.setImage( UIImage.moduleImage(named: imageName), for: .normal)
        textFieldsDidChange()
    }
    
    @objc func textFieldsDidChange() {
        guard let email = txtEmail.text?.trimmingCharacters(in: .whitespaces), isValidEmail(email),
              let name = txtName.text?.trimmingCharacters(in: .whitespaces), !name.isEmpty,
              let paternalLastName = txtPaternalLastName.text?.trimmingCharacters(in: .whitespaces), !paternalLastName.isEmpty,
              let maternalLastName = txtMaternalLastName.text?.trimmingCharacters(in: .whitespaces), !maternalLastName.isEmpty,
              let password = txtPassword.text, !password.isEmpty,
              let confirmPassword = txtConfirmPassword.text, !confirmPassword.isEmpty,
              let phone = txtPhone.text?.trimmingCharacters(in: .whitespaces), phone.count == 10,
              isPasswordMatching(password, confirmPassword),
              isPrivacyAccepted else {
            btnContinue.isHidden = true
            return
        }
        btnContinue.isHidden = false
    }
    
    func isPasswordMatching(_ password: String, _ confirmPassword: String) -> Bool {
        return password == confirmPassword
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    

    private func configurePasswordToggle(for textField: UITextField) {
        let toggleButton = UIButton(type: .custom)
        toggleButton.setImage(UIImage(systemName: "eye"), for: .normal)
        toggleButton.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        toggleButton.addTarget(self, action: #selector(togglePasswordVisibility(_:)), for: .touchUpInside)
        
        // Ajustar el frame del botón
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
}

extension signupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtPhone {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else {
                return false
            }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return allowedCharacters.isSuperset(of: characterSet) && updatedText.count <= 10
        }
        return true
    }
}
