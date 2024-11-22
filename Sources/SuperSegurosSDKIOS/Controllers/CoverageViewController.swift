//
//  Untitled.swift
//  UseLibrary
//
//  Created by Christian Martinez on 20/11/24.
//

import UIKit

class CoverageViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupScrollView()
        setupContent()
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
    
    func setupContent() {
        setupLogoImage()
        setupCoverageLabel()
        setupSegmentedControl()
        let paymentMethodLabel = setupPaymentMethodLabel()
        let lastCard = addPaymentCards(below: paymentMethodLabel)
        let carDetailsView = addCarDetailsLabel(below: lastCard)
        addCoverageSection(below: carDetailsView)
    }
    
    func setupLogoImage() {
        
      
        let logoImageView = UIImageView(image:  UIImage.moduleImage(named: "superLogoColor"))
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.contentMode = .scaleAspectFit
   
        contentView.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
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
        coverageLabel.textAlignment = .center
        contentView.addSubview(coverageLabel)
        NSLayoutConstraint.activate([
            coverageLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            coverageLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    func setupSegmentedControl() {
        let options = ["Plus", "Amplia", "Limitada", "Básica"]
        segmentedControl = UISegmentedControl(items: options)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(segmentedControl)
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: coverageLabel.bottomAnchor, constant: 20),
            segmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    }
    
    func setupPaymentMethodLabel() -> UILabel {
        let paymentMethodLabel = UILabel()
        paymentMethodLabel.translatesAutoresizingMaskIntoConstraints = false
        paymentMethodLabel.text = "Forma de Pago"
        paymentMethodLabel.textAlignment = .center
        contentView.addSubview(paymentMethodLabel)
        NSLayoutConstraint.activate([
            paymentMethodLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            paymentMethodLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        return paymentMethodLabel
    }
    
    func addPaymentCards(below previousView: UIView) -> UIView {
        let payments = [
            ("Anualmente", "1 pago"),
            ("Trimestralmente", "4 pagos"),
            ("Semestralmente", "2 pagos"),
            ("Mensualmente", "12 pagos")
        ]
        var previousView = previousView
        var lastCard: UIView = previousView
        for (index, payment) in payments.enumerated() {
            let card = PaymentCardView(title: payment.0, subtitle: payment.1, tag: index)
            card.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(card)
            NSLayoutConstraint.activate([
                card.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
                card.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
                card.heightAnchor.constraint(equalToConstant: 77),
                card.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 20)
            ])
            previousView = card
            lastCard = card
            radioButtons.append(card.radioButton)
        }
        return lastCard
    }
    
    func addCarDetailsLabel(below previousView: UIView) -> UIView {
        let carDetailsLabel = UILabel()
        carDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
        carDetailsLabel.text = "Detalles del auto asegurado"
        carDetailsLabel.textAlignment = .center
        contentView.addSubview(carDetailsLabel)
        NSLayoutConstraint.activate([
            carDetailsLabel.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 20),
            carDetailsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        let carDetailsView = addCarDetailsView(below: carDetailsLabel)
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
        blueView.backgroundColor = UIColor(red: 0/255, green: 51/255, blue: 102/255, alpha: 1)
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
        let labels = [
            ("Marca", "Seat"),
            ("Año", "2019"),
            ("Modelo", "Ateca"),
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
            titleLabel.font = UIFont.systemFont(ofSize: 14)
            titleLabel.textAlignment = .center
            container.addSubview(titleLabel)
            let valueLabel = UILabel()
            valueLabel.translatesAutoresizingMaskIntoConstraints = false
            valueLabel.text = labelInfo.1
            valueLabel.font = UIFont.boldSystemFont(ofSize: 16)
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
                let imageView = UIImageView(image: UIImage(named: "carImage"))
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
        versionTitleLabel.font = UIFont.systemFont(ofSize: 14)
        versionTitleLabel.textAlignment = .center
        whiteView.addSubview(versionTitleLabel)
        let versionValueLabel = UILabel()
        versionValueLabel.translatesAutoresizingMaskIntoConstraints = false
        versionValueLabel.text = "FR 5P L4 1.4L TSI FWD BA QC AUT 5 OCUPANTES"
        versionValueLabel.font = UIFont.boldSystemFont(ofSize: 16)
        versionValueLabel.textAlignment = .center
        versionValueLabel.numberOfLines = 0
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
        let labelsText = [
            "Tu Súper seguro de auto por:",
            "$1,720.09 MXN",
            "Semestralmente",
            "*Seguro respaldado y operado por: General de Seguros S.A. de C.V."
        ]
        var previousLabel: UILabel?
        for text in labelsText {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = text
            label.font = UIFont.systemFont(ofSize: 14)
            label.textAlignment = .center
            label.textColor = .white
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
        }
        previousLabel?.bottomAnchor.constraint(equalTo: blueView.bottomAnchor, constant: -10).isActive = true
    }
    
    func addCoverageSection(below previousView: UIView) {
        let labelsContainer = UIView()
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
        coveragesTitleLabel.font = UIFont.systemFont(ofSize: 16)
        labelsContainer.addSubview(coveragesTitleLabel)
        let coversUpToLabel = UILabel()
        coversUpToLabel.translatesAutoresizingMaskIntoConstraints = false
        coversUpToLabel.textAlignment = .right
        coversUpToLabel.font = UIFont.systemFont(ofSize: 16)
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
        coverageCardsContainer = UIView()
        coverageCardsContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(coverageCardsContainer)
        NSLayoutConstraint.activate([
            coverageCardsContainer.topAnchor.constraint(equalTo: labelsContainer.bottomAnchor, constant: 10),
            coverageCardsContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            coverageCardsContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        addCoverageCards()
    }
    
    func updateCoveragesTitle() {
        let selectedIndex = segmentedControl.selectedSegmentIndex
        let selectedOption = segmentedControl.titleForSegment(at: selectedIndex)
        if selectedOption == "Plus" {
            coveragesTitleLabel.text = "Editar tus coberturas"
        } else {
            coveragesTitleLabel.text = "Coberturas"
        }
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        updateCoveragesTitle()
        addCoverageCards()
    }
    
    func addCoverageCards() {
        for card in coverageCards {
            card.removeFromSuperview()
        }
        coverageCards.removeAll()
        coveragesData = getCoveragesDataForSelectedSegment()
        var previousCard: UIView?
        for (index, coverage) in coveragesData.enumerated() {
            let card = createCoverageCard(coverage: coverage, index: index)
            coverageCardsContainer.addSubview(card)
            NSLayoutConstraint.activate([
                card.leadingAnchor.constraint(equalTo: coverageCardsContainer.leadingAnchor, constant: 15),
                card.trailingAnchor.constraint(equalTo: coverageCardsContainer.trailingAnchor, constant: -15)
            ])
            if let previous = previousCard {
                card.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            } else {
                card.topAnchor.constraint(equalTo: coverageCardsContainer.topAnchor).isActive = true
            }
            previousCard = card
            coverageCards.append(card)
        }
        if let lastCard = previousCard {
            lastCard.bottomAnchor.constraint(equalTo: coverageCardsContainer.bottomAnchor).isActive = true
        } else {
            coverageCardsContainer.bottomAnchor.constraint(equalTo: coverageCardsContainer.topAnchor).isActive = true
        }
        coverageCardsContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
    }
    
    func getCoveragesDataForSelectedSegment() -> [[String: Any]] {
        let selectedIndex = segmentedControl.selectedSegmentIndex
        let selectedOption = segmentedControl.titleForSegment(at: selectedIndex)
        switch selectedOption {
        case "Plus":
            return [
                ["title": "Asistencia Jurídica", "amount": "$40,000", "details": "Detalle de Asistencia Jurídica...", "coverageType": 1, "options": ["0%", "3%", "5%", "10%"]],
                ["title": "Cobertura Plus 1", "amount": "$50,000", "details": "Detalle de Cobertura Plus 1...", "coverageType": 2, "pickerOptions": ["$400,000", "$500,000"]],
                ["title": "Cobertura Plus 2", "amount": "$60,000", "details": "Detalle de Cobertura Plus 2...", "coverageType": 3],
                ["title": "Cobertura Plus 3", "amount": "$70,000", "details": "Detalle de Cobertura Plus 3...", "coverageType": 4]
            ]
        default:
            return [
                ["title": "Cobertura \(selectedOption!) 1", "amount": "$10,000", "details": "Detalle de Cobertura \(selectedOption!) 1..."]
            ]
        }
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
        sender.backgroundColor = UIColor.purple
        sender.layer.borderColor = UIColor.purple.cgColor
        let selected = sender.tag
        print("Selected radio button: \(selected)")
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
                    button.setTitleColor(.purple, for: .normal)
                    button.layer.borderColor = UIColor.lightGray.cgColor
                }
            }
            sender.isSelected = true
            sender.backgroundColor = .purple
            sender.setTitleColor(.white, for: .normal)
            sender.layer.borderColor = UIColor.purple.cgColor
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
}

