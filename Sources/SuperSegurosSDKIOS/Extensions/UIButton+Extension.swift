//
//  UIButton+Extension.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 25/11/24.
//

import UIKit

enum ButtonStyle {
  
    case primary

   
}

extension UIButton {

    func applyStyle(_ style: ButtonStyle) {
        switch style {
        case .primary:
            configurePrimaryStyle()
        }
    }
    
  
    private func configurePrimaryStyle() {
    
        self.backgroundColor =  UIColor.moduleColor(named: "rosaSuper")
        self.titleLabel?.font = UIFont.poppinsSemiBold(size: 15)
        self.setTitleColor(.white, for: .normal)
        self.frame.size = CGSize(width: 334.0, height: 40.0)
        self.layer.cornerRadius = 24.0
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.15).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 10.0
    }
    
   
}
