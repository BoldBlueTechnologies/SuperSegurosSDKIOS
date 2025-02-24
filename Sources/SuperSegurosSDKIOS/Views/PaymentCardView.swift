//
//  PaymentCardView.swift
//  UseLibrary
//
//  Created by Christian Martinez on 22/11/24.
//


import UIKit

class PaymentCardView: UIView {
    
    // MARK: - Properties
    
    var radioButton: UIButton!
    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    var priceLabel1: UILabel!
    var priceLabel2: UILabel!
    var priceLabel3: UILabel!
    
    // MARK: - Initializer
    
    init(title: String, subtitle: String, tag: Int) {
        super.init(frame: .zero)
        setupView(title: title, subtitle: subtitle, tag: tag)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setup Methods
    
    private func setupView(title: String, subtitle: String, tag: Int) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.moduleColor(named: "borderEmpty")?.cgColor
        
        radioButton = UIButton(type: .custom)
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        radioButton.layer.cornerRadius = 12
        radioButton.layer.borderWidth = 2
        radioButton.layer.borderColor = UIColor.black.cgColor
        radioButton.backgroundColor = UIColor.white
        radioButton.tag = tag
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        titleLabel.font = UIFont.poppinsSemiBold(size: 13)

        subtitleLabel = UILabel()
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.text = subtitle
        subtitleLabel.font = UIFont.poppinsRegular(size: 13)
        
        priceLabel1 = UILabel()
        priceLabel1.translatesAutoresizingMaskIntoConstraints = false
  
        priceLabel1.textAlignment = .right
        priceLabel1.textColor = UIColor.moduleColor(named: "rosaSuper")
        priceLabel1.font = UIFont.poppinsSemiBold(size: 13)
        
        priceLabel2 = UILabel()
        priceLabel2.translatesAutoresizingMaskIntoConstraints = false
  
        priceLabel2.textAlignment = .right
        priceLabel2.font = UIFont.poppinsRegular(size: 13)
        
        priceLabel3 = UILabel()
        priceLabel3.translatesAutoresizingMaskIntoConstraints = false
  
        priceLabel3.textAlignment = .right
        priceLabel3.font = UIFont.poppinsRegular(size: 13)
    
        
        addSubview(radioButton)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(priceLabel1)
        addSubview(priceLabel2)
        addSubview(priceLabel3)
        

        NSLayoutConstraint.activate([
         
            radioButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            radioButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            radioButton.widthAnchor.constraint(equalToConstant: 24),
            radioButton.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            titleLabel.leadingAnchor.constraint(equalTo: radioButton.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: priceLabel1.leadingAnchor, constant: -8),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
          //  subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            subtitleLabel.widthAnchor.constraint(equalToConstant: 150),
            
            priceLabel1.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            priceLabel1.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14),
            priceLabel1.widthAnchor.constraint(equalToConstant: 150),
            
            priceLabel2.topAnchor.constraint(equalTo: priceLabel1.bottomAnchor, constant: 4),
            priceLabel2.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14),
            priceLabel2.widthAnchor.constraint(equalToConstant: 160),
            
            priceLabel3.topAnchor.constraint(equalTo: priceLabel2.bottomAnchor, constant: 4),
            priceLabel3.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14),
            priceLabel3.widthAnchor.constraint(equalToConstant: 160)
        ])

        radioButton.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(entireViewTapped(_:)))
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
    }
    
    // MARK: - Actions
    
    @objc private func entireViewTapped(_ gesture: UITapGestureRecognizer) {
        // Llamas la misma lógica que el botón
        radioButtonTapped(radioButton)
    }

    
    @objc func radioButtonTapped(_ sender: UIButton) {
        if let viewController = self.parentViewController() as? CoverageViewController {
            viewController.radioButtonTapped(sender)
        }
    }
}
