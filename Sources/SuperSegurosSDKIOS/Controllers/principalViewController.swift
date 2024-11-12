//
//  principalViewController.swift
//  SuperSegurosSDKIOS
//
//  Created by Oscar Aguilar on 12/11/24.
//

import UIKit

public class principalViewController: UIViewController {

    public static let principalVC = UIStoryboard(name: "Storyboard", bundle: Bundle.module).instantiateInitialViewController()!
    
    @IBOutlet weak var quoteInsuranceTopButton: UIButton!
    @IBOutlet weak var quoteInsuranceBottomButton: UIButton!
    @IBOutlet weak var typeInsuranceSegmentedControl: UISegmentedControl!
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func quoteInsuranceAction(_ sender: Any) {
        print("READY......")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

        setStyle()
    }
    
    func setStyle() {
        quoteInsuranceTopButton.layer.cornerRadius = 20
        quoteInsuranceBottomButton.layer.cornerRadius = 20
        
        typeInsuranceSegmentedControl.backgroundColor = .white
        typeInsuranceSegmentedControl.layer.borderColor = UIColor.lightGray.cgColor
        if #available(iOS 13.0, *) {
            typeInsuranceSegmentedControl.selectedSegmentTintColor = .white
        }
        typeInsuranceSegmentedControl.layer.borderWidth = 1
        
    }
    
}
