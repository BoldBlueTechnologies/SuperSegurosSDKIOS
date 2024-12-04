//
//  internoPolicyInfoViewController.swift
//  midoconlineapp
//
//  Created by Christian Martinez on 11/01/24.
//

import UIKit

class internoPolicyInfoViewController: stylesViewController {

    @IBOutlet weak var stackInfoExtra: UIStackView!
    @IBOutlet weak var stackInfo: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setStyle()
    }
    
    
    func setStyle() {
        
        
        self.stackInfo.applyCustomBorderStyle()
        self.stackInfoExtra.applyCustomBorderStyle()
      
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
