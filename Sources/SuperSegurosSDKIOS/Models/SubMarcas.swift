//
//  SubMarcas.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 05/12/24.
//

import Foundation

struct SubMarcas: Codable {
    var id: Int
    var subMarca: String
 
    enum CodingKeys: String, CodingKey {
        case id = "IdProductorSubGrupo"
        case subMarca = "ProductorSubGrupo"
  
    }

    static func initWithArray(_ array: [[String: Any]]) -> [SubMarcas]? {
        do {
            let data = try JSONSerialization.data(withJSONObject: array, options: [])
            let marcas = try JSONDecoder().decode([SubMarcas].self, from: data)
            return marcas
        } catch {
            print("Error al decodificar: \(error)")
            return nil
        }
    }
}
