//
//  CoverageCardView.swift
//  UseLibrary
//
//  Created by Christian Martinez on 22/11/24.
//

import UIKit

class CoverageCardView: UIView {
    var detailsLabel: UILabel?
    var arrowImageView: UIImageView?
    var collapsedHeightConstraint: NSLayoutConstraint?
    var expandedHeightConstraint: NSLayoutConstraint?
    var coverageType: Int?
    var optionButtons: [UIButton]?
    var pickerButton: UIButton?
    var pickerOptions: [String]?
    var actionButton: UIButton?
    var additionalViews: [UIView]?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupCard(coverage: [String: Any], index: Int) {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.tag = index
        self.isUserInteractionEnabled = true

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        self.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -10)
        ])

        let firstRow = UIView()
        firstRow.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(firstRow)

        firstRow.heightAnchor.constraint(greaterThanOrEqualToConstant: 24).isActive = true

        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = coverage["title"] as? String
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        firstRow.addSubview(titleLabel)

        let arrowImageView = UIImageView()
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.image = UIImage(systemName: "chevron.down")
        arrowImageView.tintColor = .gray
        firstRow.addSubview(arrowImageView)
        self.arrowImageView = arrowImageView

        let amountLabel = UILabel()
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.text = coverage["amount"] as? String
        amountLabel.font = UIFont.systemFont(ofSize: 16)
        firstRow.addSubview(amountLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: firstRow.leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: firstRow.centerYAnchor),

            arrowImageView.trailingAnchor.constraint(equalTo: firstRow.trailingAnchor),
            arrowImageView.centerYAnchor.constraint(equalTo: firstRow.centerYAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: 20),
            arrowImageView.heightAnchor.constraint(equalToConstant: 20),

            amountLabel.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -5),
            amountLabel.centerYAnchor.constraint(equalTo: firstRow.centerYAnchor),

            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: amountLabel.leadingAnchor, constant: -5),
        ])

        let detailsLabel = UILabel()
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        detailsLabel.text = coverage["details"] as? String
        detailsLabel.font = UIFont.systemFont(ofSize: 14)
        detailsLabel.numberOfLines = 0
        detailsLabel.isHidden = true
        stackView.addArrangedSubview(detailsLabel)
        self.detailsLabel = detailsLabel

        let collapsedHeightConstraint = self.heightAnchor.constraint(equalToConstant: 54)
        collapsedHeightConstraint.priority = UILayoutPriority(999)
        collapsedHeightConstraint.isActive = true
        self.collapsedHeightConstraint = collapsedHeightConstraint

        let expandedHeightConstraint = self.heightAnchor.constraint(greaterThanOrEqualToConstant: 54)
        expandedHeightConstraint.priority = UILayoutPriority(999)
        expandedHeightConstraint.isActive = false
        self.expandedHeightConstraint = expandedHeightConstraint

        let coverageType = coverage["coverageType"] as? Int
        self.coverageType = coverageType

        if let coverageType = coverageType {
            switch coverageType {
            case 1:
                if let options = coverage["options"] as? [String] {
                    let buttonsScrollView = UIScrollView()
                    buttonsScrollView.translatesAutoresizingMaskIntoConstraints = false
                    buttonsScrollView.showsHorizontalScrollIndicator = false

                    let buttonsStackView = UIStackView()
                    buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
                    buttonsStackView.axis = .horizontal
                    buttonsStackView.spacing = 10
                    buttonsScrollView.addSubview(buttonsStackView)

                    NSLayoutConstraint.activate([
                        buttonsStackView.topAnchor.constraint(equalTo: buttonsScrollView.topAnchor),
                        buttonsStackView.bottomAnchor.constraint(equalTo: buttonsScrollView.bottomAnchor),
                        buttonsStackView.leadingAnchor.constraint(equalTo: buttonsScrollView.leadingAnchor),
                        buttonsStackView.trailingAnchor.constraint(equalTo: buttonsScrollView.trailingAnchor),
                        buttonsStackView.heightAnchor.constraint(equalTo: buttonsScrollView.heightAnchor)
                    ])

                    buttonsScrollView.heightAnchor.constraint(equalToConstant: 34).isActive = true

                    var optionButtons: [UIButton] = []

                    for option in options {
                        let button = UIButton(type: .custom)
                        button.setTitle(option, for: .normal)
                        button.setTitleColor(.purple, for: .normal)
                        button.backgroundColor = .white
                        button.layer.cornerRadius = 18
                        button.layer.borderWidth = 1
                        button.layer.borderColor = UIColor.lightGray.cgColor
                        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                        button.translatesAutoresizingMaskIntoConstraints = false

                        button.addTarget(nil, action: #selector(CoverageViewController.optionButtonTapped(_:)), for: .touchUpInside)

                        NSLayoutConstraint.activate([
                            button.widthAnchor.constraint(equalToConstant: 53),
                            button.heightAnchor.constraint(equalToConstant: 34)
                        ])

                        buttonsStackView.addArrangedSubview(button)
                        optionButtons.append(button)
                    }

                    self.optionButtons = optionButtons

                    buttonsScrollView.isHidden = true
                    stackView.addArrangedSubview(buttonsScrollView)

                    let quitarButton = UIButton(type: .custom)
                    quitarButton.setTitle("Quitar", for: .normal)
                    quitarButton.setTitleColor(.purple, for: .normal)
                    quitarButton.backgroundColor = .white
                    quitarButton.layer.cornerRadius = 18
                    quitarButton.layer.borderWidth = 1
                    quitarButton.layer.borderColor = UIColor.lightGray.cgColor
                    quitarButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                    quitarButton.translatesAutoresizingMaskIntoConstraints = false

                    quitarButton.addTarget(nil, action: #selector(CoverageViewController.quitarButtonTapped(_:)), for: .touchUpInside)

                    NSLayoutConstraint.activate([
                        quitarButton.widthAnchor.constraint(equalToConstant: 79),
                        quitarButton.heightAnchor.constraint(equalToConstant: 34)
                    ])

                    let quitarButtonContainer = UIView()
                    quitarButtonContainer.translatesAutoresizingMaskIntoConstraints = false
                    quitarButtonContainer.addSubview(quitarButton)

                    NSLayoutConstraint.activate([
                        quitarButton.trailingAnchor.constraint(equalTo: quitarButtonContainer.trailingAnchor),
                        quitarButton.topAnchor.constraint(equalTo: quitarButtonContainer.topAnchor),
                        quitarButton.bottomAnchor.constraint(equalTo: quitarButtonContainer.bottomAnchor)
                    ])

                    quitarButtonContainer.isHidden = true
                    stackView.addArrangedSubview(quitarButtonContainer)

                    self.additionalViews = [buttonsScrollView, quitarButtonContainer]
                    self.actionButton = quitarButton
                }

            case 2:
                if let pickerOptions = coverage["pickerOptions"] as? [String] {
                    let pickerButton = UIButton(type: .custom)
                    pickerButton.setTitle("Selecciona una opción", for: .normal)
                    pickerButton.setTitleColor(.purple, for: .normal)
                    pickerButton.backgroundColor = .white
                    pickerButton.layer.cornerRadius = 18
                    pickerButton.layer.borderWidth = 1
                    pickerButton.layer.borderColor = UIColor.lightGray.cgColor
                    pickerButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                    pickerButton.contentHorizontalAlignment = .left
                    pickerButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 40)
                    pickerButton.translatesAutoresizingMaskIntoConstraints = false

                    let arrowImageView = UIImageView(image: UIImage(systemName: "chevron.down"))
                    arrowImageView.tintColor = .gray
                    arrowImageView.translatesAutoresizingMaskIntoConstraints = false
                    pickerButton.addSubview(arrowImageView)

                    NSLayoutConstraint.activate([
                        arrowImageView.centerYAnchor.constraint(equalTo: pickerButton.centerYAnchor),
                        arrowImageView.trailingAnchor.constraint(equalTo: pickerButton.trailingAnchor, constant: -10),
                        arrowImageView.widthAnchor.constraint(equalToConstant: 20),
                        arrowImageView.heightAnchor.constraint(equalToConstant: 20)
                    ])

                    pickerButton.addTarget(nil, action: #selector(CoverageViewController.pickerButtonTapped(_:)), for: .touchUpInside)

                    self.pickerButton = pickerButton
                    self.pickerOptions = pickerOptions

                    pickerButton.isHidden = true
                    stackView.addArrangedSubview(pickerButton)
                    pickerButton.heightAnchor.constraint(equalToConstant: 34).isActive = true

                    let quitarButton = UIButton(type: .custom)
                    quitarButton.setTitle("Quitar", for: .normal)
                    quitarButton.setTitleColor(.purple, for: .normal)
                    quitarButton.backgroundColor = .white
                    quitarButton.layer.cornerRadius = 18
                    quitarButton.layer.borderWidth = 1
                    quitarButton.layer.borderColor = UIColor.lightGray.cgColor
                    quitarButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                    quitarButton.translatesAutoresizingMaskIntoConstraints = false

                    quitarButton.addTarget(nil, action: #selector(CoverageViewController.quitarButtonTapped(_:)), for: .touchUpInside)

                    NSLayoutConstraint.activate([
                        quitarButton.widthAnchor.constraint(equalToConstant: 79),
                        quitarButton.heightAnchor.constraint(equalToConstant: 34)
                    ])

                    let quitarButtonContainer = UIView()
                    quitarButtonContainer.translatesAutoresizingMaskIntoConstraints = false
                    quitarButtonContainer.addSubview(quitarButton)

                    NSLayoutConstraint.activate([
                        quitarButton.trailingAnchor.constraint(equalTo: quitarButtonContainer.trailingAnchor),
                        quitarButton.topAnchor.constraint(equalTo: quitarButtonContainer.topAnchor),
                        quitarButton.bottomAnchor.constraint(equalTo: quitarButtonContainer.bottomAnchor)
                    ])

                    quitarButtonContainer.isHidden = true
                    stackView.addArrangedSubview(quitarButtonContainer)

                    self.additionalViews = [pickerButton, quitarButtonContainer]
                    self.actionButton = quitarButton
                }

            case 3:
                let quitarButton = UIButton(type: .custom)
                quitarButton.setTitle("Quitar", for: .normal)
                quitarButton.setTitleColor(.purple, for: .normal)
                quitarButton.backgroundColor = .white
                quitarButton.layer.cornerRadius = 18
                quitarButton.layer.borderWidth = 1
                quitarButton.layer.borderColor = UIColor.lightGray.cgColor
                quitarButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                quitarButton.translatesAutoresizingMaskIntoConstraints = false

                quitarButton.addTarget(nil, action: #selector(CoverageViewController.quitarButtonTapped(_:)), for: .touchUpInside)

                NSLayoutConstraint.activate([
                    quitarButton.widthAnchor.constraint(equalToConstant: 79),
                    quitarButton.heightAnchor.constraint(equalToConstant: 34)
                ])

                let quitarButtonContainer = UIView()
                quitarButtonContainer.translatesAutoresizingMaskIntoConstraints = false
                quitarButtonContainer.addSubview(quitarButton)

                NSLayoutConstraint.activate([
                    quitarButton.trailingAnchor.constraint(equalTo: quitarButtonContainer.trailingAnchor),
                    quitarButton.topAnchor.constraint(equalTo: quitarButtonContainer.topAnchor),
                    quitarButton.bottomAnchor.constraint(equalTo: quitarButtonContainer.bottomAnchor)
                ])

                quitarButtonContainer.isHidden = true
                stackView.addArrangedSubview(quitarButtonContainer)
                self.additionalViews = [quitarButtonContainer]
                self.actionButton = quitarButton

            case 4:
                let addButton = UIButton(type: .custom)
                addButton.setTitle("Añadir", for: .normal)
                addButton.setTitleColor(.white, for: .normal)
                addButton.backgroundColor = .purple
                addButton.layer.cornerRadius = 18
                addButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                addButton.translatesAutoresizingMaskIntoConstraints = false

                addButton.addTarget(nil, action: #selector(CoverageViewController.addButtonTapped(_:)), for: .touchUpInside)

                NSLayoutConstraint.activate([
                    addButton.widthAnchor.constraint(equalToConstant: 79),
                    addButton.heightAnchor.constraint(equalToConstant: 34)
                ])

                let addButtonContainer = UIView()
                addButtonContainer.translatesAutoresizingMaskIntoConstraints = false
                addButtonContainer.addSubview(addButton)

                NSLayoutConstraint.activate([
                    addButton.trailingAnchor.constraint(equalTo: addButtonContainer.trailingAnchor),
                    addButton.topAnchor.constraint(equalTo: addButtonContainer.topAnchor),
                    addButton.bottomAnchor.constraint(equalTo: addButtonContainer.bottomAnchor)
                ])

                addButtonContainer.isHidden = true
                stackView.addArrangedSubview(addButtonContainer)
                self.additionalViews = [addButtonContainer]
                self.actionButton = addButton

            default:
                break
            }
        }
    }
}
