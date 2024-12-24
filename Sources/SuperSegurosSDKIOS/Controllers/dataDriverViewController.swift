//
//  dataDriverViewController.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 26/11/24.
//

import UIKit

class dataDriverViewController: stylesViewController {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPaternalSurname: UITextField!
    @IBOutlet weak var txtMaternalSurname: UITextField!
    @IBOutlet weak var useTypeView: UIView!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var btnContinue: UIButton!
    
    var datePicker: UIDatePicker!
    var dataCar: Int = 0
    
    var vehicleType:TipoVehiculo?
    var modelSelected:Modelo?
    var brandSelected: Marcas?
    var subBrandSelected: SubMarcas?
    var versionSelected: Version?
    var postalCode: String?
    var insurance:BasicQuotation?
    var planSelected : Cotizacion.CoberturaPlan?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emptyBorders(view: useTypeView)
        
  
        print("btnContinue inicialmente deshabilitado")
        
        txtName.delegate = self
        txtPaternalSurname.delegate = self
        txtMaternalSurname.delegate = self
        txtDate.delegate = self
        
        txtName.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        txtPaternalSurname.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        txtMaternalSurname.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        txtDate.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        
        setupDatePicker()
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
        let doneButton = UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(dismissDatePicker))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        txtDate.inputAccessoryView = toolbar
    }
    
    @objc func dismissDatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        txtDate.text = formatter.string(from: datePicker.date)
        print("Fecha seleccionada: \(txtDate.text ?? "N/A")")
        textFieldsDidChange()
        view.endEditing(true)
    }
    
    @IBAction func continueAction(_ sender: Any) {
        guard let name = txtName.text?.trimmingCharacters(in: .whitespaces), !name.isEmpty,
              let paternal = txtPaternalSurname.text?.trimmingCharacters(in: .whitespaces), !paternal.isEmpty,
              let maternal = txtMaternalSurname.text?.trimmingCharacters(in: .whitespaces), !maternal.isEmpty,
              let date = txtDate.text?.trimmingCharacters(in: .whitespaces), !date.isEmpty else {
            showAlert(title: "Error", message: "Por favor, completa todos los campos.")
            print("Continuar presionado pero hay campos vacíos")
            return
        }
        
        print("Todos los campos están llenos. Enviando datos...")
        
        NetworkDataRequest.setDataDriver(idCar: dataCar, name: name, paternalSurname: paternal, maternalSurname: maternal, bornDate: date) { success, message, data in
            DispatchQueue.main.async {
                if success {
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
                    switchViewController.name = self.txtName.text
                    switchViewController.maternalSurName = self.txtMaternalSurname.text
                    switchViewController.paternalSurName = self.txtPaternalSurname.text
                    switchViewController.planSelected = self.planSelected
                    switchViewController.modalPresentationStyle = .fullScreen
                    switchViewController.isModalInPresentation = true
                    self.present(UINavigationController(rootViewController: switchViewController), animated: true, completion: nil)
                } else {
                    self.showAlert(title: "Error", message: message)
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
        
        btnContinue.isHidden = !(isNameValid && isPaternalValid && isMaternalValid && isDateValid)
               
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension dataDriverViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}


