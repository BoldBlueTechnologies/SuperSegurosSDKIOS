//
//  UIImage+Extension.swift.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 22/11/24.
//

import UIKit

public extension UIImage {
   
    static func moduleImage(named name: String) -> UIImage? {
        return UIImage(named: name, in: Bundle.module, compatibleWith: nil)
    }
    
    static func moduleImage(named name: String, compatibleWith traitCollection: UITraitCollection?) -> UIImage? {
        return UIImage(named: name, in: Bundle.module, compatibleWith: traitCollection)
    }
    
    
    static func loadFrom(url: URL, completion: @MainActor @escaping (_ image: UIImage?) -> Void) {
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            Task { @MainActor in
                completion(data.flatMap { UIImage(data: $0) })
            }
        }
    }


}
