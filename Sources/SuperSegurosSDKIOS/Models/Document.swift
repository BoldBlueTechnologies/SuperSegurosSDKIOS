//
//  Document.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 17/01/25.
//


import Foundation

// MARK: - Documents


struct Document: Codable {
    let documentos: [Documents]
    let paid: Int
    let numeroPoliza: String
    
    enum CodingKeys: String, CodingKey {
        case documentos = "documents"
        case paid = "paid"
        case numeroPoliza = "numeroPoliza"
    }
    
    struct Documents: Codable {
        let typeDocument: String
        let fileName: String
        let path: String
        
        enum CodingKeys: String, CodingKey {
            case typeDocument
            case fileName
            case path
        }

    }

    static func initWithDictionary(_ dictionary: [String: Any]) -> Document? {
        do {
            let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
            let response = try JSONDecoder().decode(Document.self, from: data)
            return response
        } catch {
            print("Error al decodificar DocumentsResponse: \(error)")
            return nil
        }
    }
}
