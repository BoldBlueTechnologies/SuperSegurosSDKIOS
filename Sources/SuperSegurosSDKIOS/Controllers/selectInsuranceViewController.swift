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
    
    let colorBase = UIColor(red: 0.75, green: 0.58, blue: 0.99, alpha: 1.0) // HEX #BF94FC
    let colorClaro = UIColor(red: 0.85, green: 0.73, blue: 1.0, alpha: 1.0) // Más claro
    let colorOscuro = UIColor(red: 0.65, green: 0.43, blue: 0.91, alpha: 1.0) // Más oscuro
    
    
  // Mostramos el gradiente animado view.showAnimatedGradientSkeleton(usingGradient: gradient, animation: nil)
    
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
        
        let gradient = SkeletonGradient(colors: [colorClaro, colorBase, colorClaro])
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
        
        cell.backGroundView.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
        
//        cell.backGroundView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: gradient), animation: nil, transition: .crossDissolve(0.5))
        
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
