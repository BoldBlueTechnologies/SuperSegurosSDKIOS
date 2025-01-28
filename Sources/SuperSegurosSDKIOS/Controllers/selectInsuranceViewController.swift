//
//  selectInsuranceViewController.swift
//  SuperSegurosSDKIOS
//
//  Created by Oscar Aguilar on 14/11/24.
//


import UIKit
import SkeletonView

protocol insuranceProtocol {
    
    func newQuotation() async
}

class selectInsuranceViewController: stylesViewController, insuranceProtocol {
    
    
   

    let colorSkeleton = UIColor(red: 191/255, green: 148/255, blue: 252/255, alpha: 1)
    let colorBase = UIColor(red: 0.75, green: 0.58, blue: 0.99, alpha: 1.0)
    let colorClaro = UIColor(red: 0.85, green: 0.73, blue: 1.0, alpha: 1.0)
    
    var skeletonAvailable = true
    
    public static let reusableCell = UINib(nibName: "insuranceTableViewCell", bundle: Bundle.module)
    public static let emptyreusableCell = UINib(nibName: "emptyInsuranceTableViewCell", bundle: Bundle.module)
    
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
    
    var carQuoteId:Int?
    var vehicleType: TipoVehiculo?
    var modelSelected: Modelo?
    var brandSelected: Marcas?
    var subBrandSelected: SubMarcas?
    var versionSelected: Version?
    var postalCode: String?
    
    @IBOutlet weak var emptyInsuranceView: UIView!
    @IBOutlet weak var newQuoterButton: UIButton!
    @IBOutlet weak var selectInsuranceTitle: UILabel!
    @IBOutlet weak var insuranceTableView: UITableView!
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func newQuotation() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        insuranceTableView.register(selectInsuranceViewController.reusableCell, forCellReuseIdentifier: "insuranceTableViewCell")
        insuranceTableView.register(selectInsuranceViewController.emptyreusableCell, forCellReuseIdentifier: "emptyInsuranceTableViewCell")
        
        insuranceTableView.dataSource = self
        insuranceTableView.delegate = self
        
        setStyle()
        
       
        self.getBaseQuotation(
            vehicleType: self.vehicleType?.tipoVehiculoBase ?? 0,
            model: self.modelSelected?.modelo ?? 0,
            brand: self.brandSelected?.id ?? 0,
            subBrand: self.subBrandSelected?.id ?? 0,
            internalKey: self.versionSelected?.id ?? ""
        )
    }
    
    func getBaseQuotation(vehicleType: Int, model: Int, brand: Int, subBrand: Int, internalKey: String) {
        NetworkDataRequest.getBasicQuotation(
            vehicleType: vehicleType,
            model: model,
            brand: brand,
            subBrand: subBrand,
            internalKey: internalKey,
            zipCode: postalCode ?? ""
        ) { success, message, pickersData in
            
            self.skeletonAvailable = false
         
            if success, let data = pickersData, !data.isEmpty {
                self.basicQ = data
            } else {
       
                self.basicQ = nil
            }
        }
    }
    
    
    
    func setStyle() {
        emptyInsuranceView.layer.cornerRadius = 10
        newQuoterButton.layer.cornerRadius = 10
    }
    
    
    
}

// MARK: - UITableViewDataSource & UITableViewDelegate



extension selectInsuranceViewController: UITableViewDataSource, UITableViewDelegate {
    
   
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if skeletonAvailable {
      
            return 1
        }
        
      
        guard let basicQ = basicQ, !basicQ.isEmpty else {
            return 1
        }
        
      
        return basicQ.count
    }
    
   
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

     
        if skeletonAvailable {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "insuranceTableViewCell",
                for: indexPath
            ) as! insuranceTableViewCell
            
            cell.backGroundView.isSkeletonable = true
            let gradient = SkeletonGradient(colors: [colorClaro, colorBase, colorClaro])
            let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
            cell.backGroundView.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
            cell.backGroundView.layer.cornerRadius = 20
            cell.backGroundView.clipsToBounds = true
            cell.selectionStyle = .none
            return cell
        }
        
        guard let basicQ = basicQ, !basicQ.isEmpty else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "emptyInsuranceTableViewCell",
                for: indexPath
            ) as! emptyInsuranceTableViewCell
            
            cell.delegate = self
           
            cell.selectionStyle = .none
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "insuranceTableViewCell",
            for: indexPath
        ) as! insuranceTableViewCell
        
       
        cell.backGroundView.hideSkeleton()
        
   
        let insurance = basicQ[indexPath.row]
        cell.lblAmount.text = "$ \(insurance.monto)"
        
             
        cell.imgInsurance.image = UIImage.moduleImage(named: insurance.aseguradora)
        
        cell.backGroundView.layer.cornerRadius = 20
        cell.backGroundView.clipsToBounds = true
        cell.selectionStyle = .none
        
        return cell
    }
    
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

      
        guard let basicQ = basicQ, !basicQ.isEmpty else {
            return
        }
        
        PayQuotationData.shared.brand = self.brandSelected?.marca
        PayQuotationData.shared.model =  self.subBrandSelected?.subMarca
        PayQuotationData.shared.year =  String(self.modelSelected?.modelo ?? 0)
        PayQuotationData.shared.version = self.versionSelected?.descripcion
        
        
        let insurance = basicQ[indexPath.row]
        let coberturaVC = CoverageViewController()
        coberturaVC.modalPresentationStyle = .popover
        coberturaVC.insurance = insurance
        coberturaVC.carQuoteId = self.carQuoteId
        coberturaVC.brandSelected = self.brandSelected
        coberturaVC.vehicleType = self.vehicleType
        coberturaVC.modelSelected = self.modelSelected
        coberturaVC.subBrandSelected = self.subBrandSelected
        coberturaVC.versionSelected = self.versionSelected
        coberturaVC.postalCode = self.postalCode
        coberturaVC.isModalInPresentation = true
        self.present(UINavigationController(rootViewController: coberturaVC), animated: true, completion: nil)
    }
}
