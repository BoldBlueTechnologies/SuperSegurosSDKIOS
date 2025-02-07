//
//  dataDriverViewController.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 26/11/24.
//

import UIKit


protocol selectPersonalInfo {
    
    func selectGender(gender: Genero?)
    func selectCivilState(civilState: EstadoCivil?)
}

class dataDriverViewController: stylesViewController, @preconcurrency selectPersonalInfo {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPaternalSurname: UITextField!
    @IBOutlet weak var txtMaternalSurname: UITextField!
    @IBOutlet weak var txtRFC: UITextField!
    @IBOutlet weak var useTypeView: UIView!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var btnContinue: UIButton!
    
    @IBOutlet weak var genderAvailableView: UIView!
    @IBOutlet weak var subTitleFormOneLabe0: UILabel!
    @IBOutlet weak var genderFormView: UIView!
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var civilStateAvailableView: UIView!
    @IBOutlet weak var subTitleFormOneLabel: UILabel!
    @IBOutlet weak var civilStateFormView: UIView!
    @IBOutlet weak var civilStateLabel: UILabel!
    
    var datePicker: UIDatePicker!
    var dataCar: Int = 0
    var genero: Genero?
    var estadoCivil: EstadoCivil?
    var vehicleType:TipoVehiculo?
    var modelSelected:Modelo?
    var brandSelected: Marcas?
    var subBrandSelected: SubMarcas?
    var versionSelected: Version?
    var postalCode: String?
    var insurance:BasicQuotation?
    var planSelected : Cotizacion.CoberturaPlan?
    var serial : String?
    var carPlateNumber : String?
    var motorNumber : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emptyBorders(view: useTypeView)
        
  
        print("btnContinue inicialmente deshabilitado")
        
        txtName.delegate = self
        txtPaternalSurname.delegate = self
        txtMaternalSurname.delegate = self
     
        txtRFC.delegate = self
      
        txtDate.delegate = self
        
        txtName.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        txtPaternalSurname.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        txtMaternalSurname.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        txtRFC.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        
        txtDate.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        
        setupDatePicker()
        
        self.emptyBorders(view: genderFormView,label: genderLabel)
        self.emptyBorders(view: civilStateFormView, label: civilStateLabel)
        self.emptyBorders(view: txtName)
        self.emptyBorders(view: txtPaternalSurname)
        self.emptyBorders(view: txtMaternalSurname)
        self.emptyBorders(view: txtRFC)
        
    }
    
    func selectGender(gender: Genero?) {
        
            self.genero = gender
            genderLabel.text = gender?.name
            self.completeBorders(view: genderFormView, label: genderLabel)
          
            
        
    }
    
    func selectCivilState(civilState: EstadoCivil?) {
        
            self.estadoCivil = civilState
        civilStateLabel.text = civilState?.name
            self.completeBorders(view: civilStateFormView, label: civilStateLabel)
       
            
        
    }
    
    @IBAction func selectPickerAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle.module)
        let switchViewController = storyboard.instantiateViewController(withIdentifier: "selectPicker") as! selectPickerViewController
        switchViewController.step = sender.tag
        switchViewController.delegatePersonalInfo = self
        switchViewController.modalPresentationStyle = .popover
        switchViewController.isModalInPresentation = true
        self.present(UINavigationController(rootViewController: switchViewController), animated: true, completion: nil)
    }
    
    func setupDatePicker() {
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.maximumDate = Date()
        datePicker.locale = Locale(identifier: "es_MX")
        
        txtDate.inputView = datePicker
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let doneButton = UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(dismissDatePicker))
        toolbar.setItems([flexSpace,doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        txtDate.inputAccessoryView = toolbar
    }
    
    @objc func dismissDatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        txtDate.text = formatter.string(from: datePicker.date)
        print("Fecha seleccionada: \(txtDate.text ?? "N/A")")
        textFieldsDidChange()
        self.completeBorders(view: useTypeView, label: nil)
        view.endEditing(true)
    }
    
    @IBAction func continueAction(_ sender: Any) {
        guard let name = txtName.text?.trimmingCharacters(in: .whitespaces), !name.isEmpty,
              let paternal = txtPaternalSurname.text?.trimmingCharacters(in: .whitespaces), !paternal.isEmpty,
              let maternal = txtMaternalSurname.text?.trimmingCharacters(in: .whitespaces), !maternal.isEmpty,
              let date = txtDate.text?.trimmingCharacters(in: .whitespaces), !date.isEmpty,
        let gender = genderLabel.text?.trimmingCharacters(in: .whitespaces), !gender.isEmpty,
        let maritalStatus = civilStateLabel.text?.trimmingCharacters(in: .whitespaces), !maritalStatus.isEmpty,
        let rfc = txtRFC.text?.trimmingCharacters(in: .whitespaces), !rfc.isEmpty
        else {
            showAlert(title: "Aviso", message: "Por favor, completa todos los campos.")
            print("Continuar presionado pero hay campos vacíos")
            return
        }
        
        PayQuotationData.shared.name = name
        PayQuotationData.shared.paternalSurname = paternal
        PayQuotationData.shared.maternalSurname = maternal
        PayQuotationData.shared.gender = Int(genero?.id ?? "")
        PayQuotationData.shared.maritalStatus = Int(estadoCivil?.id ?? "")
        PayQuotationData.shared.rfc = rfc
        PayQuotationData.shared.birthDate = date
        
        NetworkDataRequest.setDataDriver(idCar: dataCar, name: name, paternalSurname: paternal, maternalSurname: maternal, bornDate: date, gender: gender, maritalStatus:maritalStatus, rfc: rfc) { success, message, data in
            DispatchQueue.main.async {
                if success {
                    
                    PayQuotationData.shared.idDriver = data ?? 0
                    let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle.module)
                    let switchViewController = storyboard.instantiateViewController(withIdentifier: "selectAddress") as! addressViewController
                    switchViewController.idDriver = data ?? 0
                    switchViewController.insurance = self.insurance
                    switchViewController.brandSelected = self.brandSelected
                    switchViewController.vehicleType = self.vehicleType
                    switchViewController.modelSelected = self.modelSelected
                    switchViewController.subBrandSelected = self.subBrandSelected
                    switchViewController.versionSelected = self.versionSelected
                    switchViewController.postalCode = self.postalCode
                    switchViewController.rfc = self.txtRFC.text
                    switchViewController.name = self.txtName.text
                    switchViewController.maternalSurName = self.txtMaternalSurname.text
                    switchViewController.paternalSurName = self.txtPaternalSurname.text
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
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func textFieldsDidChange() {
        let isNameValid = !(txtName.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
        let isPaternalValid = !(txtPaternalSurname.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
        let isMaternalValid = !(txtMaternalSurname.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
        let isDateValid = !(txtDate.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
        let rfcText = txtRFC.text?.trimmingCharacters(in: .whitespaces) ?? ""
        let isRFCValid = (rfcText.count >= 12 && rfcText.count <= 13)
        
        
        if isNameValid {
            
            self.completeBorders(view: txtName, label: nil)
        } else {
            self.emptyBorders(view: txtName)
        }
        
        if isPaternalValid {
            
            self.completeBorders(view: txtPaternalSurname, label: nil)
        } else {
            self.emptyBorders(view: txtPaternalSurname)
        }
        
        if isMaternalValid {
            
            self.completeBorders(view: txtMaternalSurname, label: nil)
        } else {
            self.emptyBorders(view: txtMaternalSurname)
        }
        
        if isRFCValid {
            
            self.completeBorders(view: txtRFC, label: nil)
        } else {
            self.emptyBorders(view: txtRFC)
        }
       
     
        btnContinue.isHidden = !(isNameValid && isPaternalValid && isMaternalValid && isDateValid && isRFCValid)
               
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension dataDriverViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField == txtRFC else {
            return true
        }

        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {
            return false
        }

      
        let uppercasedString = string.uppercased()
        let updatedText = currentText.replacingCharacters(in: stringRange, with: uppercasedString)

   
        if updatedText.count > 13 {
            return false
        }

     
        textField.text = updatedText
        
      
        textFieldsDidChange()

    
        return false
    }

}


