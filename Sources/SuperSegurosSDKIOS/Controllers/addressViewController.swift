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
    var genderSelected: Genero?
    var maritalStatusSelected: EstadoCivil?
    var vehicleType: TipoVehiculo?
    var modelSelected: Modelo?
    var brandSelected: Marcas?
    var subBrandSelected: SubMarcas?
    var versionSelected: Version?
    var postalCode: String?
    var name: String?
    var paternalSurName: String?
    var maternalSurName: String?
    var rfc: String?
    var insurance: BasicQuotation?
    var planSelected: Cotizacion.CoberturaPlan?
    
    private var addressData: Address?
    private var pickerView = UIPickerView()
    private var colonias: [Address.Colonia] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        self.txtState.isUserInteractionEnabled = false
        self.txtCity.isUserInteractionEnabled = false
        self.postalCodeTextField.isUserInteractionEnabled = false
        
        if let postalCode = self.postalCode {
            postalCodeTextField.text = postalCode
            if postalCode.count >= 5 {
                callGetAddressService(for: postalCode)
            }
        }
        
        setupDelegates()
        setupPickerForSuburb()
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
            showAlert(title: "Aviso", message: "Por favor, completa todos los campos correctamente.")
            return
        }
        
        let intNum = txtIntNum.text?.trimmingCharacters(in: .whitespaces) ?? ""
        
        PayQuotationData.shared.entity = state
        PayQuotationData.shared.municipality = city
        PayQuotationData.shared.neighborhood = suburb
        PayQuotationData.shared.street = street
        PayQuotationData.shared.zipCode = postalCode
        PayQuotationData.shared.extNumber = extNum
            
        NetworkDataRequest.setDataAddress(
            idDriver: idDriver,
            street: street,
            apartmentNumber: intNum,
            streetNumber: extNum,
            state: state,
            city: city,
            zipCode: postalCode,
            neighborhood: suburb
        ) { success, message, data in
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
                    switchViewController.rfc = self.rfc
                    switchViewController.planSelected = self.planSelected
                    self.present(UINavigationController(rootViewController: switchViewController), animated: true, completion: nil)
                } else {
                    self.showAlert(title: "Aviso", message: message)
                }
            }
        }
    }
    
    private func setupDelegates() {
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
    
    private func setupPickerForSuburb() {
        pickerView.delegate = self
        pickerView.dataSource = self
        txtSuburb.inputView = pickerView
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let doneButton = UIBarButtonItem(
            title: "Listo",
            style: .done,
            target: self,
            action: #selector(donePickingSuburb)
        )
   
        toolbar.items = [flexSpace, doneButton]
        txtSuburb.inputAccessoryView = toolbar
    }

    @objc private func donePickingSuburb() {
        txtSuburb.resignFirstResponder()
    }

    
    private func callGetAddressService(for postalCode: String) {
        guard let cpInt = Int(postalCode) else { return }
        NetworkDataRequest.getAddress(postalCode: cpInt) { success, message, addresses in
           
                if success, let addressList = addresses {
       
                        self.addressData = addressList
                        self.fillFieldsWithAddressData(addressList)
                    
                } else {
                    self.addressData = nil
                    self.txtCity.text = ""
                    self.txtState.text = ""
                    self.txtSuburb.text = ""
                }
            }
        
    }
    
    private func fillFieldsWithAddressData(_ address: Address) {
        txtCity.text = address.municipio?.nombre
        txtState.text = address.estado?.nombre
        
        if let colonias = address.colonias, !colonias.isEmpty {
            self.colonias = colonias
            if colonias.count == 1 {
                txtSuburb.text = colonias.first?.colonia
            } else {
                txtSuburb.text = ""
            }
        } else {
            self.colonias.removeAll()
            txtSuburb.text = ""
        }
    }
    
    @objc func textFieldsDidChange() {
        if let text = postalCodeTextField.text, text.count == 5 {
            callGetAddressService(for: text)
        }
        
     
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

extension addressViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colonias.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colonias[row].colonia
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtSuburb.text = colonias[row].colonia
    }
}
