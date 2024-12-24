//
//  paymentSummaryViewController.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 27/11/24.
//

import UIKit

class paymentSummaryViewController: UIViewController {
 
        
    var planSelected : Cotizacion.CoberturaPlan?
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
    
    @IBOutlet weak var lblInsurance: UILabel!
    @IBOutlet weak var lblTotalCoverage: UILabel!
    
    @IBOutlet weak var lblPayment: UILabel!
    @IBOutlet weak var lblCar: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        if let insurance = insurance {
            self.lblInsurance.text = insurance.aseguradora
        }
        
        if let brand = brandSelected?.marca, let model = modelSelected?.modelo, let subMarca = subBrandSelected?.subMarca, let version = versionSelected?.descripcion {
            
            self.lblCar.text = "\(brand) \(String(model)) \(subMarca) \(version)"
            
        }
        
        if let planSelected = planSelected {
            
            lblTotalCoverage.text = "\(planSelected.costoTotal?.montoFormateado ?? "") \(planSelected.formaPago ?? "")"
            
            lblPayment.text = "\(planSelected.subSecuentes?.montoFormateado ?? "") \(planSelected.formaPago ?? "")"
            
          
        }
        
    
    }
    
}

