//
//  preFormViewController.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 25/11/24.
//

import UIKit

class preFormViewController: UIViewController {
    
    var vehicleType:TipoVehiculo?
    var modelSelected:Modelo?
    var brandSelected: Marcas?
    var subBrandSelected: SubMarcas?
    var versionSelected: Version?
    var postalCode: String?
    var insurance:BasicQuotation?
 
        
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    
    }
    
    @IBAction func continueAction(_ sender: Any) {
        
        
        let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle.module)
        let switchViewController = storyboard.instantiateViewController(withIdentifier: "dataVehicle") as! dataVehicleViewController
        switchViewController.insurance = insurance
        switchViewController.brandSelected = self.brandSelected
        switchViewController.vehicleType = self.vehicleType
        switchViewController.modelSelected = self.modelSelected
        switchViewController.subBrandSelected = self.subBrandSelected
        switchViewController.versionSelected = self.versionSelected
        switchViewController.postalCode = self.postalCode
        switchViewController.modalPresentationStyle = .fullScreen
        switchViewController.isModalInPresentation = true
        self.present(UINavigationController(rootViewController: switchViewController), animated: true, completion: nil)
        
        
    }
}
