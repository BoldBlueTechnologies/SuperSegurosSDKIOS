//
//  selectInsuranceViewController.swift
//  SuperSegurosSDKIOS
//
//  Created by Oscar Aguilar on 14/11/24.
//

import UIKit
import SkeletonView

class selectInsuranceViewController: UIViewController {

    let colorSkeleton = UIColor(red: 191/255, green: 148/255, blue: 252/255, alpha: 1)
    
    let colorBase = UIColor(red: 0.75, green: 0.58, blue: 0.99, alpha: 1.0)
    let colorClaro = UIColor(red: 0.85, green: 0.73, blue: 1.0, alpha: 1.0)
    
    var skeletonAvailable = true
    
    public static let reusableCell = UINib(nibName: "insuranceTableViewCell", bundle: Bundle.module)
    
    var items: [String] = [] {
        didSet{
            print("RELOAD")
            print(skeletonAvailable)
            print("------")
            
            insuranceTableView.reloadData()
        }
    }
    
    @IBOutlet weak var insuranceTableView: UITableView!
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

        insuranceTableView.register(selectInsuranceViewController.reusableCell, forCellReuseIdentifier: "insuranceTableViewCell")
        insuranceTableView.dataSource = self
        insuranceTableView.delegate = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            print("EJECUTANDO.......")
            self.skeletonAvailable = false
            self.items.append("ahora si ahi uno")
        }
        
    }

}
extension selectInsuranceViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if items.count == 0 {
            return 1
        
        } else {
            return items.count
        }
       
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = insuranceTableView.dequeueReusableCell(withIdentifier: "insuranceTableViewCell", for: indexPath) as! insuranceTableViewCell

        if skeletonAvailable {
            cell.backGroundView.isSkeletonable = skeletonAvailable
            
            let gradient = SkeletonGradient(colors: [colorClaro, colorBase, colorClaro])
            let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
            
            cell.backGroundView.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
        } else {
            cell.backGroundView.hideSkeleton()
        }
        
        cell.backGroundView.layer.cornerRadius = 20
        cell.backGroundView.clipsToBounds = true
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected........")
        print(indexPath.row)
    }
    
}
