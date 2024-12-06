//
//  SuperSegurosButton.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 05/12/24.
//

import UIKit

public class SuperSegurosButton: UIControl {
    
    private let logoImageView = UIImageView()
    private let separatorView = UIView()
    private let textLabel = UILabel()
    private let carImageView = UIImageView()
    
    private let gradientLayer = CAGradientLayer()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupActions()
    }
    
    private func setupView() {
 
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.backgroundColor = .blue
     
        gradientLayer.colors = [
            UIColor.moduleColor(named: "rosaSuper")?.cgColor ?? UIColor.systemTeal.cgColor,
            UIColor.moduleColor(named: "mainSuper")?.cgColor ?? UIColor.systemTeal.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        layer.insertSublayer(gradientLayer, at: 0)
        
        // Sombra
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.28).cgColor
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 1.0
        
      
         logoImageView.image =  UIImage.moduleImage(named: "logoSuper")
        logoImageView.contentMode = .scaleAspectFit
        

        separatorView.backgroundColor = .white
    
        let fullText = "Cotiza tu \nseguro aquí"
        let attributedString = NSMutableAttributedString(
            string: fullText,
            attributes: [
                .font: UIFont.poppinsLight(size: 14),
                .foregroundColor: UIColor.white
            ]
        )

        if let range = fullText.range(of: "aquí") {
            let nsRange = NSRange(range, in: fullText)
            attributedString.addAttributes([
                .font: UIFont.poppinsSemiBold(size: 12)
            ], range: nsRange)
        }
        textLabel.numberOfLines = 2
        textLabel.attributedText = attributedString
    
        carImageView.image = UIImage.moduleImage(named: "car")
        carImageView.contentMode = .scaleAspectFit
        
   
        addSubview(logoImageView)
        addSubview(separatorView)
        addSubview(textLabel)
        addSubview(carImageView)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        
     
        let padding: CGFloat = 12.0
        let spacing: CGFloat = 8.0
        
      
        let logoWidth: CGFloat = 100
        logoImageView.frame = CGRect(x: padding,
                                     y: (bounds.height - logoWidth)/2,
                                     width: logoWidth,
                                     height: logoWidth)
        
      
        let separatorWidth: CGFloat = 1
        separatorView.frame = CGRect(x: logoImageView.frame.maxX + spacing,
                                     y: (bounds.height - 30)/2,
                                     width: separatorWidth,
                                     height: 30)
        
       
        let carWidth: CGFloat = 80
        carImageView.frame = CGRect(x: bounds.width - padding - carWidth,
                                    y: (bounds.height - carWidth)/2,
                                    width: carWidth,
                                    height: carWidth)
        
     
        let textX = separatorView.frame.maxX + spacing
        let textWidth = carImageView.frame.minX - spacing - textX
        textLabel.frame = CGRect(x: textX,
                                 y: 0,
                                 width: textWidth,
                                 height: bounds.height)
    }
    
    private func setupActions() {
       
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
      
        guard let topVC = topViewController() else { return }
        
        let vc = principalViewController.principalVC
        vc.isModalInPresentation = true
        topVC.present(vc, animated: true)
    }
    
   
    private func topViewController(base: UIViewController? = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return topViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
