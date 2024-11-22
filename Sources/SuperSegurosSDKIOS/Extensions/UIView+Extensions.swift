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
}
