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
    var useTypeDelegate: selectUseProtocol?
    var addressDelegate: selectAddressProtocol?

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
    
    var vehicleType:Int = 0
    

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
            self.getVehicle()
        case 2:
            self.getModel(vehicleType: self.vehicleType)
        default:
            print("default")
        }

        pickersTableView.register(selectPickerViewController.reusableCell, forCellReuseIdentifier: "itemPickerTableViewCell")
        pickersTableView.dataSource = self
        pickersTableView.delegate = self
    }
    
    
    func getVehicle(){
        NetworkDataRequest.getVehicle(env: "development") { success, message, pickersData in
            self.progress.stopAnimating()
            self.progress.isHidden = true
            
            self.pickersTableView.isHidden = false
            
            if success {
                self.vehicle = pickersData
            }
        }
    }
    
    func getModel(vehicleType:Int){
        NetworkDataRequest.getModel(env: "development", vehicleType: vehicleType) { success, message, pickersData in
            self.progress.stopAnimating()
            self.progress.isHidden = true
            
            self.pickersTableView.isHidden = false
            
            if success {
                self.model = pickersData
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
                    self.delegate?.selectYear(year: String(modeloItem.modelo))
                }
                 
                default:
                    print("default")
            }
        })
    
        print("Selected........")
        print(indexPath.row)
    }
    
}
