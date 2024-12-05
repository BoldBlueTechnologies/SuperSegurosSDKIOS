//
//  Modelo.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 04/12/24.
//

import Foundation

struct Modelo: Codable {
    var modelo: Int
  
    enum CodingKeys: String, CodingKey {
        case modelo = "Modelo"
     
    }

    static func initWithArray(_ array: [[String: Any]]) -> [Modelo]? {
        do {
            let data = try JSONSerialization.data(withJSONObject: array, options: [])
            let modelo = try JSONDecoder().decode([Modelo].self, from: data)
            return modelo
        } catch {
            print("Error al decodificar: \(error)")
            return nil
        }
    }
}
