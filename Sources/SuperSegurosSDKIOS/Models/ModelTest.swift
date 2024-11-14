//
//  File.swift
//  SuperSegurosSDKIOS
//
//  Created by Oscar Aguilar on 14/11/24.
//

import Foundation

struct PickersCatalog: Codable {
    
    var alcoholFrequencyCatalog: [String]?
    var alcoholMillilitersCatalog: [String]?
    var alcoholConsumingTimeCatalog: [String]?
    var alcoholTypeCatalog: [String]?
    var allergiesCatalog: [String]?
    var familyHistoryDiseaseCatalog: [String]?
    var familyHistoryKinshipCatalog: [String]?
    var familyHistoryStatusCatalog: [String]?
    var surgeriesCatalog: [String]?
    var dietCatalog: [String]?
    var gastrointestinalDiseasesCatalog: [String]?
    var educationCatalog: [String]?
    var sprainsCatalog: [String]?
    var fracturesCatalog: [String]?
    var genderCatalog: [String]?
    var bloodTypeCatalog: [String]?
    var diseaseCatalog: [String]?
    var anxietyCatalog: [String]?
    var depressionCatalog: [String]?
    var femaleHealthFlowCatalog: [String]?
    var femaleHealthPeriodCatalog: [String]?
    var femaleHealthSymptomsCatalog: [String]?
    var workHealthDisabilityCatalog: [String]?
    var workHealthProtectionCatalog: [String]?
    var workHealthExitCatalog: [String]?
    var sexualHealthCatalog: [String]?
    var contraceptivesCatalog: [String]?
    var basicServicesCatalog: [String]?
    var substancesCatalog: [String]?
    var tobaccoUseCatalog: [String]?
    var surgeriesTreatmentsCatalog: [String]?
    var ailmentsTreatmentsCatalog: [String]?
    var vaccinesAppliedCatalog: [String]?
    var housingCatalog: [String]?
    var zoonosisCatalog: [String]?
    var bedroomsCatalog: [String]?
    var peopleInHouseCatalog: [String]?
    var numberOfChildrenCatalog: [String]?
    var affirmationYesNoCatalog: [String]?
    var timesSufferedFromCovidCatalog: [String]?
    var vaccineDosesAppliedCatalog: [String]?
    var maritalStatusCatalog: [String]?
    var sleepHoursPerDayCatalog: [String]?
    var sleepProblemsCatalog: [String]?
    var oxygenSaturationCatalog: [String]?
    var dailyCigarettesCatalog: [String]?
    var exerciseTimeCatalog: [String]?
    var vaccineCovidCatalog: [String]?
    var apparatusSystemsCatalog: [String]?
    var apparatusRespiratoryCatalog: [String]?
    var apparatusDigestiveCatalog: [String]?
    var systemNeufrologyCatalog: [String]?
    var systemEndocrinoMetabolismCatalog: [String]?
    var systemHematopoieticCatalog: [String]?
    var nervousSystemCatalog: [String]?
    var skeletalSystemCatalog: [String]?
    var skinIntegumentsCatalog: [String]?
    var senseOrgansCatalog: [String]?
    var psychicSphereCatalog: [String]?
    var durationPeriodCatalog: [String]?
    var pregnantNumberCatalog: [String]?
    var deliveriesNumberCatalog: [String]?
    var caesareansNumberCatalog: [String]?
    var abortionsNumberCatalog: [String]?
    var weeksGestationCatalog: [String]?
    var emergencyCaseCatalog: [String]?
    
    private enum CodingKeys: String, CodingKey {
        
        case alcoholFrequencyCatalog = "PickerCatalogoAlcoholFrecuencia"
        case alcoholMillilitersCatalog = "PickerCatalogoAlcoholMilitros"
        case alcoholConsumingTimeCatalog = "PickerCatalogoAlcoholTiempoIngiriendo"
        case alcoholTypeCatalog = "PickerCatalogoAlcoholTipo"
        case allergiesCatalog = "PickerCatalogoAlergias"
        case familyHistoryDiseaseCatalog = "PickerCatalogoAntecedentesHeredofamiliaresPadecimiento"
        case familyHistoryKinshipCatalog = "PickerCatalogoAntecedentesHeredofamiliaresParentesco"
        case familyHistoryStatusCatalog = "PickerCatalogoAntecedentesHeredofamiliaresStatus"
        case surgeriesCatalog = "PickerCatalogoCirugias"
        case dietCatalog = "PickerCatalogoDieta"
        case gastrointestinalDiseasesCatalog = "PickerCatalogoEnfermedadesGastrointestinales"
        case educationCatalog = "PickerCatalogoEscolaridad"
        case sprainsCatalog = "PickerCatalogoEsguinces"
        case fracturesCatalog = "PickerCatalogoFracturas"
        case genderCatalog = "PickerCatalogoGenero"
        case bloodTypeCatalog = "PickerCatalogoGrupoSanguineo"
        case diseaseCatalog = "PickerCatalogoPadecimientos"
        case anxietyCatalog = "PickerCatalogoPsicologicoAnsiedad"
        case depressionCatalog = "PickerCatalogoPsicologicoDepresion"
        case femaleHealthFlowCatalog = "PickerCatalogoSaludFemeninaFlujo"
        case femaleHealthPeriodCatalog = "PickerCatalogoSaludFemeninaRegla"
        case femaleHealthSymptomsCatalog = "PickerCatalogoSaludFemeninaSintomas"
        case workHealthDisabilityCatalog = "PickerCatalogoSaludLaboralIncapacidad"
        case workHealthProtectionCatalog = "PickerCatalogoSaludLaboralProteccion"
        case workHealthExitCatalog = "PickerCatalogoSaludLaboralSalida"
        case sexualHealthCatalog = "PickerCatalogoSaludSexual"
        case contraceptivesCatalog = "PickerCatalogoSaludSexualAnticonceptivos"
        case basicServicesCatalog = "PickerCatalogoServiciosBasicos"
        case substancesCatalog = "PickerCatalogoSustancias"
        case tobaccoUseCatalog = "PickerCatalogoTabaco"
        case surgeriesTreatmentsCatalog = "PickerCatalogoTratamientosCirugias"
        case ailmentsTreatmentsCatalog = "PickerCatalogoTratamientosPadecimientos"
        case vaccinesAppliedCatalog = "PickerCatalogoVacunasAplicadas"
        case housingCatalog = "PickerCatalogoVivienda"
        case zoonosisCatalog = "PickerCatalogoZoonosis"
        case bedroomsCatalog = "PickerCatalogoDormitorios"
        case peopleInHouseCatalog = "PickerCatalogoPersonasEnCasa"
        case numberOfChildrenCatalog = "PickerCatalogoNumeroHijos"
        case affirmationYesNoCatalog = "PickerCatalogoAfirmacionSiNo"
        case timesSufferedFromCovidCatalog = "PickerCatalogoVecesPadecisteCovid"
        case vaccineDosesAppliedCatalog = "PickerCatalogoDosisAplicadasVacuna"
        case maritalStatusCatalog = "PickerCatalogoEstadoCivil"
        case sleepHoursPerDayCatalog = "PickerCatalogoHorasDuermesDia"
        case sleepProblemsCatalog = "PickerCatalogoProblemasSueno"
        case oxygenSaturationCatalog = "PickerCatalogoSaturacionOxigeno"
        case dailyCigarettesCatalog = "PickerCatalogoCigarrosDiarios"
        case exerciseTimeCatalog = "PickerCatalogoTiempoEjercicio"
        case vaccineCovidCatalog = "PickerCatalogoVacunasCovid"
        case apparatusSystemsCatalog = "PickerCatalogoAparatosSistemas"
        case apparatusRespiratoryCatalog = "PickerCatalogoAparatoRespiratorio"
        case apparatusDigestiveCatalog = "PickerCatalogoAparatoDigestivo"
        case systemNeufrologyCatalog = "PickerCatalogoSistemaNefrourologico"
        case systemEndocrinoMetabolismCatalog = "PickerCatalogoSistemaEndocrinoMetabolismo"
        case systemHematopoieticCatalog = "PickerCatalogoSistemaHematopoyetico"
        case nervousSystemCatalog = "PickerCatalogoSistemaNervioso"
        case skeletalSystemCatalog = "PickerCatalogoSistemaMusculoEsqueletico"
        case skinIntegumentsCatalog = "PickerCatalogoPielTegumentos"
        case senseOrgansCatalog = "PickerCatalogoOrganosSentidos"
        case psychicSphereCatalog = "PickerCatalogoEsferaPsiquica"
        case durationPeriodCatalog = "PickerCatalogoDuracionPeriodo"
        case pregnantNumberCatalog = "PickerCatalogoNumeroEmbarazos"
        case deliveriesNumberCatalog = "PickerCatalogoNumeroPartos"
        case caesareansNumberCatalog = "PickerCatalogoNumeroCesareas"
        case abortionsNumberCatalog = "PickerCatalogoNumeroAbortos"
        case weeksGestationCatalog = "PickerCatalogoSemanasGestacion"
        case emergencyCaseCatalog = "PickerCatalogoCasoEmergencia"
    }
    
    
    static func initWithDictionary(_ dictionary: [String: Any]) -> PickersCatalog? {
        
        var picker = PickersCatalog()
        
        let data = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        
        do {
            picker = try JSONDecoder().decode(PickersCatalog.self, from: data!)
        }
        catch (let error) {
          print(error)
        }

        return picker
        
    }
    
}
