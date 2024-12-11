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
    
    func selectYear(year: String)
    
    func selectModel(model: SubMarcas?)
    
    func selectVersion(version: Version?)
}

class formAutomobileViewController: stylesViewController, @preconcurrency selectBrandProtocol {
    

    
    var vehicle:TipoVehiculo?
    var modelSelected:Int?
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
        switchViewController.modelSelected = self.modelSelected ?? 0
        switchViewController.brandSelected = self.brandSelected?.id ?? 0
        switchViewController.subBrandSelected = self.subBrandSelected?.id ?? 0
        switchViewController.delegate = self
        switchViewController.modalPresentationStyle = .popover
        switchViewController.isModalInPresentation = true
        self.present(UINavigationController(rootViewController: switchViewController), animated: true, completion: nil)
        
    }
    
    @IBAction func sendInformationAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle.module)
        let switchViewController = storyboard.instantiateViewController(withIdentifier: "selectInsurance") as! selectInsuranceViewController
        switchViewController.brandSelected = self.brandSelected?.id ?? 0
        switchViewController.vehicleType = self.vehicle?.tipoVehiculoBase ?? 0
        switchViewController.modelSelected = self.modelSelected ?? 0
        switchViewController.subBrandSelected = self.subBrandSelected?.id ?? 0
        switchViewController.internalKey = self.versionSelected?.id ?? ""
        switchViewController.modalPresentationStyle = .popover
        switchViewController.isModalInPresentation = true
        self.present(UINavigationController(rootViewController: switchViewController), animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        postalCodeTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        postalCodeTextField.delegate = self
        setStyle()
    }
    
    func setStyle() {
        self.emptyBorders(view: brandFormView)
        self.emptyBorders(view: typeFormView)
        self.emptyBorders(view: yearFormView)
        self.emptyBorders(view: modelFormView)
        self.emptyBorders(view: versionFormView)
        self.emptyBorders(view: postalCodeFormView)
        
        self.roundButton(button: sendInformationButton)
    }
    
    // Delegate
    
    func selectType(type: TipoVehiculo?) {
        if self.vehicle?.tipoVehiculoBase != type?.tipoVehiculoBase {
            self.vehicle = type
            typeAutomobileLabel.text = type?.descripcion
            self.completeBorders(view: typeFormView, label: typeAutomobileLabel)
   
            yearAvailableView.isHidden = false

            yearAutomobileLabel.text = ""
            resetBrand()
            resetModel()
            resetVersion()
            resetPostalCode()
        }
    }

    func selectYear(year: String) {
        let newYear = Int(year) ?? 0
        if self.modelSelected != newYear {
            self.modelSelected = newYear
            yearAutomobileLabel.text = year
            self.completeBorders(view: yearFormView, label: yearAutomobileLabel)
 
            brandAvailableView.isHidden = false

            brandAutomobileLabel.text = ""
            resetModel()
            resetVersion()
            resetPostalCode()
        }
    }

    func selectBrand(brand: Marcas?) {
        if self.brandSelected?.id != brand?.id {
            self.brandSelected = brand
            brandAutomobileLabel.text = brand?.marca
            self.completeBorders(view: brandFormView, label: brandAutomobileLabel)

            modelAvailableView.isHidden = false
      
            modelAutomobileLabel.text = ""
            resetVersion()
            resetPostalCode()
        }
    }

    func selectModel(model: SubMarcas?) {
        if self.subBrandSelected?.id != model?.id {
            self.subBrandSelected = model
            modelAutomobileLabel.text = model?.subMarca
            self.completeBorders(view: modelFormView, label: modelAutomobileLabel)
        
            versionAvailableView.isHidden = false
            versionAutomobileLabel.text = ""
           
            resetPostalCode()
        }
    }

    func selectVersion(version: Version?) {
        versionAutomobileLabel.text = version?.descripcion
        self.versionSelected = version
        self.completeBorders(view: versionFormView, label: versionAutomobileLabel)
        postalCodeAvailableView.isHidden = false
       
    }


    func resetBrand() {
        brandAvailableView.isHidden = true
        brandAutomobileLabel.text = ""
        self.emptyBorders(view: brandFormView)
        self.brandSelected = nil
    }

    func resetModel() {
        modelAvailableView.isHidden = true
        modelAutomobileLabel.text = ""
        self.emptyBorders(view: modelFormView)
        self.subBrandSelected = nil
    }

    func resetVersion() {
        versionAvailableView.isHidden = true
        versionAutomobileLabel.text = ""
        self.emptyBorders(view: versionFormView)
    }

    func resetPostalCode() {
        postalCodeAvailableView.isHidden = true
        postalCodeTextField.text = ""
        self.emptyBorders(view: postalCodeFormView)
        sendInformationButton.isHidden = true
    }


    
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
extension formAutomobileViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }

        if textField == postalCodeTextField {
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

            return updatedText.count <= 5
        }else{
            return true
        }
    }
}
