//
//  UIColor+Extension.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 25/11/24.
//

import UIKit

public extension UIColor {
  
    static func moduleColor(named name: String) -> UIColor? {
        return UIColor(named: name, in: Bundle.module, compatibleWith: nil)
    }
    
    static func moduleColor(named name: String, compatibleWith traitCollection: UITraitCollection?) -> UIColor? {
        return UIColor(named: name, in: Bundle.module, compatibleWith: traitCollection)
    }
}
