//
//  selectPickerViewController.swift
//  SuperSegurosSDKIOS
//
//  Created by Oscar Aguilar on 13/11/24.
//

import UIKit

class selectPickerViewController: UIViewController {
    
    public static let reusableCell = UINib(nibName: "itemPickerTableViewCell", bundle: Bundle.module)

    var step: Int = 0
    var delegate: selectBrandProtocol?
  //  var addressDelegate: selectAddressProtocol?

    var vehicle: [TipoVehiculo]? {
        didSet {
            pickersTableView.reloadData()
        }
    }
    
    var model: [Modelo]? {
        didSet {
            pickersTableView.reloadData()
        }
    }
    
    var brand: [Marcas]? {
        didSet {
            pickersTableView.reloadData()
        }
    }
    
    var subBrand: [SubMarcas]? {
        didSet {
            pickersTableView.reloadData()
        }
    }
    
    var version: [Version]? {
        didSet {
            pickersTableView.reloadData()
        }
    }
    
    var vehicleType:Int = 0
    var modelSelected:Int = 0
    var brandSelected:Int = 0
    var subBrandSelected:Int = 0

    @IBOutlet weak var itemSearchBar: UISearchBar!
    @IBOutlet weak var progress: UIActivityIndicatorView!
    @IBOutlet weak var pickersTableView: UITableView!
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

        progress.startAnimating()
            
        switch self.step {
        case 1:
            self.title = "Tipo de auto"
            self.getVehicle()
        case 2:
            self.getModel(vehicleType: self.vehicleType)
            self.title = "Selecciona un año"
        case 3:
            self.getBrand(vehicleType: self.vehicleType, model: self.modelSelected)
            self.title = "Selecciona una marca"
        case 4:
            self.getSubBrand(vehicleType: self.vehicleType, model: self.modelSelected, brand: self.brandSelected)
            self.title = "Selecciona un modelo"
        case 5:
            self.getVersion(vehicleType: self.vehicleType, model: self.modelSelected, brand: self.brandSelected, subBrand: self.subBrandSelected)
            self.title = "Selecciona una versión"
        default:
            print("default")
        }

        pickersTableView.register(selectPickerViewController.reusableCell, forCellReuseIdentifier: "itemPickerTableViewCell")
        pickersTableView.dataSource = self
        pickersTableView.delegate = self
    }
    
    
    func getVehicle(){
        NetworkDataRequest.getVehicle() { success, message, pickersData in
            self.progress.stopAnimating()
            self.progress.isHidden = true
            
            self.pickersTableView.isHidden = false
            
            if success {
                self.vehicle = pickersData
            }
        }
    }
    
    func getModel(vehicleType:Int){
        NetworkDataRequest.getModel( vehicleType: vehicleType) { success, message, pickersData in
            self.progress.stopAnimating()
            self.progress.isHidden = true
            
            self.pickersTableView.isHidden = false
            
            if success {
                self.model = pickersData
            }
        }
    }
    
    
    func getBrand(vehicleType:Int, model:Int){
        NetworkDataRequest.getBrand(vehicleType: vehicleType, model: model) { success, message, pickersData in
            self.progress.stopAnimating()
            self.progress.isHidden = true
            
            self.pickersTableView.isHidden = false
            
            if success {
                self.brand = pickersData
            }
        }
    }
    
    
    
    func getSubBrand(vehicleType:Int, model:Int, brand:Int){
        NetworkDataRequest.getSubBrand(vehicleType: vehicleType, model: model, brand: brand) { success, message, pickersData in
            self.progress.stopAnimating()
            self.progress.isHidden = true
            
            self.pickersTableView.isHidden = false
            
            if success {
                self.subBrand = pickersData
            }
        }
    }
    
    func getVersion(vehicleType:Int, model:Int, brand:Int, subBrand:Int){
        NetworkDataRequest.getVersion( vehicleType: vehicleType, model: model, brand: brand, subBrand: subBrand) { success, message, pickersData in
            self.progress.stopAnimating()
            self.progress.isHidden = true
            
            self.pickersTableView.isHidden = false
            
            if success {
                self.version = pickersData
            }
        }
    }

}
extension selectPickerViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.step {
        case 1:
            return vehicle?.count ?? 0
        case 2:
            return model?.count ?? 0
        case 3:
            return brand?.count ?? 0
        case 4:
            return subBrand?.count ?? 0
        case 5:
            return version?.count ?? 0
        default:
            return 0
        }
      
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pickersTableView.dequeueReusableCell(withIdentifier: "itemPickerTableViewCell", for: indexPath) as! itemPickerTableViewCell
        
        switch self.step {
        case 1:
            cell.nameLabel.text = vehicle?[indexPath.row].descripcion
        case 2:
            if let modelos = self.model {
                cell.nameLabel.text = String(modelos[indexPath.row].modelo)
            }
        case 3:
            if let marcas = self.brand {
                cell.nameLabel.text = marcas[indexPath.row].marca
            }
        case 4:
            if let subMarca = self.subBrand {
                cell.nameLabel.text = subMarca[indexPath.row].subMarca
            }
        case 5:
            if let version = self.version {
                cell.nameLabel.text = version[indexPath.row].descripcion
            }
        default:
            print("default")
        }
      
        cell.selectionStyle = .none
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.dismiss(animated: true, completion: {
            switch self.step {
            case 1:
                if let vehicle = self.vehicle {
                    self.delegate?.selectType(type: vehicle[indexPath.row])
                }
            case 2:
                if let modelos = self.model {
                    let modeloItem = modelos[indexPath.row]
                    self.delegate?.selectYear(year: modeloItem)
                }
            case 3:
                if let marcas = self.brand {
                    let brandItem = marcas[indexPath.row]
                    self.delegate?.selectBrand(brand: brandItem)
                }
            case 4:
                if let subMarcas = self.subBrand {
                    let brandItem = subMarcas[indexPath.row]
                    self.delegate?.selectModel(model: brandItem)
                }
            case 5:
                if let version = self.version {
                    let brandItem = version[indexPath.row]
                    self.delegate?.selectVersion(version: brandItem)
                }
                
                
            default:
                print("default")
            }
        })
    
        print("Selected........")
        print(indexPath.row)
    }
    
}
