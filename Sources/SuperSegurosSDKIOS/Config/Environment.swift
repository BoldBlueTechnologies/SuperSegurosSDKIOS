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
        case .Production: return "https://apihealth.midoconline.com/api/"
        }
    }
      
    var appKey: String {
        switch self {
        case .Development: return "jts1LXZ681Q7jKz7hVPwDmjkp1B9KrHNd"
        case .Production: return "jts1LXZ681Q7jKz7hVPwDmjkp1B9KrHNd"
        }
    }
    

    var URL_PHOTOS: String {
        switch self {
        case .Development: return "https://dev-super-storage.s3.us-east-1.amazonaws.com/"
        case .Production: return "https://dev-super-storage.s3.us-east-1.amazonaws.com/"
        }
    }
    
   
    
   
}
