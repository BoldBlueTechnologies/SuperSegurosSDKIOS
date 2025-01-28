//
//  formAutomobileViewController.swift
//  SuperSegurosSDKIOS
//
//  Created by Oscar Aguilar on 12/11/24.
//

//
//  formAutomobileViewController.swift
//  SuperSegurosSDKIOS
//
//  Created by Oscar Aguilar on 12/11/24.
//

import UIKit

protocol selectBrandProtocol {
    func selectType(type: TipoVehiculo?)
    func selectBrand(brand: Marcas?)
    func selectYear(year: Modelo?)
    func selectModel(model: SubMarcas?)
    func selectVersion(version: Version?)
}

class formAutomobileViewController: stylesViewController, @preconcurrency selectBrandProtocol {
    
    var vehicle: TipoVehiculo?
    var modelSelected: Modelo?
    var brandSelected: Marcas?
    var subBrandSelected: SubMarcas?
    var versionSelected: Version?
    
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var titleOneLabel: UILabel!
    @IBOutlet weak var subTtitleOneLabel: UILabel!
    @IBOutlet weak var preSubTitleLabel: UILabel!
    
    @IBOutlet weak var typeAvailableView: UIView!
    @IBOutlet weak var subTitleFormOneLabe0: UILabel!
    @IBOutlet weak var typeFormView: UIView!
    @IBOutlet weak var typeAutomobileLabel: UILabel!
    
    @IBOutlet weak var brandAvailableView: UIView!
    @IBOutlet weak var subTitleFormOneLabel: UILabel!
    @IBOutlet weak var brandFormView: UIView!
    @IBOutlet weak var brandAutomobileLabel: UILabel!
    
    @IBOutlet weak var yearAvailableView: UIView!
    @IBOutlet weak var subTitleFormTwoLabel: UILabel!
    @IBOutlet weak var yearFormView: UIView!
    @IBOutlet weak var yearAutomobileLabel: UILabel!
    
    @IBOutlet weak var modelAvailableView: UIView!
    @IBOutlet weak var subTitleFormThreeLabel: UILabel!
    @IBOutlet weak var modelFormView: UIView!
    @IBOutlet weak var modelAutomobileLabel: UILabel!
    
    @IBOutlet weak var versionAvailableView: UIView!
    @IBOutlet weak var subTitleFormFourLabel: UILabel!
    @IBOutlet weak var versionFormView: UIView!
    @IBOutlet weak var versionAutomobileLabel: UILabel!
    
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
        switchViewController.vehicleType = self.vehicle?.tipoVehiculoBase ?? 0
        switchViewController.modelSelected = self.modelSelected?.modelo ?? 0
        switchViewController.brandSelected = self.brandSelected?.id ?? 0
        switchViewController.subBrandSelected = self.subBrandSelected?.id ?? 0
        switchViewController.delegate = self
        switchViewController.modalPresentationStyle = .popover
        switchViewController.isModalInPresentation = true
        self.present(UINavigationController(rootViewController: switchViewController), animated: true, completion: nil)
    }
    
    @IBAction func sendInformationAction(_ sender: Any) {
      
        self.saveQuotation(carType: self.typeAutomobileLabel.text ?? "", brand: self.brandAutomobileLabel.text ?? "", year: self.yearAutomobileLabel.text ?? "", model: self.modelAutomobileLabel.text ?? "", version: self.versionAutomobileLabel.text ?? "", postalCode: self.postalCodeTextField.text ?? "")
        
        PayQuotationData.shared.vehicle = self.vehicle
    }
    
    func saveQuotation(carType: String,  brand: String, year: String, model: String, version: String, postalCode: String) {
        NetworkDataRequest.saveQuotation(
            carType: carType,
            year: year,
            brand: brand,
            model: model,
            version: version,
            postalCode: postalCode
        ) { success, message, pickersData in
            
        
            if success, let data = pickersData {
                
                PayQuotationData.shared.typeVehicleId = self.vehicle?.tipoVehiculoBase
               
                let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle.module)
                let switchViewController = storyboard.instantiateViewController(withIdentifier: "selectInsurance") as! selectInsuranceViewController
                switchViewController.brandSelected = self.brandSelected
                switchViewController.vehicleType = self.vehicle
                switchViewController.carQuoteId = data
                switchViewController.modelSelected = self.modelSelected
                switchViewController.subBrandSelected = self.subBrandSelected
                switchViewController.versionSelected = self.versionSelected
                switchViewController.postalCode = self.postalCodeTextField.text
                switchViewController.modalPresentationStyle = .popover
                switchViewController.isModalInPresentation = true
                self.present(UINavigationController(rootViewController: switchViewController), animated: true, completion: nil)
                
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        postalCodeTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        postalCodeTextField.delegate = self
        
        setStyle()
    }
    
    func setStyle() {
        self.emptyBorders(view: brandFormView,label: brandAutomobileLabel)
        self.emptyBorders(view: typeFormView, label: typeAutomobileLabel)
        self.emptyBorders(view: yearFormView, label: yearAutomobileLabel)
        self.emptyBorders(view: modelFormView, label: modelAutomobileLabel)
        self.emptyBorders(view: versionFormView, label: versionAutomobileLabel)
        self.emptyBorders(view: postalCodeFormView)
        self.roundButton(button: sendInformationButton)
    }
    
    // MARK: - selectBrandProtocol (Delegate)
    
    func selectType(type: TipoVehiculo?) {
        if self.vehicle?.tipoVehiculoBase != type?.tipoVehiculoBase {
            self.vehicle = type
            typeAutomobileLabel.text = type?.descripcion
            self.completeBorders(view: typeFormView, label: typeAutomobileLabel)
            
            yearAvailableView.isHidden = false
        
            yearAutomobileLabel.text = "Seleccione un año"
            self.emptyBorders(view: yearFormView, label: yearAutomobileLabel)
            resetBrand()
            resetModel()
            resetVersion()
            resetPostalCode()
        }
    }

    func selectYear(year: Modelo?) {
        _ = Int(year?.modelo ?? 0)
     
            self.modelSelected = year
            yearAutomobileLabel.text = String(year?.modelo ?? 0)
            self.completeBorders(view: yearFormView, label: yearAutomobileLabel)
            
            brandAvailableView.isHidden = false
            
            brandAutomobileLabel.text = "Seleccione una marca"
            self.emptyBorders(view: brandFormView, label: brandAutomobileLabel)
            resetModel()
            resetVersion()
            resetPostalCode()
        
    }

    func selectBrand(brand: Marcas?) {
      
            self.brandSelected = brand
            brandAutomobileLabel.text = brand?.marca
            self.completeBorders(view: brandFormView, label: brandAutomobileLabel)
            
            modelAvailableView.isHidden = false
          
            modelAutomobileLabel.text = "Seleccione un modelo"
            self.emptyBorders(view: modelFormView, label: modelAutomobileLabel)
            resetVersion()
            resetPostalCode()
        
    }

    func selectModel(model: SubMarcas?) {
      
            self.subBrandSelected = model
            modelAutomobileLabel.text = model?.subMarca
            self.completeBorders(view: modelFormView, label: modelAutomobileLabel)
            
            versionAvailableView.isHidden = false
        
            versionAutomobileLabel.text = "Seleccione una versión"
            self.emptyBorders(view: versionFormView, label: versionAutomobileLabel)
            resetPostalCode()
        
    }

    func selectVersion(version: Version?) {
        versionAutomobileLabel.text = version?.descripcion
        self.versionSelected = version
        self.completeBorders(view: versionFormView, label: versionAutomobileLabel)
        
        postalCodeAvailableView.isHidden = false
    }

    // MARK: - Reset Methods
    
    func resetBrand() {
        brandAvailableView.isHidden = true
        brandAutomobileLabel.text = "Seleccione una marca"
        self.emptyBorders(view: brandFormView, label: brandAutomobileLabel)
        self.brandSelected = nil
    }

    func resetModel() {
        modelAvailableView.isHidden = true
        modelAutomobileLabel.text = "Seleccione un modelo"
        self.emptyBorders(view: modelFormView, label: modelAutomobileLabel)
        self.subBrandSelected = nil
    }

    func resetVersion() {
        versionAvailableView.isHidden = true
        versionAutomobileLabel.text = "Seleccione una versión"
        self.emptyBorders(view: versionFormView, label: versionAutomobileLabel)
        self.versionSelected = nil
    }

    func resetPostalCode() {
        postalCodeAvailableView.isHidden = true
        postalCodeTextField.text = ""
      //  self.emptyBorders(view: postalCodeFormView)
        sendInformationButton.isHidden = true
    }
    
    // MARK: - Postal Code Validation
    
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

// MARK: - UITextFieldDelegate

extension formAutomobileViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        if textField == postalCodeTextField {
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 5
        } else {
            return true
        }
    }
}
