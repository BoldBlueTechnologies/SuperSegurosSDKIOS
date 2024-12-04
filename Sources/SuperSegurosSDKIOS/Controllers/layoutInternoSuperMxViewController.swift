//
//  layoutInternoSuperMxViewController.swift
//  midoconlineapp
//
//  Created by Christian Martinez on 10/01/24.
//

import UIKit


class layoutInternoSuperMxViewController: stylesViewController {

    @IBOutlet weak var stackSchedule: UIStackView!
    @IBOutlet weak var viewcard: UIView!
    
    @IBOutlet weak var viewInfo: UIView!
    
    var optionIndex: Int = 0

    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewInfo.applyRoundedStyle()
        self.setData()
    }

    func setData(index: Int = 0) {

    
        let segmentedViewController = SegmentedViewController()
        segmentedViewController.selectedIndex = index
        segmentedViewController.segmentControlHeight = 30.0

        let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle.module)

        let policyVC = storyboard.instantiateViewController(withIdentifier: "internoPolicy") as! internoPolicySuperMxViewController
        policyVC.title = "Póliza"

        let policyInfoVC = storyboard.instantiateViewController(withIdentifier: "internoPolicyInfo") as! internoPolicyInfoViewController
        policyInfoVC.title = "Información"

      
        let segmentControllers: [UIViewController] = [
            policyVC,
            policyInfoVC
        ]

        segmentedViewController.viewControllers = segmentControllers

        // Configurar colores y estilos del CustomSegmentedControl
   //    segmentedViewController.segmentedControl.textColor = UIColor.black
     //   segmentedViewController.segmentedControl.selectedTextColor = UIColor.black
     //   segmentedViewController.segmentedControl.selectorLineColor = UIColor.moduleColor(named: "mainSuper") ?? UIColor.blue

   
        addChild(segmentedViewController)
        self.view.addSubview(segmentedViewController.view)

        
        segmentedViewController.view.frame = CGRect(x: 0, y: 410, width: self.view.bounds.width, height: self.view.frame.height - 410)
        segmentedViewController.didMove(toParent: self)
    }

    func updateClinicalProfile(Index: Int) {
        self.setData(index: Index)
    }
}
