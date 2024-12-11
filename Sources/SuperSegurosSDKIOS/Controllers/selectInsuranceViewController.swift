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
        didSet {
            insuranceTableView.reloadData()
        }
    }
    
    var basicQ: [BasicQuotation]? {
        didSet {
            insuranceTableView.reloadData()
        }
    }
    
    var vehicleType:Int = 0
    var modelSelected:Int = 0
    var brandSelected:Int = 0
    var subBrandSelected:Int = 0
    var internalKey:String = ""
    
    @IBOutlet weak var emptyInsuranceView: UIView!
    @IBOutlet weak var newQuoterButton: UIButton!
    @IBOutlet weak var selectInsuranceTitle: UILabel!
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
        
        setStyle()
        
        self.getBaseQuotation(vehicleType: self.vehicleType, model: self.modelSelected, brand: self.brandSelected, subBrand: self.subBrandSelected, internalKey: self.internalKey)
       
        
        //para probar q no ahi nada
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            self.skeletonAvailable = false
//            
//            self.insuranceTableView.reloadData()
//        }
        
    }
    
    func getBaseQuotation(vehicleType:Int, model:Int, brand:Int, subBrand:Int, internalKey:String) {
        
        
        NetworkDataRequest.getBasicQuotation(vehicleType: vehicleType, model: model, brand: brand, subBrand: subBrand, internalKey: internalKey) { success, message, pickersData in
           
            self.skeletonAvailable = false
            if success {
                self.basicQ = pickersData
            }
        }
        
    }
    
    func setStyle() {
        emptyInsuranceView.layer.cornerRadius = 10
        newQuoterButton.layer.cornerRadius = 10
    }
    
}
extension selectInsuranceViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if skeletonAvailable {
            return 1
        } else if basicQ?.count == 0 {
            emptyInsuranceView.isHidden = false
            selectInsuranceTitle.isHidden = true
            tableView.isHidden = true
            return 0
        } else {
            return basicQ?.count ?? 00
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
            if let insurance = basicQ?[indexPath.row] {
                cell.lblAmount.text = insurance.monto
                
                let url = URL(string: "\(NetworkDataRequest.environment.URL_PHOTOS)\(insurance.imagen)")!
                UIImage.loadFrom(url: url) { image in
                    cell.imgInsurance.image = image
                }
            }
   
           
        }
        
        cell.backGroundView.layer.cornerRadius = 20
        cell.backGroundView.clipsToBounds = true
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let coberturaVC = CoverageViewController()
        coberturaVC.modalPresentationStyle = .popover
        coberturaVC.isModalInPresentation = true
        self.present(UINavigationController(rootViewController: coberturaVC), animated: true, completion: nil)
        
    }
        
    
}
