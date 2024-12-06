//
//  UIFont+Extension.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 25/11/24.
//

import UIKit

extension UIFont {
    
    static func poppinsLight(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Light", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func poppinsRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func poppinsBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Bold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
    
    static func poppinsSemiBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-SemiBold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .semibold)
    }
}
