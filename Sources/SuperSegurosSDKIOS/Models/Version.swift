//
//  Version.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 05/12/24.
//

import Foundation

struct Version: Codable {
    var id: String
    var descripcion: String

    enum CodingKeys: String, CodingKey {
        case id = "ClaveInterna"
        case descripcion = "DescripcionAuto"
    }

    static func initWithArray(_ array: [[String: Any]]) -> [Version]? {
        do {
            let data = try JSONSerialization.data(withJSONObject: array, options: [])
            let version = try JSONDecoder().decode([Version].self, from: data)
            return version
        } catch {
            print("Error al decodificar: \(error)")
            return nil
        }
    }
}
