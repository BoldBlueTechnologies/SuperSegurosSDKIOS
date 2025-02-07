//
//  Environment.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 09/12/24.
//


import UIKit

 
enum Environment: String {
    
    
    case Development = "development"
    case Production = "production"
    
    var baseURL: String {
        switch self {
        case .Development: return "https://devapiensurance.super.mx/api/"
        case .Production: return "https://apiensurance.super.mx/api/"
        }
    }
      
    var appKey: String {
        switch self {
        case .Development: return "jts1LXZ681Q7jKz7hVPwDmjkp1B9KrHNd"
        case .Production: return "lXzQa78LkP83MzWdR4YcVjTF0GoH2uXqfa"
        }
    }
    
   
}
