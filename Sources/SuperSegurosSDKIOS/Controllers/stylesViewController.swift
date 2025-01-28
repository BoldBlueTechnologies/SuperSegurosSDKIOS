//
//  stylesViewController.swift
//  SuperSegurosSDKIOS
//
//  Created by Oscar Aguilar on 13/11/24.
//

import UIKit
import IQKeyboardManagerSwift

class stylesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .light
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.resignOnTouchOutside = true

        if #available(iOS 18.0, *) {
            if UIDevice.current.userInterfaceIdiom == .pad {
                self.preferredContentSize = CGSizeMake(self.view.frame.size.width , self.view.frame.size.height)
            }
        }

    }
    
    func emptyBorders(view: UIView,  label: UILabel? = nil) {
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 1.0).cgColor
        view.layer.masksToBounds = true
        
        if let label = label {
            label.textColor = .lightGray
        }
    }
    
    func completeBorders(view: UIView, label: UILabel?) {
        view.layer.borderColor = UIColor(red: 191/255, green: 148/255, blue: 252/255, alpha: 1.0).cgColor
        view.layer.borderWidth = 1
       view.layer.cornerRadius = 10
           view.layer.masksToBounds = true
        label?.textColor = .black
    }
    
    func roundButton(button: UIButton) {
        button.layer.cornerRadius = 20
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "(?:[a-zA-Z0-9!#\\$%\\&'*+/=?^_`{|}~.-]+)@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }

    
    func showProgressHUD(title:String = "Cargando...") {
        
      //  self.view.addSubview(progressHUD)
     //   self.progressHUD.show(title: title)
        
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            let loader = NativeProgressHUD.shared
            loader.frame = window.bounds
            loader.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            window.addSubview(loader)
            loader.show(title: title)
        }
        
    }

    func dismissProgressHUD(delay: Double = 0.0) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
           // self.progressHUD.hide()
            NativeProgressHUD.shared.hide()
            NativeProgressHUD.shared.removeFromSuperview()
        }
    }
    

}
