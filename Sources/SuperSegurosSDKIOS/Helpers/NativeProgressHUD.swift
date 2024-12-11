//
//  NativeProgressHUD.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 10/12/24.
//


import Foundation
import UIKit

class NativeProgressHUD: UIView {

    static let shared = NativeProgressHUD()
    let hudView: UIView
    let progressView: UIView
    var activityIndicator: UIActivityIndicatorView
   
    var hudWidth: CGFloat = 200
    var hudHeight: CGFloat = 150
    var hudBackgroundColor = UIColor.white
    var borderWidth: CGFloat = 0
    var labelFont =  UIFont.poppinsSemiBold(size: 13)
    var borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
    var borderRadius: CGFloat = 15
    
    override init(frame: CGRect) {
        self.hudView = UIView()
        self.progressView = UIView()
        self.activityIndicator = UIActivityIndicatorView(style: .large)
        self.activityIndicator.color = UIColor.moduleColor(named: "skyBlue")
        self.activityIndicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)

        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.hudView = UIView()
        self.progressView = UIView()
        self.activityIndicator = UIActivityIndicatorView(style: .large)
        self.activityIndicator.color = UIColor.moduleColor(named: "skyBlue")
        self.activityIndicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        super.init(coder: aDecoder)
        self.setup()
    }
    
    func setup() {
        self.addSubview(hudView)
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if let superview = self.superview {
            self.activityIndicator.removeFromSuperview()
            
           
            self.frame = superview.bounds
            hudView.frame = self.bounds
            hudView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
            
            let width = self.bounds.width
            let height = self.bounds.height
            
            progressView.frame = CGRect(
                x: (width / 2) - (self.hudWidth / 2),
                y: (height / 2) - (self.hudHeight / 2),
                width: self.hudWidth,
                height: self.hudHeight
            )
            progressView.backgroundColor = self.hudBackgroundColor
            progressView.layer.borderColor = self.borderColor
            progressView.layer.borderWidth = self.borderWidth
            progressView.layer.cornerRadius = self.borderRadius
            progressView.layer.masksToBounds = true
            
            self.hudView.addSubview(progressView)
            
            // Posicionar el activity indicator en el centro del progressView
            activityIndicator.center = CGPoint(x: progressView.bounds.midX, y: progressView.bounds.midY)
            progressView.addSubview(activityIndicator)

            self.hide()
        }
    }

    func addLabel(title: String = "Cargando...") {
        if let viewWithTag = self.progressView.viewWithTag(500) {
           viewWithTag.removeFromSuperview()
        }
        
        let label = UILabel(frame: CGRect(x: 0, y: 100, width: 200, height: 41))
        label.textAlignment = .center
        label.font = self.labelFont
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 2
        label.tag = 500
        label.text = title
        label.textColor = .black
        self.progressView.addSubview(label)
    }
    
    func show(title: String = "Cargando...") {
        self.addLabel(title: title)
        self.activityIndicator.startAnimating()
        self.isHidden = false
        self.layer.zPosition = 1
    }
    
    func hide() {
        self.isHidden = true
        self.activityIndicator.stopAnimating()
    }
}
