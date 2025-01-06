//
//  Cotizacion.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 09/12/24.
//

import Foundation

// MARK: - Top-level
struct Cotizacion: Codable {
    let cotizacion: String?
    let coberturas: [CoberturaPlan]?
    
    
    // MARK: - CoberturaPlan
    struct CoberturaPlan: Codable {
        let formaPago: String?
        let coberturasAplicables: [Cobertura]?
        let numeroCotizacion: String?
        let costoTotal: PaymentDetail?
        let primerRecibo: PaymentDetail?
        let subSecuentes: PaymentDetail?
    }
    
    // MARK: - Cobertura
    struct Cobertura: Codable {
        let idCobertura: String?
        let ordenCobertura: String?
        let codigoCobertura: String?
        let nomenclaturaCobertura: String?
        let descripcionCobertura: String?
        let montoCobertura: DoubleOrString?
        let montoFormateadoCobertura: String?
        let sumaAsegurada: String?
        let nombreTipoCobertura: String?
        let descripcionLarga: String?
        let idTipoCobertura: String?
        
        
    }
    
    // MARK: - PaymentDetail
    struct PaymentDetail: Codable {
        let concepto: String?
        let monto: Double?
        let montoRedondeado: String?
        let montoFormateado: String?
    }
    
    // MARK: - DoubleOrString
    
    enum DoubleOrString: Codable {
        case double(Double)
        case string(String)
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let doubleVal = try? container.decode(Double.self) {
                self = .double(doubleVal)
            } else if let stringVal = try? container.decode(String.self) {
                self = .string(stringVal)
            } else {
                
                self = .string("No Aplica")
            }
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .double(let d):
                try container.encode(d)
            case .string(let s):
                try container.encode(s)
            }
        }
    }
    
    
    
    static func initWithArray(_ array: [[String: Any]]) -> [Cotizacion]? {
        do {
            let data = try JSONSerialization.data(withJSONObject: array, options: [])
            let bq = try JSONDecoder().decode([Cotizacion].self, from: data)
            return bq
        } catch {
            print("Error al decodificar: \(error)")
            return nil
        }
    }
}
