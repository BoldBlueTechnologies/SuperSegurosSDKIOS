//
//  selectPickerViewController.swift
//  SuperSegurosSDKIOS
//
//  Created by Oscar Aguilar on 13/11/24.
//

import UIKit

class selectPickerViewController: stylesViewController {
    
    public static let reusableCell = UINib(nibName: "itemPickerTableViewCell", bundle: Bundle.module)

    var step: Int = 0
    var delegate: selectBrandProtocol?

    var vehicle: [TipoVehiculo]? {
        didSet {
            filteredVehicle = vehicle
            pickersTableView.reloadData()
        }
    }
    var model: [Modelo]? {
        didSet {
            filteredModel = model
            pickersTableView.reloadData()
        }
    }
    var brand: [Marcas]? {
        didSet {
            filteredBrand = brand
            pickersTableView.reloadData()
        }
    }
    var subBrand: [SubMarcas]? {
        didSet {
            filteredSubBrand = subBrand
            pickersTableView.reloadData()
        }
    }
    var version: [Version]? {
        didSet {
            filteredVersion = version
            pickersTableView.reloadData()
        }
    }

    // Arrays filtrados
    var filteredVehicle: [TipoVehiculo]?
    var filteredModel: [Modelo]?
    var filteredBrand: [Marcas]?
    var filteredSubBrand: [SubMarcas]?
    var filteredVersion: [Version]?

    var vehicleType:Int = 0
    var modelSelected:Int = 0
    var brandSelected:Int = 0
    var subBrandSelected:Int = 0

    @IBOutlet weak var itemSearchBar: UISearchBar!
 
    @IBOutlet weak var pickersTableView: UITableView!
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

        itemSearchBar.delegate = self
        itemSearchBar.showsCancelButton = true
        
      
        self.showProgressHUD(title: "Cargando")
        
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
            self.dismissProgressHUD()
            
            self.pickersTableView.isHidden = false
            
            if success {
                self.vehicle = pickersData
            }
        }
    }
    
    func getModel(vehicleType:Int){
        NetworkDataRequest.getModel(vehicleType: vehicleType) { success, message, pickersData in
            self.dismissProgressHUD()
            
            self.pickersTableView.isHidden = false
            
            if success {
                self.model = pickersData
            }
        }
    }
    
    
    func getBrand(vehicleType:Int, model:Int){
        NetworkDataRequest.getBrand(vehicleType: vehicleType, model: model) { success, message, pickersData in
            self.dismissProgressHUD()
            
            self.pickersTableView.isHidden = false
            
            if success {
                self.brand = pickersData
            }
        }
    }
    
    
    
    func getSubBrand(vehicleType:Int, model:Int, brand:Int){
        NetworkDataRequest.getSubBrand(vehicleType: vehicleType, model: model, brand: brand) { success, message, pickersData in
            self.dismissProgressHUD()
            
            self.pickersTableView.isHidden = false
            
            if success {
                self.subBrand = pickersData
            }
        }
    }
    
    func getVersion(vehicleType:Int, model:Int, brand:Int, subBrand:Int){
        NetworkDataRequest.getVersion(vehicleType: vehicleType, model: model, brand: brand, subBrand: subBrand) { success, message, pickersData in
            self.dismissProgressHUD()
            
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
            return filteredVehicle?.count ?? 0
        case 2:
            return filteredModel?.count ?? 0
        case 3:
            return filteredBrand?.count ?? 0
        case 4:
            return filteredSubBrand?.count ?? 0
        case 5:
            return filteredVersion?.count ?? 0
        default:
            return 0
        }
      
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pickersTableView.dequeueReusableCell(withIdentifier: "itemPickerTableViewCell", for: indexPath) as! itemPickerTableViewCell
        
        switch self.step {
        case 1:
            cell.nameLabel.text = filteredVehicle?[indexPath.row].descripcion
        case 2:
            if let modelos = self.filteredModel {
                cell.nameLabel.text = String(modelos[indexPath.row].modelo)
            }
        case 3:
            if let marcas = self.filteredBrand {
                cell.nameLabel.text = marcas[indexPath.row].marca
            }
        case 4:
            if let subMarca = self.filteredSubBrand {
                cell.nameLabel.text = subMarca[indexPath.row].subMarca
            }
        case 5:
            if let version = self.filteredVersion {
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
                if let vehicle = self.filteredVehicle {
                    self.delegate?.selectType(type: vehicle[indexPath.row])
                }
            case 2:
                if let modelos = self.filteredModel {
                    let modeloItem = modelos[indexPath.row]
                    self.delegate?.selectYear(year: modeloItem)
                }
            case 3:
                if let marcas = self.filteredBrand {
                    let brandItem = marcas[indexPath.row]
                    self.delegate?.selectBrand(brand: brandItem)
                }
            case 4:
                if let subMarcas = self.filteredSubBrand {
                    let brandItem = subMarcas[indexPath.row]
                    self.delegate?.selectModel(model: brandItem)
                }
            case 5:
                if let version = self.filteredVersion {
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

extension selectPickerViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Dependiendo del step filtramos la lista correspondiente
        let text = searchText.lowercased()
        
        switch self.step {
        case 1:
            if let vehicle = self.vehicle {
                filteredVehicle = text.isEmpty ? vehicle : vehicle.filter { $0.descripcion.lowercased().contains(text) }
            }
        case 2:
            if let model = self.model {
                filteredModel = text.isEmpty ? model : model.filter { String($0.modelo).contains(text) }
            }
        case 3:
            if let brand = self.brand {
                filteredBrand = text.isEmpty ? brand : brand.filter { $0.marca.lowercased().contains(text) }
            }
        case 4:
            if let subBrand = self.subBrand {
                filteredSubBrand = text.isEmpty ? subBrand : subBrand.filter { $0.subMarca.lowercased().contains(text) }
            }
        case 5:
            if let version = self.version {
                filteredVersion = text.isEmpty ? version : version.filter { $0.descripcion.lowercased().contains(text) }
            }
        default:
            break
        }
        self.pickersTableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
        // Restauramos la lista original al cancelar
        switch self.step {
        case 1:
            filteredVehicle = vehicle
        case 2:
            filteredModel = model
        case 3:
            filteredBrand = brand
        case 4:
            filteredSubBrand = subBrand
        case 5:
            filteredVersion = version
        default:
            break
        }
        
        self.pickersTableView.reloadData()
    }
}
