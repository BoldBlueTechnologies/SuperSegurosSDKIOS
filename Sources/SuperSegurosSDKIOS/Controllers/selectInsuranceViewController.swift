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
    
    public static let reusableCell = UINib(nibName: "insuranceTableViewCell", bundle: Bundle.module)
    
    var items: [String] = ["empty"] {
        didSet{
            insuranceTableView.reloadData()
        }
    }
    
    @IBOutlet weak var insuranceTableView: UITableView!
    
    @IBAction func backAction(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

        insuranceTableView.register(selectInsuranceViewController.reusableCell, forCellReuseIdentifier: "insuranceTableViewCell")
        insuranceTableView.dataSource = self
        insuranceTableView.delegate = self
    }

}
extension selectInsuranceViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = insuranceTableView.dequeueReusableCell(withIdentifier: "insuranceTableViewCell", for: indexPath) as! insuranceTableViewCell
//        cell.backGroundView.layer.cornerRadius = 20
        cell.backGroundView.isSkeletonable = true
        cell.backGroundView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .skeletonDefault), animation: nil, transition: .crossDissolve(0.5))
        cell.backGroundView.layer.cornerRadius = 20
        cell.selectionStyle = .none
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected........")
        print(indexPath.row)
    }
    
}
