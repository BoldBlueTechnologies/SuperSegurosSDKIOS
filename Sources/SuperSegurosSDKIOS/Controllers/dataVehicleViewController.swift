//
//  dataVehicleViewController.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 26/11/24.
//


import UIKit

class dataVehicleViewController: stylesViewController {
    
    @IBOutlet weak var txtPlate: UITextField!
    @IBOutlet weak var txtVIN: UITextField!
    @IBOutlet weak var txtEngine: UITextField!
    @IBOutlet weak var continueBtn: UIButton!
    
    var vehicleType: TipoVehiculo?
    var modelSelected: Modelo?
    var brandSelected: Marcas?
    var subBrandSelected: SubMarcas?
    var versionSelected: Version?
    var postalCode: String?
    var insurance: BasicQuotation?
    var planSelected : Cotizacion.CoberturaPlan?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        continueBtn.isHidden = true
        
        // Forzar que el teclado inicie en mayúsculas
        txtPlate.autocapitalizationType = .allCharacters
        txtVIN.autocapitalizationType = .allCharacters
        txtEngine.autocapitalizationType = .allCharacters
        
        txtPlate.delegate = self
        txtVIN.delegate = self
        txtEngine.delegate = self
        
        txtPlate.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        txtVIN.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        txtEngine.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueAction(_ sender: Any) {
        guard let plate = txtPlate.text, validatePlate(plate),
              let vin = txtVIN.text, validateVIN(vin),
              let engine = txtEngine.text, validateEngine(engine) else {
            showAlert(title: "Error", message: "Por favor, asegúrate de que todos los campos estén llenos correctamente.")
            return
        }
        
        NetworkDataRequest.setDataCar(licensePlate: plate, vin: vin, engineNumber: engine) { success, message, data in
            DispatchQueue.main.async {
                if success {
                    let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle.module)
                    let switchViewController = storyboard.instantiateViewController(withIdentifier: "dataDriver") as! dataDriverViewController
                    switchViewController.dataCar = data ?? 0
                    switchViewController.insurance = self.insurance
                    switchViewController.brandSelected = self.brandSelected
                    switchViewController.vehicleType = self.vehicleType
                    switchViewController.modelSelected = self.modelSelected
                    switchViewController.subBrandSelected = self.subBrandSelected
                    switchViewController.versionSelected = self.versionSelected
                    switchViewController.postalCode = self.postalCode
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
    
    @objc func textFieldsDidChange() {
        let isPlateValid = validatePlate(txtPlate.text)
        let isVINValid = validateVIN(txtVIN.text)
        let isEngineValid = validateEngine(txtEngine.text)
        
        continueBtn.isHidden = !(isPlateValid && isVINValid && isEngineValid)
    }
    
    func validatePlate(_ plate: String?) -> Bool {
        guard let plate = plate, plate.count == 6 else {
            return false
        }
        return true
    }
    
    func validateVIN(_ vin: String?) -> Bool {
        guard let vin = vin, vin.count == 17 else {
            return false
        }
        return true
    }
    
    func validateEngine(_ engine: String?) -> Bool {
        guard let engine = engine, !engine.isEmpty else {
            return false
        }
        return true
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate

extension dataVehicleViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {
            return false
        }
        
     
        let uppercaseString = string.uppercased()
        let updatedText = currentText.replacingCharacters(in: stringRange, with: uppercaseString)
        
        if textField == txtPlate {
           
            if updatedText.count <= 8 {
                textField.text = updatedText
                textFieldsDidChange()
            }
            return false
        } else if textField == txtVIN {
      
            if updatedText.count <= 17 {
                textField.text = updatedText
                textFieldsDidChange()
            }
            return false
        } else if textField == txtEngine {
           
            textField.text = updatedText
            textFieldsDidChange()
            return false
        }
        
        return true
    }
}

