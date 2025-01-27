//
//  paymentSummaryViewController.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 27/11/24.
//



import UIKit

class paymentSummaryViewController: stylesViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var lblInsurance: UILabel!
    @IBOutlet weak var lblTotalCoverage: UILabel!
    @IBOutlet weak var viewAnnualCoverage: UIView!
    @IBOutlet weak var viewOtherCoverage: UIView!
    @IBOutlet weak var btnPay: UIButton!
    @IBOutlet weak var lblFirstPayment: UILabel!
    @IBOutlet weak var lblNextPayment: UILabel!
    @IBOutlet weak var lblOtherTotalCost: UILabel!
    @IBOutlet weak var lblOtherCoverage: UILabel!
    @IBOutlet weak var lblCoverage: UILabel!
    @IBOutlet weak var lblPayment: UILabel!
    @IBOutlet weak var lblCar: UILabel!
    @IBOutlet weak var txtHolderName: UITextField!
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var expirationDate: UITextField!
    @IBOutlet weak var txtcvv: UITextField!
    @IBOutlet weak var viewPay: UIView!
    
    // MARK: - Variables
    var planSelected: Cotizacion.CoberturaPlan?
    var vehicleType: TipoVehiculo?
    var modelSelected: Modelo?
    var brandSelected: Marcas?
    var subBrandSelected: SubMarcas?
    var versionSelected: Version?
    var postalCode: String?
    var name: String?
    var paternalSurName: String?
    var maternalSurName: String?
    var insurance: BasicQuotation?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
      
        viewPay.layer.borderWidth = 1
        viewPay.layer.borderColor = UIColor.moduleColor(named: "borderEmpty")?.cgColor
        setupTextFields()
        populateData()
    }
    
    // MARK: - Setup Functions

    func setupTextFields() {
        txtHolderName.delegate = self
        txtCardNumber.delegate = self
        expirationDate.delegate = self
        txtcvv.delegate = self
        
        txtCardNumber.keyboardType = .numberPad
        expirationDate.keyboardType = .numberPad
        txtcvv.keyboardType = .numberPad

      
        addRightViewToTextField(txtCardNumber, imageName: "paycards")
        addRightViewToTextField(txtcvv, imageName: "cardcvv")
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(donePickingExpirationDate))
        toolbar.items = [flexSpace, doneButton]
        expirationDate.inputAccessoryView = toolbar

        expirationDate.addTarget(self, action: #selector(formatExpirationDate), for: .editingChanged)
    }
    
    func addRightViewToTextField(_ textField: UITextField, imageName: String) {
     
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: textField.frame.height))
        
      
        let imageView = UIImageView(image: UIImage.moduleImage(named: imageName))
        imageView.contentMode = .scaleAspectFit
        
        if imageName == "cardcvv" {
            imageView.frame = CGRect(x: 5, y: 5, width: 30, height: containerView.frame.height - 10)
        } else {
            imageView.frame = CGRect(x: -45, y: 0, width: 80, height: containerView.frame.height - 5)
        }
            
       
        containerView.addSubview(imageView)
    
        textField.rightView = containerView
        textField.rightViewMode = .always
    }
    
    // MARK: - Populate Data
    func populateData() {
        
        if let coverage = PayQuotationData.shared.coverage {
            
            self.lblCoverage.text = "Cobertura \(coverage)"
            self.lblOtherCoverage.text = "Cobertura \(coverage)"
            
        }
        if let insurance = insurance {
            self.lblInsurance.text = insurance.nombre
        }
        
        if let brand = brandSelected?.marca,
           let model = modelSelected?.modelo,
           let subMarca = subBrandSelected?.subMarca,
           let version = versionSelected?.descripcion {
            self.lblCar.text = "\(brand) \(model) \(subMarca) \(version)"
        }
        
        if let planSelected = planSelected {
            if planSelected.formaPago == "Anual" {
                self.viewAnnualCoverage.isHidden = false
                self.viewOtherCoverage.isHidden = true
                let titleBtn = "Pagar \(planSelected.costoTotal?.montoFormateado ?? "")"
                lblTotalCoverage.text = "\(planSelected.costoTotal?.montoFormateado ?? "") / \(planSelected.formaPago ?? "")"
                btnPay.setTitle(titleBtn, for: .normal)
            } else {
                self.viewAnnualCoverage.isHidden = true
                self.viewOtherCoverage.isHidden = false
                lblOtherTotalCost.text = "\(planSelected.costoTotal?.montoFormateado ?? "")"
                lblFirstPayment.text = "\(planSelected.primerRecibo?.montoFormateado ?? "")"
                lblNextPayment.text = "\(planSelected.subSecuentes?.montoFormateado ?? "")"
                
                let titleBtn = "Pagar \(planSelected.primerRecibo?.montoFormateado ?? "")"
                btnPay.setTitle(titleBtn, for: .normal)
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func backAction(_ sender: Any) {
        
        self.dismiss(animated: true)
        
    }
    @IBAction func payaction(_ sender: Any) {
        // Recopilar y validar los datos
        guard let holderName = txtHolderName.text?.trimmingCharacters(in: .whitespaces), !holderName.isEmpty else {
            showAlert(title: "Aviso", message: "Por favor, ingresa el nombre del titular.")
            return
        }
        
        guard let cardNumber = txtCardNumber.text?.trimmingCharacters(in: .whitespaces), cardNumber.count >= 16, isNumeric(cardNumber) else {
            showAlert(title: "Aviso", message: "Por favor, ingresa un número de tarjeta válido de al menos 16 dígitos.")
            return
        }
        
        guard let expDate = expirationDate.text?.trimmingCharacters(in: .whitespaces) else {
            showAlert(title: "Aviso", message: "Por favor, ingresa una fecha de expiración válida (MM/yyyy).")
            return
        }
        
        
        let (month, year) = parseExpirationDate(expDate)
 
        guard let cvv = txtcvv.text?.trimmingCharacters(in: .whitespaces), cvv.count == 3, isNumeric(cvv) else {
            showAlert(title: "Aviso", message: "Por favor, ingresa un CVV válido de 3 dígitos.")
            return
        }
        
       
        let currentDate = getCurrentDate()
        PayQuotationData.shared.startingAt = currentDate
        self.showProgressHUD()

        NetworkDataRequest.payQuotation(
            startingAt: currentDate,
            holderName: holderName,
            cardNumber: cardNumber,
            year: year,
            month: month,
            cvv: cvv
        ) { success, message, documents in
            DispatchQueue.main.async {
              
                self.dismissProgressHUD()
                
                if success {
                    
                    PayQuotationData.shared.policyPath = documents?.documentos[0].path
                    PayQuotationData.shared.receiptPath = documents?.documentos[1].path
                    PayQuotationData.shared.rcusaPath = documents?.documentos[2].path
                    
                    if documents?.paid == 1 {
                        
                        let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle.module)
                        let switchViewController = storyboard.instantiateViewController(withIdentifier: "contractedPolicy") as! contractePolicyViewController

                        switchViewController.modalPresentationStyle = .popover
                        switchViewController.isModalInPresentation = true
                        self.present(UINavigationController(rootViewController: switchViewController), animated: true, completion: nil)
                        
                    } else {
                        
                        let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle.module)
                        let switchViewController = storyboard.instantiateViewController(withIdentifier: "nocontractedPolicy") as! noContractedPolicyViewController

                        switchViewController.modalPresentationStyle = .popover
                        switchViewController.isModalInPresentation = true
                        self.present(UINavigationController(rootViewController: switchViewController), animated: true, completion: nil)
                        
                    }
                
                } else {
                  
                    self.showAlert(title: "Aviso", message: message)
                }
            }
        }
    }
    
    // MARK: - Helper Functions
    
    @objc func donePickingExpirationDate() {
        expirationDate.resignFirstResponder()
    }
    
    @objc func formatExpirationDate() {
        guard let text = expirationDate.text else { return }
        let cleanText = text.replacingOccurrences(of: "/", with: "").replacingOccurrences(of: " ", with: "")
        var formattedText = ""
        
        if cleanText.count > 0 {
            let maxLength = 4
            let limitedText = String(cleanText.prefix(maxLength))
            for (index, char) in limitedText.enumerated() {
                if index == 2 {
                    formattedText += "/"
                }
                formattedText.append(char)
            }
        }
        
        if formattedText != expirationDate.text {
            expirationDate.text = formattedText
        }
    }
    
    func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }
    
    func isNumeric(_ text: String) -> Bool {
        let numberSet = CharacterSet.decimalDigits
        return CharacterSet(charactersIn: text).isSubset(of: numberSet)
    }
    
    func isValidExpirationDate(_ text: String) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/yyyy"
        if let date = formatter.date(from: text) {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.month, .year], from: date)
            if let month = components.month, let year = components.year {
             
                let currentYear = calendar.component(.year, from: Date())
                let currentMonth = calendar.component(.month, from: Date())
                if year > currentYear || (year == currentYear && month >= currentMonth) {
                    return true
                }
            }
        }
        return false
    }
    
    func parseExpirationDate(_ text: String) -> (String, String) {
        let components = text.split(separator: "/")
        if components.count == 2, let month = components.first, let year = components.last {
            let fullYear = "20" + year
            return (String(month), fullYear)
        }
        return ("", "")
    }
    
    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?()
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension paymentSummaryViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      
        if textField == expirationDate {
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 5
        }
        
   
        if textField == txtcvv {
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 3 && isNumeric(updatedText)
        }
        
     
        if textField == txtCardNumber {
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 16 && isNumeric(updatedText)
        }
        
        return true
    }
}
