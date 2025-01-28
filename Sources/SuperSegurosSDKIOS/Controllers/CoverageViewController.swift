//
//  Untitled.swift
//  UseLibrary
//
//  Created by Christian Martinez on 20/11/24.
//

import UIKit

class CoverageViewController: stylesViewController {
    
    var carQuoteId:Int?
    var vehicleType:TipoVehiculo?
    var modelSelected:Modelo?
    var brandSelected: Marcas?
    var subBrandSelected: SubMarcas?
    var versionSelected: Version?
    var insurance:BasicQuotation?
    var postalCode:String?
    let scrollView = UIScrollView()
    let contentView = UIView()
    var radioButtons: [UIButton] = []
    var segmentedControl: UISegmentedControl!
    var coverageLabel: UILabel!
    var coveragesTitleLabel: UILabel!
    var coveragesSubtitleLabel: UILabel!
    var coverageCardsContainer: UIView!
    var coverageCards: [UIView] = []
    var coveragesData: [[String: Any]] = []
    var logoImageView: UIImageView!
    var blueLabels: [UILabel] = []
    var cotizaciones: [Cotizacion] = []
    var carDetailsLabel: UILabel?
    var carDetailsView: UIView?
    var labelsContainer: UIView?
    var coversUpToLabel: UILabel?
    var actionButton: UIButton?
    var bottomLabel: UILabel?
    var selectedPaymentMethod = "Anual"
    var planSelected : Cotizacion.CoberturaPlan?
    var coverageSelected = "Prestigio"
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.moduleColor(named: "paleGraySuper")
        setupScrollView()
        setupContent()
        setupNavigationBar()
        getData(vehicleType: self.vehicleType?.tipoVehiculoBase ?? 0, model: self.modelSelected?.modelo ?? 0, brand: self.brandSelected?.id ?? 0, subBrand: self.subBrandSelected?.id ?? 0, internalKey: self.versionSelected?.id ?? "", insurance: self.insurance?.aseguradora ?? "")
        
  //      getData(vehicleType: 1, model: 2020, brand: 12, subBrand: 1236, internalKey: "20222", insurance: "GS")
    }
    
    
    func setupNavigationBar() {
        
        
        let backButton = UIBarButtonItem(title: "Atrás", style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = UIColor.moduleColor(named: "rosaSuper")
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
    }
    
    func getData(vehicleType:Int, model:Int, brand:Int, subBrand:Int, internalKey:String, insurance:String) {
        
        self.showProgressHUD(title: "Obteniendo coberturas")
     
        NetworkDataRequest.getGeneralQuotation(vehicleType: vehicleType, model: model, brand: brand, subBrand: subBrand, internalKey: internalKey, insurance: insurance, zipCode: self.postalCode ?? "72000") { success, message, pickersData in
            
            self.dismissProgressHUD()
            if success {
                if let pickersData = pickersData {
                    self.cotizaciones = pickersData
                    
                    DispatchQueue.main.async {
                        self.updateUI()
                    }
                }
            }
        }
        
    }
    
    func updateUI() {
        let paymentMethodLabel = setupPaymentMethodLabel()
        let lastCard = addPaymentCards(below: paymentMethodLabel)
        let carDetailsView = addCarDetailsLabel(below: lastCard)
        addCoverageSection(below: carDetailsView)
        //   addCoverageCards()
        
        if let firstRadio = radioButtons.first {
            radioButtonTapped(firstRadio)
        }
        
    }
    
    func mapFormaPagoToTexts(formaPago: String) -> (title: String, subtitleLine1: String?, subtitleLine2: String?) {
        switch formaPago {
        case "Anual":
            return ("Anualmente", nil, nil)
        case "Semestral":
            return ("Semestralmente", "Primer Recibo", "Pago subsecuente")
        case "Trimestral":
            return ("Trimestralmente", "Primer Recibo", "3 pagos subsecuentes")
        case "Mensual":
            return ("Mensualmente", "Primer Recibo", "11 pagos subsecuentes")
        default:
            return ("", nil, nil)
        }
    }
    
    
    func getCotizacionForSelectedOption() -> Cotizacion? {
        let selectedIndex = segmentedControl.selectedSegmentIndex
        
        guard selectedIndex >= 0, selectedIndex < segmentedControl.numberOfSegments else {
            return nil
        }
        
        let selectedOption = segmentedControl.titleForSegment(at: selectedIndex)
        self.coverageSelected = selectedOption ?? ""
        return cotizaciones.first { $0.cotizacion == selectedOption }
    }
    
    
    func setupContent() {
        setupLogoImage()
        setupCoverageLabel()
        setupSegmentedControl()
        
    }
    
    func setupLogoImage() {
        
        let logoImageView = UIImageView(image:  UIImage.moduleImage(named: "superLogoColor"))
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.contentMode = .scaleAspectFit
        
        contentView.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -30),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 150),
            logoImageView.heightAnchor.constraint(equalToConstant: 110)
        ])
        self.logoImageView = logoImageView
    }
    
    func setupCoverageLabel() {
        coverageLabel = UILabel()
        coverageLabel.translatesAutoresizingMaskIntoConstraints = false
        coverageLabel.text = "Selecciona una cobertura"
        coverageLabel.textColor = UIColor.moduleColor(named: "rosaSuper")
        coverageLabel.font = UIFont.poppinsSemiBold(size: 15)
        coverageLabel.textAlignment = .center
        contentView.addSubview(coverageLabel)
        NSLayoutConstraint.activate([
            coverageLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 0),
            coverageLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    func setupSegmentedControl() {
        let options = ["Prestigio","Amplia", "Limitada", "Básica"]
        segmentedControl = UISegmentedControl(items: options)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: coverageLabel.bottomAnchor, constant: 20),
            segmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            segmentedControl.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        
        segmentedControl.backgroundColor = .white
        
        segmentedControl.selectedSegmentTintColor = UIColor.moduleColor(named: "rosaSuper")
        
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font:  UIFont.poppinsRegular(size: 14),
            .foregroundColor: UIColor.black
        ]
        segmentedControl.setTitleTextAttributes(normalAttributes, for: .normal)
        
        
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .font:  UIFont.poppinsSemiBold(size: 14),
            .foregroundColor: UIColor.white
        ]
        segmentedControl.setTitleTextAttributes(selectedAttributes, for: .selected)
        
        segmentedControl.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    }
    
    
    
    func setupPaymentMethodLabel() -> UILabel {
        let paymentMethodLabel = UILabel()
        paymentMethodLabel.translatesAutoresizingMaskIntoConstraints = false
        paymentMethodLabel.text = "Forma de Pago"
        paymentMethodLabel.font = UIFont.poppinsSemiBold(size: 15)
        paymentMethodLabel.textAlignment = .center
        contentView.addSubview(paymentMethodLabel)
        NSLayoutConstraint.activate([
            paymentMethodLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            paymentMethodLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        return paymentMethodLabel
    }
    
    func addPaymentCards(below previousView: UIView) -> UIView {
        guard let cotizacion = getCotizacionForSelectedOption(), let coberturaPlanes = cotizacion.coberturas else {
            // Si no hay cotización o coberturas, regresar el previousView
            return previousView
        }
        
        
        let order = ["Anual", "Semestral", "Trimestral", "Mensual"]
        
        var coberturasDict = [String: Cotizacion.CoberturaPlan]()
        for plan in coberturaPlanes {
            if let fp = plan.formaPago {
                coberturasDict[fp] = plan
            }
        }
        
        var previousView = previousView
        var lastCard: UIView = previousView
        
        for (index, formaPago) in order.enumerated() {
            guard let plan = coberturasDict[formaPago] else { continue }
            
            let (titleText, subtitle1, subtitle2) = mapFormaPagoToTexts(formaPago: formaPago)
            
            let card = PaymentCardView(title: titleText, subtitle: subtitle1 ?? "", tag: index)
            card.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(card)
            
            
            if formaPago == "Anual" {
                let anualTotal = plan.costoTotal?.monto ?? 0.0
                let planMensual = coberturasDict["Mensual"]
                let totalMensual = planMensual?.costoTotal?.monto ?? 0.0
                let totalAhorro = totalMensual - anualTotal
                let cRedondeado = (totalAhorro * 100).rounded() / 100
                card.priceLabel1.text = plan.costoTotal?.montoFormateado ?? "$0.00"
                card.priceLabel2.text = "$ \(String(cRedondeado)) más barato"
                card.priceLabel2.textColor = UIColor.moduleColor(named: "green")
                card.priceLabel2.font = UIFont.poppinsSemiBold(size: 13)
            } else {
                
                card.priceLabel1.text = plan.costoTotal?.montoFormateado ?? "$0.00"
                card.priceLabel2.text = plan.primerRecibo?.montoFormateado ?? "$0.00"
                card.priceLabel3.text = plan.subSecuentes?.montoFormateado ?? "$0.00"
                card.subtitleLabel.numberOfLines = (subtitle2 != nil) ? 2 : 1
                if let s2 = subtitle2 {
                    card.subtitleLabel.text = (subtitle1 ?? "") + "\n" + s2
                }
            }
            
            NSLayoutConstraint.activate([
                card.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
                card.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
                card.heightAnchor.constraint(equalToConstant: 82),
                card.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 20)
            ])
            
            previousView = card
            lastCard = card
            radioButtons.append(card.radioButton)
            
            
        }
        
        return lastCard
    }
    
    
    func addCarDetailsLabel(below previousView: UIView) -> UIView {
        carDetailsLabel?.removeFromSuperview()
        carDetailsView?.removeFromSuperview()
        
        let carDetailsLabel = UILabel()
        self.carDetailsLabel = carDetailsLabel
        carDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
        carDetailsLabel.text = "Detalles del auto asegurado"
        carDetailsLabel.font = UIFont.poppinsSemiBold(size: 15)
        carDetailsLabel.textAlignment = .center
        contentView.addSubview(carDetailsLabel)
        NSLayoutConstraint.activate([
            carDetailsLabel.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 20),
            carDetailsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        let carDetailsView = addCarDetailsView(below: carDetailsLabel)
        self.carDetailsView = carDetailsView
        return carDetailsView
    }
    
    func addCarDetailsView(below previousView: UIView) -> UIView {
        let carDetailsView = UIView()
        carDetailsView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(carDetailsView)
        NSLayoutConstraint.activate([
            carDetailsView.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 20),
            carDetailsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            carDetailsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            carDetailsView.heightAnchor.constraint(equalToConstant: 276)
        ])
        carDetailsView.layer.cornerRadius = 10
        carDetailsView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        carDetailsView.clipsToBounds = true
        setupCarDetailsContent(in: carDetailsView)
        return carDetailsView
    }
    
    func setupCarDetailsContent(in containerView: UIView) {
        let whiteView = UIView()
        whiteView.translatesAutoresizingMaskIntoConstraints = false
        whiteView.backgroundColor = .white
        containerView.addSubview(whiteView)
        let blueView = UIView()
        blueView.translatesAutoresizingMaskIntoConstraints = false
        blueView.backgroundColor = UIColor.moduleColor(named: "mainSuper")
        containerView.addSubview(blueView)
        NSLayoutConstraint.activate([
            whiteView.topAnchor.constraint(equalTo: containerView.topAnchor),
            whiteView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            whiteView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            whiteView.heightAnchor.constraint(equalToConstant: 101),
            blueView.topAnchor.constraint(equalTo: whiteView.bottomAnchor),
            blueView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            blueView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            blueView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        blueView.layer.cornerRadius = 20
        blueView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        blueView.clipsToBounds = true
        addContentToWhiteView(whiteView)
        addContentToBlueView(blueView)
    }
    
    func addContentToWhiteView(_ whiteView: UIView) {
        let rowContainer = UIView()
        rowContainer.translatesAutoresizingMaskIntoConstraints = false
        whiteView.addSubview(rowContainer)
        NSLayoutConstraint.activate([
            rowContainer.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 10),
            rowContainer.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor),
            rowContainer.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor)
        ])
        
        let modelo = String(self.modelSelected?.modelo ?? 0)
        let labels = [
            ("Marca", self.brandSelected?.marca),
            ("Año", modelo),
            ("Modelo", self.subBrandSelected?.subMarca),
            ("", "")
        ]
        var previousLabel: UIView?
        let labelWidthMultiplier = 0.25
        for (index, labelInfo) in labels.enumerated() {
            let container = UIView()
            container.translatesAutoresizingMaskIntoConstraints = false
            rowContainer.addSubview(container)
            NSLayoutConstraint.activate([
                container.topAnchor.constraint(equalTo: rowContainer.topAnchor),
                container.bottomAnchor.constraint(equalTo: rowContainer.bottomAnchor),
                container.widthAnchor.constraint(equalTo: rowContainer.widthAnchor, multiplier: CGFloat(labelWidthMultiplier))
            ])
            if let previous = previousLabel {
                container.leadingAnchor.constraint(equalTo: previous.trailingAnchor).isActive = true
            } else {
                container.leadingAnchor.constraint(equalTo: rowContainer.leadingAnchor).isActive = true
            }
            let titleLabel = UILabel()
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.text = labelInfo.0
            titleLabel.font = UIFont.poppinsSemiBold(size: 13)
            titleLabel.textAlignment = .center
            container.addSubview(titleLabel)
            let valueLabel = UILabel()
            valueLabel.translatesAutoresizingMaskIntoConstraints = false
            valueLabel.text = labelInfo.1
            valueLabel.font = UIFont.poppinsRegular(size: 13)
            valueLabel.textAlignment = .center
            container.addSubview(valueLabel)
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: container.topAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
                valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
                valueLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                valueLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
                valueLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor)
            ])
            if index == 3 {
                titleLabel.text = ""
                valueLabel.text = ""
                
                let imageView = UIImageView()
                
                if let insurance = self.insurance {
                    PayQuotationData.shared.insuranceImg = insurance.aseguradora
                   
                    imageView.image = UIImage.moduleImage(named:insurance.aseguradora)
                }
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.contentMode = .scaleAspectFit
                container.addSubview(imageView)
                NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: container.topAnchor),
                    imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                    imageView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
                    imageView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
                ])
            }
            previousLabel = container
        }
        rowContainer.bottomAnchor.constraint(equalTo: previousLabel!.bottomAnchor).isActive = true
        let versionTitleLabel = UILabel()
        versionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        versionTitleLabel.text = "Versión"
        versionTitleLabel.font = UIFont.poppinsSemiBold(size: 13)
        versionTitleLabel.textAlignment = .center
        whiteView.addSubview(versionTitleLabel)
        let versionValueLabel = UILabel()
        versionValueLabel.translatesAutoresizingMaskIntoConstraints = false
        versionValueLabel.text = self.versionSelected?.descripcion
        versionValueLabel.font = UIFont.poppinsRegular(size: 13)
        versionValueLabel.textAlignment = .center
        versionValueLabel.numberOfLines = 1
        versionValueLabel.adjustsFontSizeToFitWidth = true
        versionValueLabel.minimumScaleFactor = 0.5
        whiteView.addSubview(versionValueLabel)
        NSLayoutConstraint.activate([
            versionTitleLabel.topAnchor.constraint(equalTo: rowContainer.bottomAnchor, constant: 10),
            versionTitleLabel.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 10),
            versionTitleLabel.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -10),
            versionValueLabel.topAnchor.constraint(equalTo: versionTitleLabel.bottomAnchor, constant: 4),
            versionValueLabel.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 10),
            versionValueLabel.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -10),
            versionValueLabel.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: -10)
        ])
    }
    
    func addContentToBlueView(_ blueView: UIView) {
        blueLabels.forEach { $0.removeFromSuperview() }
        blueLabels.removeAll()
        
        let labelsInfo: [(text: String, font: UIFont, color: UIColor)] = [
            ("Tu Súper seguro de auto por:", UIFont.poppinsRegular(size: 15), UIColor.white),
            ("$0.00", UIFont.poppinsSemiBold(size: 27), UIColor.moduleColor(named: "rosaSuper") ?? UIColor.white),
            ("Anualmente", UIFont.poppinsSemiBold(size: 22), UIColor.white),
            ("*Seguro respaldado y operado por: General de Seguros S.A. de C.V.", UIFont.poppinsRegular(size: 13), UIColor.white)
        ]
        
        var previousLabel: UILabel?
        for info in labelsInfo {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = info.text
            label.font = info.font
            label.textAlignment = .center
            label.textColor = info.color
            label.numberOfLines = 0
            blueView.addSubview(label)
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: blueView.leadingAnchor, constant: 10),
                label.trailingAnchor.constraint(equalTo: blueView.trailingAnchor, constant: -10)
            ])
            if let previous = previousLabel {
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 8).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: blueView.topAnchor, constant: 10).isActive = true
            }
            previousLabel = label
            blueLabels.append(label)
        }
        previousLabel?.bottomAnchor.constraint(equalTo: blueView.bottomAnchor, constant: -10).isActive = true
    }
    
    
    func addCoverageSection(below previousView: UIView) {
        labelsContainer?.removeFromSuperview()
        coverageCardsContainer?.removeFromSuperview()
        actionButton?.removeFromSuperview()
        bottomLabel?.removeFromSuperview()
        
        let labelsContainer = UIView()
        self.labelsContainer = labelsContainer
        labelsContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelsContainer)
        NSLayoutConstraint.activate([
            labelsContainer.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 20),
            labelsContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            labelsContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            labelsContainer.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        coveragesTitleLabel = UILabel()
        coveragesTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        coveragesTitleLabel.textAlignment = .left
        coveragesTitleLabel.font = UIFont.poppinsSemiBold(size: 15)
        coveragesTitleLabel.textColor = UIColor.moduleColor(named: "rosaSuper")
        labelsContainer.addSubview(coveragesTitleLabel)
        
        let coversUpToLabel = UILabel()
        self.coversUpToLabel = coversUpToLabel
        coversUpToLabel.translatesAutoresizingMaskIntoConstraints = false
        coversUpToLabel.textAlignment = .right
        coversUpToLabel.font = UIFont.poppinsRegular(size: 15)
        coversUpToLabel.text = "Cubre hasta"
        labelsContainer.addSubview(coversUpToLabel)
        
        NSLayoutConstraint.activate([
            coveragesTitleLabel.topAnchor.constraint(equalTo: labelsContainer.topAnchor),
            coveragesTitleLabel.leadingAnchor.constraint(equalTo: labelsContainer.leadingAnchor),
            coveragesTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: coversUpToLabel.leadingAnchor),
            coversUpToLabel.topAnchor.constraint(equalTo: labelsContainer.topAnchor),
            coversUpToLabel.trailingAnchor.constraint(equalTo: labelsContainer.trailingAnchor)
        ])
        
        updateCoveragesTitle()
        
        let coverageCardsStackView = UIStackView()
        self.coverageCardsContainer = coverageCardsStackView
        coverageCardsStackView.translatesAutoresizingMaskIntoConstraints = false
        coverageCardsStackView.axis = .vertical
        coverageCardsStackView.spacing = 10
        coverageCardsStackView.alignment = .fill
        coverageCardsStackView.distribution = .fill
        contentView.addSubview(coverageCardsStackView)
        
        NSLayoutConstraint.activate([
            coverageCardsStackView.topAnchor.constraint(equalTo: labelsContainer.bottomAnchor, constant: 10),
            coverageCardsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            coverageCardsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
        
        
        addCoverageCards()
        
        addActionButtonAndLabel(below: coverageCardsStackView)
    }
    
    
    
    
    func updateBlueView(formaPago: String) {
        guard let cotizacion = getCotizacionForSelectedOption(),
              let coberturaPlanes = cotizacion.coberturas else { return }
        
        _ = ["Anual", "Semestral", "Trimestral", "Mensual"]
        var coberturasDict = [String: Cotizacion.CoberturaPlan]()
        for plan in coberturaPlanes {
            if let fp = plan.formaPago {
                coberturasDict[fp] = plan
            }
        }
        
        guard let plan = coberturasDict[formaPago] else {
            return
        }
        self.planSelected = plan
        
        let (titleText, _, _) = mapFormaPagoToTexts(formaPago: formaPago)
        blueLabels[1].text = plan.costoTotal?.montoFormateado ?? "$0.00"
        blueLabels[2].text = titleText
        
    }
    
    
    
    func addActionButtonAndLabel(below previousView: UIView) {
        actionButton?.removeFromSuperview()
        bottomLabel?.removeFromSuperview()
        
        let actionButton = UIButton(type: .system)
        self.actionButton = actionButton
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.setTitle("Sí, lo quiero", for: .normal)
        actionButton.applyStyle(.primary)
        actionButton.addTarget(self, action: #selector(continueAction), for: .touchUpInside)
        contentView.addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            actionButton.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 20),
            actionButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            actionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            actionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
        let bottomLabel = UILabel()
        self.bottomLabel = bottomLabel
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.text = "*Seguro respaldado y operado por: General de Seguros S.A. de C.V."
        bottomLabel.font = UIFont.poppinsRegular(size: 13)
        bottomLabel.textAlignment = .center
        bottomLabel.numberOfLines = 2
        contentView.addSubview(bottomLabel)
        
        NSLayoutConstraint.activate([
            bottomLabel.topAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: 8),
            bottomLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            bottomLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            bottomLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    
    func updateCoveragesTitle() {
        let selectedIndex = segmentedControl.selectedSegmentIndex
        _ = segmentedControl.titleForSegment(at: selectedIndex)
        //  if selectedOption == "Plus" {
        //      coveragesTitleLabel.text = "Editar tus coberturas"
        //  } else {
        coveragesTitleLabel.text = "Coberturas"
        //  }
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        updateCoveragesTitle()
        refreshPaymentCards()
        refreshCoverageCards()
        
        if let firstRadio = radioButtons.first {
            radioButtonTapped(firstRadio)
        }
    }
    
    func refreshCoverageCards() {
        addCoverageCards()
    }
    
    
    func refreshPaymentCards() {
        guard let cotizacion = getCotizacionForSelectedOption(),
              let coberturaPlanes = cotizacion.coberturas else { return }
        
        let order = ["Anual", "Semestral", "Trimestral", "Mensual"]
        var coberturasDict = [String: Cotizacion.CoberturaPlan]()
        for plan in coberturaPlanes {
            if let fp = plan.formaPago {
                coberturasDict[fp] = plan
            }
        }
        
        let paymentCards = contentView.subviews.compactMap { $0 as? PaymentCardView }
        for (index, card) in paymentCards.enumerated() {
            let formaPago = order[index]
            if let plan = coberturasDict[formaPago] {
                let (titleText, subtitle1, subtitle2) = mapFormaPagoToTexts(formaPago: formaPago)
                card.titleLabel.text = titleText
                if formaPago == "Anual" {
                    card.priceLabel1.text = plan.costoTotal?.montoFormateado ?? "$0.00"
                    card.priceLabel2.text = ""
                    card.priceLabel3.isHidden = true
                    card.subtitleLabel.text = subtitle1
                    let anualTotal = plan.costoTotal?.monto ?? 0.0
                    let planMensual = coberturasDict["Mensual"]
                    let totalMensual = planMensual?.costoTotal?.monto ?? 0.0
                    let totalAhorro = totalMensual - anualTotal
                    let cRedondeado = (totalAhorro * 100).rounded() / 100
                    card.priceLabel1.text = plan.costoTotal?.montoFormateado ?? "$0.00"
                    card.priceLabel2.text = "$ \(String(cRedondeado)) más barato"
                    card.priceLabel2.textColor = UIColor.moduleColor(named: "green")
                    card.priceLabel2.font = UIFont.poppinsSemiBold(size: 14)
                } else {
                    card.priceLabel1.text = plan.costoTotal?.montoFormateado ?? "$0.00"
                    card.priceLabel2.text = plan.primerRecibo?.montoFormateado ?? "$0.00"
                    card.priceLabel3.text = plan.subSecuentes?.montoFormateado ?? "$0.00"
                    card.priceLabel3.isHidden = false
                    if let s2 = subtitle2 {
                        card.subtitleLabel.numberOfLines = 2
                        card.subtitleLabel.text = (subtitle1 ?? "") + "\n" + s2
                    } else {
                        card.subtitleLabel.text = subtitle1 ?? ""
                    }
                }
            } else {
                card.titleLabel.text = formaPago
                card.subtitleLabel.text = "N/A"
                card.priceLabel1.text = "$0.00"
                card.priceLabel2.text = ""
                card.priceLabel3.isHidden = true
            }
        }
    }
    
    
    
    
    func addCoverageCards() {
        guard let coverageStackView = coverageCardsContainer as? UIStackView else { return }
        for view in coverageStackView.arrangedSubviews {
            coverageStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        coverageCards.removeAll()
        coveragesData = getCoveragesDataForSelectedSegment()
        
        for (index, coverage) in coveragesData.enumerated() {
            let card = createCoverageCard(coverage: coverage, index: index)
            coverageStackView.addArrangedSubview(card)
            coverageCards.append(card)
        }
        
        print("Tarjetas de cobertura actualizadas: \(coverageCards)")
    }
    
    
    
    
    
    func getCoveragesDataForSelectedSegment() -> [[String: Any]] {
        guard let cotizacion = getCotizacionForSelectedOption(),
              let coberturaPlanes = cotizacion.coberturas else {
            return []
        }
        var coberturasDict = [String: Cotizacion.CoberturaPlan]()
        for plan in coberturaPlanes {
            if let fp = plan.formaPago {
                coberturasDict[fp] = plan
            }
        }
        
        guard let planSeleccionado = coberturasDict[selectedPaymentMethod] else {
            return []
        }
        
        guard let coberturasAplicables = cotizacion.coberturasAplicables else {
            return []
        }
        
        var result: [[String: Any]] = []
        
        for cobertura in coberturasAplicables {
            
            let amount = cobertura.montoFormateadoCobertura ?? "$0.00"
            
            if amount != "No Aplica" {
                let title = cobertura.descripcionCobertura ?? "Cobertura"
                
                let details = cobertura.descripcionLarga ?? "Sin detalles"
                
                let dict: [String: Any] = [
                    "title": title,
                    "amount": amount,
                    "details": details
                ]
                result.append(dict)
            }
        }
        
        return result
    }
    
    func createCoverageCard(coverage: [String: Any], index: Int) -> UIView {
        let cardView = CoverageCardView()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.setupCard(coverage: coverage, index: index)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(coverageCardTapped(_:)))
        cardView.addGestureRecognizer(tapGesture)
        return cardView
    }
    
    @objc func radioButtonTapped(_ sender: UIButton) {
        for button in radioButtons {
            button.isSelected = false
            button.backgroundColor = UIColor.white
            button.layer.borderColor = UIColor.black.cgColor
        }
        sender.isSelected = true
        sender.backgroundColor = UIColor.moduleColor(named: "rosaSuper")
        sender.layer.borderColor = UIColor.black.cgColor
        let selected = sender.tag
        print("Selected radio button: \(selected)")
        
        let order = ["Anual", "Semestral", "Trimestral", "Mensual"]
        let formaPagoSeleccionada = order[selected]
        
        
        selectedPaymentMethod = formaPagoSeleccionada
        updateBlueView(formaPago: formaPagoSeleccionada)
        refreshCoverageCards()
    }
    
    
    
    @objc func coverageCardTapped(_ sender: UITapGestureRecognizer) {
        guard let cardView = sender.view as? CoverageCardView else { return }
        if let detailsLabel = cardView.detailsLabel,
           let arrowImageView = cardView.arrowImageView,
           let collapsedConstraint = cardView.collapsedHeightConstraint,
           let expandedConstraint = cardView.expandedHeightConstraint {
            let isExpanded = !detailsLabel.isHidden
            if isExpanded {
                detailsLabel.isHidden = true
                arrowImageView.image = UIImage(systemName: "chevron.down")
                expandedConstraint.isActive = false
                collapsedConstraint.isActive = true
                if let additionalViews = cardView.additionalViews {
                    for view in additionalViews {
                        view.isHidden = true
                    }
                }
            } else {
                detailsLabel.isHidden = false
                arrowImageView.image = UIImage(systemName: "chevron.up")
                collapsedConstraint.isActive = false
                expandedConstraint.isActive = true
                if let additionalViews = cardView.additionalViews {
                    for view in additionalViews {
                        view.isHidden = false
                    }
                }
            }
            UIView.animate(withDuration: 0.3) {
                self.contentView.layoutIfNeeded()
            }
        }
    }
    
    @objc func optionButtonTapped(_ sender: UIButton) {
        if let cardView = sender.parentView(of: CoverageCardView.self) {
            if let optionButtons = cardView.optionButtons {
                for button in optionButtons {
                    button.isSelected = false
                    button.backgroundColor = .white
                    button.setTitleColor(UIColor.moduleColor(named: "rosaSuper"), for: .normal)
                    button.layer.borderColor = UIColor.lightGray.cgColor
                }
            }
            sender.isSelected = true
            sender.backgroundColor = UIColor.moduleColor(named: "rosaSuper")
            sender.setTitleColor(.white, for: .normal)
            sender.layer.borderColor = UIColor.moduleColor(named: "rosaSuper")?.cgColor
            let selectedOption = sender.title(for: .normal)
            print("Opción seleccionada: \(selectedOption ?? "") en la tarjeta \(cardView.tag)")
        }
    }
    
    @objc func pickerButtonTapped(_ sender: UIButton) {
        if let cardView = sender.parentView(of: CoverageCardView.self) {
            if let pickerOptions = cardView.pickerOptions {
                let alertController = UIAlertController(title: "Selecciona una opción", message: nil, preferredStyle: .actionSheet)
                for option in pickerOptions {
                    alertController.addAction(UIAlertAction(title: option, style: .default, handler: { _ in
                        sender.setTitle(option, for: .normal)
                        print("Opción seleccionada: \(option) en la tarjeta \(cardView.tag)")
                        self.coverageSelected = option
                    }))
                }
                alertController.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
                if let popoverController = alertController.popoverPresentationController {
                    popoverController.sourceView = sender
                    popoverController.sourceRect = sender.bounds
                }
                DispatchQueue.main.async {
                    if let viewController = sender.parentViewController() {
                        viewController.present(alertController, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    @objc func quitarButtonTapped(_ sender: UIButton) {
        if let cardView = sender.parentView(of: CoverageCardView.self) {
            print("Botón 'Quitar' presionado en la tarjeta \(cardView.tag)")
            if let optionButtons = cardView.optionButtons {
                for button in optionButtons {
                    button.isSelected = false
                    button.backgroundColor = .white
                    button.setTitleColor(.purple, for: .normal)
                    button.layer.borderColor = UIColor.lightGray.cgColor
                }
            }
            if let pickerButton = cardView.pickerButton {
                pickerButton.setTitle("Selecciona una opción", for: .normal)
            }
            if let detailsLabel = cardView.detailsLabel,
               let arrowImageView = cardView.arrowImageView,
               let collapsedConstraint = cardView.collapsedHeightConstraint,
               let expandedConstraint = cardView.expandedHeightConstraint {
                detailsLabel.isHidden = true
                arrowImageView.image = UIImage(systemName: "chevron.down")
                expandedConstraint.isActive = false
                collapsedConstraint.isActive = true
                UIView.animate(withDuration: 0.3) {
                    self.contentView.layoutIfNeeded()
                }
            }
        }
    }
    
    @objc func addButtonTapped(_ sender: UIButton) {
        if let cardView = sender.parentView(of: CoverageCardView.self) {
            print("Botón 'Añadir' presionado en la tarjeta \(cardView.tag)")
        }
    }
    
    
    func saveCoverages(carQuoteId: Int,  insurer: String, plan: String, coverage: String) {
        NetworkDataRequest.saveCoverages(
            carQuoteId: carQuoteId,
            insurer: insurer,
            plan: plan,
            coverage: coverage
        ) { success, message, pickersData in
            
            
            if success, let data = pickersData {
                
                let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle.module)
                let switchViewController = storyboard.instantiateViewController(withIdentifier: "preForm") as! preFormViewController
                switchViewController.insurance = self.insurance
                switchViewController.brandSelected = self.brandSelected
                switchViewController.vehicleType = self.vehicleType
                switchViewController.modelSelected = self.modelSelected
                switchViewController.subBrandSelected = self.subBrandSelected
                switchViewController.versionSelected = self.versionSelected
                switchViewController.postalCode = self.postalCode
                switchViewController.planSelected = self.planSelected
                switchViewController.coverageId = data
                switchViewController.modalPresentationStyle = .fullScreen
                switchViewController.isModalInPresentation = true
                self.present(UINavigationController(rootViewController: switchViewController), animated: true, completion: nil)
                
            }
        }
    }
    
    @objc private func continueAction() {
        
        PayQuotationData.shared.coverage = self.coverageSelected
        PayQuotationData.shared.quote = self.planSelected
        self.saveCoverages(carQuoteId: self.carQuoteId ?? 0, insurer: self.insurance?.aseguradora ?? "", plan: self.planSelected?.formaPago ?? "", coverage: self.coverageSelected)
        
        
    }
}

