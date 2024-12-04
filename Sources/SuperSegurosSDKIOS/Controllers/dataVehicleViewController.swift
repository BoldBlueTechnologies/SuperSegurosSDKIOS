//
//  dataVehicleViewController.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 26/11/24.
//

import UIKit

protocol selectUseProtocol {
    func selectUseType(useType: String)

}

class dataVehicleViewController: stylesViewController, @preconcurrency selectUseProtocol {
    
    @IBOutlet weak var txtPlate: UITextField!
    @IBOutlet weak var txtVIN: UITextField!
    @IBOutlet weak var txtEngine: UITextField!
   
    @IBOutlet weak var useTypeView: UIView!
    @IBOutlet weak var useTypeFormView: UIView!
    @IBOutlet weak var useTypeLabel: UILabel!
   
    
    @IBAction func selectPickerAction(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle.module)
        let switchViewController = storyboard.instantiateViewController(withIdentifier: "selectPicker") as! selectPickerViewController
        switchViewController.step = 6
        switchViewController.useTypeDelegate = self
        switchViewController.modalPresentationStyle = .popover
        switchViewController.isModalInPresentation = true
        self.present(UINavigationController(rootViewController: switchViewController), animated: true, completion: nil)
        
    }
    
    func selectUseType(useType: String) {
        useTypeLabel.text = useType
        self.completeBorders(view: useTypeFormView, label: useTypeLabel)
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emptyBorders(view: useTypeView)
        
       

    }
    
   
    
    // MARK: - Acciones
    
 
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
