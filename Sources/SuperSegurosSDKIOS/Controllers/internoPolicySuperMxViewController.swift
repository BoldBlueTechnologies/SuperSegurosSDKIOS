//
//  internoPolicySuperMxViewController.swift
//  midoconlineapp
//
//  Created by Christian Martinez on 10/01/24.
//

import UIKit

class internoPolicySuperMxViewController: stylesViewController {


    @IBOutlet weak var viewSpecs: UIView!
 
    @IBOutlet weak var lblPolicy: UILabel!
    
    @IBOutlet weak var lblVersion: UILabel!
    @IBOutlet weak var lblModel: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblBrand: UILabel!
    @IBOutlet weak var lblExpirationDate: UILabel!
    @IBOutlet weak var imgInsurance: UIImageView!
    @IBOutlet weak var viewGeneralConditions: UIView!
    @IBOutlet weak var policyCertificate: UIView!
    @IBOutlet weak var viewPlicyapplication: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

      
        
        if let policy = PayQuotationData.shared.quote?.numeroCotizacion {
         
            self.lblPolicy.text = policy
        }
        
        if let model = PayQuotationData.shared.model {
         
            self.lblModel.text = model
        }
        
        if let version = PayQuotationData.shared.version {
         
            self.lblVersion.text = version
        }
        
        if let brand = PayQuotationData.shared.brand {
         
            self.lblBrand.text = brand
        }
        
        if let year = PayQuotationData.shared.carYear {
         
            self.lblYear.text = year
        }
        
        if let startingAt = PayQuotationData.shared.startingAt {
         
            self.lblExpirationDate.text = startingAt
        }
        
        
        if let insurance = PayQuotationData.shared.insuranceImg {
            let url = URL(string: "\(insurance)")!
            UIImage.loadFrom(url: url) { image in
                self.imgInsurance.image = image
            }
        }
        
        
 
        let tapGeneralConditions = UITapGestureRecognizer(target: self, action: #selector(openCoverage(_:)))
        viewGeneralConditions.addGestureRecognizer(tapGeneralConditions)
        viewGeneralConditions.isUserInteractionEnabled = true

      
        let tapPolicyCertificate = UITapGestureRecognizer(target: self, action: #selector(openPolicy(_:)))
        policyCertificate.addGestureRecognizer(tapPolicyCertificate)
        policyCertificate.isUserInteractionEnabled = true

 
        let tapPaymentReceipt = UITapGestureRecognizer(target: self, action: #selector(openPaymentReceipt(_:)))
        viewPlicyapplication.addGestureRecognizer(tapPaymentReceipt)
        viewPlicyapplication.isUserInteractionEnabled = true
        
        
        self.setStyle()
    }
    
    func setStyle(){
  
        
        self.viewPlicyapplication.applyRoundedShadowStyle()
        self.policyCertificate.applyRoundedShadowStyle()
        self.viewGeneralConditions.applyRoundedShadowStyle()
     
        self.viewSpecs.applyRoundedShadowStyle()
        

    }

    @IBAction func openPaymentReceipt(_ sender: Any) {
        
        guard let urlString = PayQuotationData.shared.receiptPath,
                 let url = URL(string: urlString) else {
               return
           }
           UIApplication.shared.open(url, options: [:], completionHandler: nil)
       
    }
    
    
    @IBAction func openPolicy(_ sender: Any) {
        
        guard let urlString = PayQuotationData.shared.policyPath,
                 let url = URL(string: urlString) else {
               return
           }
           UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func openCoverage(_ sender: Any) {
        
        guard let urlString = PayQuotationData.shared.rcusaPath,
                 let url = URL(string: urlString) else {
               return
           }
           UIApplication.shared.open(url, options: [:], completionHandler: nil)
        
        
    }
    
    
    @IBAction func openConditions(_ sender: Any) {
        
        
        if let url = URL(string: "https://generaldeseguros.mx/home/condiciones-generales-menu/") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func callAction(_ sender: Any) {
        
        let phoneNumber = "8004727696"
           if let url = URL(string: "tel://\(phoneNumber)") {
               UIApplication.shared.open(url, options: [:], completionHandler: nil)
           }
    }
    
    @IBAction func closeAction(_ sender: Any) {
        
        var vcToDismiss = self.presentingViewController
           
           while let pvc = vcToDismiss?.presentingViewController {
               vcToDismiss = pvc
           }
           vcToDismiss?.dismiss(animated: true, completion: nil)
        
    }
    
    
}
