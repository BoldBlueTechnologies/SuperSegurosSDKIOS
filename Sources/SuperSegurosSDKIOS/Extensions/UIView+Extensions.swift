//
//  UIView+Extensions.swift
//  UseLibrary
//
//  Created by Christian Martinez on 22/11/24.
//

import UIKit

extension UIView {
    func parentView<T: UIView>(of type: T.Type) -> T? {
        var parent = self.superview
        while let currentParent = parent {
            if let parent = currentParent as? T {
                return parent
            }
            parent = currentParent.superview
        }
        return nil
    }
    
    func parentViewController() -> UIViewController? {
        var parentResponder: UIResponder? = self
        while let currentResponder = parentResponder {
            if let viewController = currentResponder as? UIViewController {
                return viewController
            }
            parentResponder = currentResponder.next
        }
        return nil
    }
    
    
    
    
    func applyRoundedShadowStyle(
           cornerRadius: CGFloat = 10.0,
           backgroundColor: UIColor = UIColor.white,
           shadowColor: UIColor = UIColor(red: 26.0 / 255.0, green: 118.0 / 255.0, blue: 1.0, alpha: 0.16),
           shadowRadius: CGFloat = 6.0,
           shadowOffset: CGSize = CGSize(width: 0.0, height: 3.0)
       ) {
         
           self.backgroundColor = backgroundColor

        
           self.layer.cornerRadius = cornerRadius
           self.layer.masksToBounds = false

    
           self.layer.shadowColor = shadowColor.cgColor
           self.layer.shadowOpacity = 1.0
           self.layer.shadowRadius = shadowRadius
           self.layer.shadowOffset = shadowOffset
       }
    
    func applyRoundedStyle(
           cornerRadius: CGFloat = 10.0,
           backgroundColor: UIColor = .white,
           shadowColor: UIColor = UIColor(red: 191.0 / 255.0, green: 148.0 / 255.0, blue: 252.0 / 255.0, alpha: 0.2),
           shadowRadius: CGFloat = 6.0,
           shadowOffset: CGSize = CGSize(width: 0.0, height: 0.0)
       ) {
         
           self.backgroundColor = backgroundColor

          
           self.layer.cornerRadius = cornerRadius
           self.layer.masksToBounds = false

     
           self.layer.shadowColor = shadowColor.cgColor
           self.layer.shadowOpacity = 1.0
           self.layer.shadowRadius = shadowRadius
           self.layer.shadowOffset = shadowOffset
       }
    
    
    
    
    func applyCustomBorderStyle(
        cornerRadius: CGFloat = 10.0,
        backgroundColor: UIColor = .white,
        borderColor: UIColor = UIColor(white: 227.0 / 255.0, alpha: 1.0),
        borderWidth: CGFloat = 1.0,
        insetBy: CGFloat = 0.5
    ) {
        
        self.backgroundColor = backgroundColor

       
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
       
        let borderLayer = CAShapeLayer()
        borderLayer.name = "customBorderLayer"

     
        let adjustedRect = self.bounds.insetBy(dx: insetBy, dy: insetBy)
        let path = UIBezierPath(roundedRect: adjustedRect, cornerRadius: cornerRadius)
        borderLayer.path = path.cgPath

        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.lineWidth = borderWidth

      
        self.layer.sublayers?.removeAll(where: { $0.name == "customBorderLayer" })

        self.layer.addSublayer(borderLayer)
    }
   
}
