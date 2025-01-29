//
//  PayQuotationData.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 17/01/25.
//

import Foundation

class PayQuotationData {
 
    @MainActor static let shared = PayQuotationData()
    
    var quote: Cotizacion.CoberturaPlan?
    var vehicle: TipoVehiculo?
    var quoteId: Int?
    var startingAt: String?
    var serial: String?
    var motorNumber: String?
    var carPlateNumber: String?
    var typeVehicleId: Int?
    var name: String?
    var paternalSurname: String?
    var maternalSurname: String?
    var gender: Int?
    var maritalStatus: Int?
    var email: String?
    var birthDate: String?
    var rfc: String?
    var entity: String?
    var municipality: String?
    var neighborhood: String?
    var zipCode: String?
    var street: String?
    var extNumber: String?
    var holderName: String?
    var cardNumber: String?
    var year: String?
    var month: String?
    var userId: Int?
    var coverage: String?
    var policyPath:String?
    var receiptPath:String?
    var rcusaPath:String?
    var policyNumber:String?
    var brand:String?
    var carYear:String?
    var model:String?
    var version:String?
    var insuranceImg:String?
    private init() { }
}
