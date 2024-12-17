//
//  File.swift
//  SuperSegurosSDKIOS
//
//  Created by Oscar Aguilar on 12/11/24.
//

import UIKit
import CoreGraphics
import CoreText
import Foundation

public enum FontError: Swift.Error {
   case failedToRegisterFont
}

func registerFont(named name: String) throws {
    print("-------------------")
    print("-------------------")
    print(name)
    print(NSDataAsset(name: "Fonts/\(name)", bundle: Bundle.module))
    print("-------------------")
    print("-------------------")
    
    guard let asset = NSDataAsset(name: "Fonts/\(name)", bundle: Bundle.module),
          let provider = CGDataProvider(data: asset.data as NSData),
          let font = CGFont(provider),
          CTFontManagerRegisterGraphicsFont(font, nil) else {
            throw FontError.failedToRegisterFont
          }
}
