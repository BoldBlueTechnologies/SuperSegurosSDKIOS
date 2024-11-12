//
//  principalViewController.swift
//  SuperSegurosSDKIOS
//
//  Created by Oscar Aguilar on 12/11/24.
//

import UIKit
import SuperSegurosSDKIOS

public class principalViewController: UIViewController {

    public static let principalVC = UIStoryboard(name: "Storyboard", bundle: Bundle.module).instantiateInitialViewController()!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var quoteInsuranceTopButton: UIButton!
    @IBOutlet weak var quoteInsuranceBottomButton: UIButton!
    @IBOutlet weak var typeInsuranceSegmentedControl: UISegmentedControl!
    
    //views include insurance
    @IBOutlet weak var OneView: UIView!
    @IBOutlet weak var TwoView: UIView!
    @IBOutlet weak var ThreeView: UIView!
    @IBOutlet weak var FourView: UIView!
    @IBOutlet weak var FiveView: UIView!
    @IBOutlet weak var SixView: UIView!
    @IBOutlet weak var SevenView: UIView!
    @IBOutlet weak var EigthView: UIView!
    @IBOutlet weak var NineView: UIView!
    @IBOutlet weak var TenView: UIView!
    
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func quoteInsuranceAction(_ sender: Any) {
        print("READY......")
    }
    
    @IBAction func typeInsuranceSC(_ sender: UISegmentedControl) {
        switch typeInsuranceSegmentedControl.selectedSegmentIndex {
        case 0:
            print("case 0")
            
            OneView.isHidden = false
            TwoView.isHidden = false
            ThreeView.isHidden = false
            FourView.isHidden = false
            
        case 1:
            print("case 1")
            OneView.isHidden = true
            
            TwoView.isHidden = false
            ThreeView.isHidden = false
            FourView.isHidden = false
            
        case 2:
            print("case 2")
            
            OneView.isHidden = true
            TwoView.isHidden = true
            ThreeView.isHidden = true
            
            FourView.isHidden = false
            
        case 3:
            print("case 3")
            
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
            try registerFont(named: "Poppins-SemiBold")
            
            titleLabel.font = UIFont(name: "Poppins-SemiBold", size: 38)
            
        } catch {
            print("errosito")
        }
        
        setStyle()
    }
    
    func setStyle() {
        quoteInsuranceTopButton.layer.cornerRadius = 20
        quoteInsuranceBottomButton.layer.cornerRadius = 20
        
        typeInsuranceSegmentedControl.backgroundColor = .white
        typeInsuranceSegmentedControl.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        
        let titleSelected = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let titleUnselected = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        typeInsuranceSegmentedControl.setTitleTextAttributes(titleUnselected, for: .normal)
        typeInsuranceSegmentedControl.setTitleTextAttributes(titleSelected, for: .selected)
        
        typeInsuranceSegmentedControl.layer.borderColor = UIColor.lightGray.cgColor
        typeInsuranceSegmentedControl.layer.borderWidth = 1
        
        
        UIFont.familyNames.forEach ({ name in
            for font_name in UIFont.fontNames(forFamilyName: name) {
                print("\n \(font_name)")
            }
        })
        
    }
    
}
