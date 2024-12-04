//
//  dataDriverViewController.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 26/11/24.
//

import UIKit

class dataDriverViewController: stylesViewController {
    
    @IBOutlet weak var txtPlate: UITextField!
    @IBOutlet weak var txtVIN: UITextField!
    @IBOutlet weak var txtEngine: UITextField!
    @IBOutlet weak var useTypeView: UIView!
    @IBOutlet weak var txtUse: UITextField!
    
    var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emptyBorders(view: useTypeView)
        
      
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.maximumDate = Date()
        datePicker.locale = Locale(identifier: "es_MX")
        
      
        txtUse.inputView = datePicker
        
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(dismissDatePicker))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        txtUse.inputAccessoryView = toolbar
    }
    
    // MARK: - Acciones
    
    @objc func dismissDatePicker() {
   
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        txtUse.text = formatter.string(from: datePicker.date)
        
       
        view.endEditing(true)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
