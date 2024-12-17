//
//  principalViewController.swift
//  SuperSegurosSDKIOS
//
//  Created by Oscar Aguilar on 12/11/24.
//

import UIKit

public class principalViewController: UIViewController {

    public static let principalVC = UIStoryboard(name: "Storyboard", bundle: Bundle.module).instantiateInitialViewController()!
    
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var titleOneLabel: UILabel!
    @IBOutlet weak var subTitileOneLabel: UILabel!
    @IBOutlet weak var titleTwoLabel: UILabel!
    @IBOutlet weak var subTitleTwoLabel: UILabel!
    @IBOutlet weak var preTitleLabel: UILabel!
    
    @IBOutlet weak var quoteInsuranceTopButton: UIButton!
    @IBOutlet weak var quoteInsuranceBottomButton: UIButton!
    @IBOutlet weak var typeInsuranceSegmentedControl: UISegmentedControl!
    
    //views include insurance
    @IBOutlet weak var OneView: UIView!
    @IBOutlet weak var oneTextLabel: UILabel!
    @IBOutlet weak var TwoView: UIView!
    @IBOutlet weak var twoTextLabel: UILabel!
    @IBOutlet weak var ThreeView: UIView!
    @IBOutlet weak var threeTextLabel: UILabel!
    @IBOutlet weak var FourView: UIView!
    @IBOutlet weak var fourTextLabel: UILabel!
    @IBOutlet weak var FiveView: UIView!
    @IBOutlet weak var fiveTextLabel: UILabel!
    @IBOutlet weak var SixView: UIView!
    @IBOutlet weak var sixTextLabel: UILabel!
    @IBOutlet weak var SevenView: UIView!
    @IBOutlet weak var sevenTextLabel: UILabel!
    @IBOutlet weak var EigthView: UIView!
    @IBOutlet weak var eigthTextLabel: UILabel!
    @IBOutlet weak var NineView: UIView!
    @IBOutlet weak var nineTextLabel: UILabel!
    @IBOutlet weak var TenView: UIView!
    @IBOutlet weak var tenTextLabel: UILabel!
    
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func quoteInsuranceAction(_ sender: Any) {
        
       /*
        let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle.module)
        let switchViewController = storyboard.instantiateViewController(withIdentifier: "formAutomobile")
        switchViewController.modalPresentationStyle = .popover
        switchViewController.isModalInPresentation = true
        self.present(UINavigationController(rootViewController: switchViewController), animated: true, completion: nil)
        
        */
        
        let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle.module)
        let switchViewController = storyboard.instantiateViewController(withIdentifier: "dataVehicle") as! dataVehicleViewController
        switchViewController.modalPresentationStyle = .fullScreen
        switchViewController.isModalInPresentation = true
        self.present(UINavigationController(rootViewController: switchViewController), animated: true, completion: nil)
        
        /*
        let coberturaVC = CoverageViewController()
        coberturaVC.modalPresentationStyle = .popover
        coberturaVC.isModalInPresentation = true
        self.present(UINavigationController(rootViewController: coberturaVC), animated: true, completion: nil)
     */
    }
    
    @IBAction func typeInsuranceSC(_ sender: UISegmentedControl) {
        switch typeInsuranceSegmentedControl.selectedSegmentIndex {
            case 0:
                OneView.isHidden = false
                TwoView.isHidden = false
                ThreeView.isHidden = false
                FourView.isHidden = false
                
            case 1:
                OneView.isHidden = true
                
                TwoView.isHidden = false
                ThreeView.isHidden = false
                FourView.isHidden = false
                
            case 2:
                OneView.isHidden = true
                TwoView.isHidden = true
                ThreeView.isHidden = true
                
                FourView.isHidden = false
                
            case 3:
                OneView.isHidden = true
                TwoView.isHidden = true
                ThreeView.isHidden = true
                FourView.isHidden = true
                
            default:
                print("default")
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
      
        do {
            try registerFont(named: "Poppins-Bold")
            try registerFont(named: "Poppins-SemiBold")
            try registerFont(named: "Poppins-Regular")
            try registerFont(named: "Poppins-Light")
            
            changeFont()
            
        } catch {
            print("errosito")
        }
        
        setStyle()
    }
    
    func changeFont() {
        titleLabel.font = UIFont.poppinsSemiBold(size: 38)
        subTitleLabel.font = UIFont.poppinsSemiBold(size: 18)
        
        titleOneLabel.font = UIFont.poppinsRegular(size: 17)
        subTitileOneLabel.font = UIFont.poppinsSemiBold(size: 30)
        quoteInsuranceTopButton.titleLabel?.font = UIFont.poppinsSemiBold(size: 17)
        
        titleTwoLabel.font = UIFont.poppinsRegular(size: 18)
        subTitleTwoLabel.font = UIFont.poppinsSemiBold(size: 30)
        preTitleLabel.font = UIFont.poppinsSemiBold(size: 18)
        
        oneTextLabel.font = UIFont.poppinsSemiBold(size: 16)
        twoTextLabel.font = UIFont.poppinsRegular(size: 16)
        threeTextLabel.font = UIFont.poppinsRegular(size: 16)
        fourTextLabel.font = UIFont.poppinsRegular(size: 16)
        fiveTextLabel.font = UIFont.poppinsRegular(size: 16)
        sixTextLabel.font = UIFont.poppinsRegular(size: 16)
        sevenTextLabel.font = UIFont.poppinsRegular(size: 16)
        eigthTextLabel.font = UIFont.poppinsRegular(size: 16)
        nineTextLabel.font = UIFont.poppinsRegular(size: 16)
        tenTextLabel.font = UIFont.poppinsRegular(size: 16)
        
        quoteInsuranceBottomButton.titleLabel?.font = UIFont.poppinsSemiBold(size: 17)
    }
    
    func setStyle() {
        quoteInsuranceTopButton.layer.cornerRadius = 20
        quoteInsuranceBottomButton.layer.cornerRadius = 20
        
        typeInsuranceSegmentedControl.backgroundColor = .white
        typeInsuranceSegmentedControl.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        
        let normalFont =  UIFont.poppinsRegular(size: 14)
        let boldFont = UIFont.poppinsSemiBold(size: 14)
        
        let titleSelected = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: boldFont]
        let titleUnselected = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: normalFont]
        
        
        typeInsuranceSegmentedControl.setTitleTextAttributes(titleUnselected as [NSAttributedString.Key : Any], for: .normal)
        typeInsuranceSegmentedControl.setTitleTextAttributes(titleSelected as [NSAttributedString.Key : Any], for: .selected)
        
        typeInsuranceSegmentedControl.layer.borderColor = UIColor.lightGray.cgColor
        typeInsuranceSegmentedControl.layer.borderWidth = 1
    
    }
    
}
