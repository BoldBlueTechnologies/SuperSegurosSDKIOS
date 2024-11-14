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
    
    var items: [String] = [] {
        didSet{
            pickersTableView.reloadData()
        }
    }

    @IBOutlet weak var itemSearchBar: UISearchBar!
    @IBOutlet weak var pickersTableView: UITableView!
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

        NetworkDataRequest.getPickersCatalog(env: "development") { success, message, pickersData in
            if success {
                switch self.step {
                    case 1:
                        self.items = pickersData?.alcoholFrequencyCatalog ?? []
                    case 2:
                        self.items = pickersData?.alcoholMillilitersCatalog ?? []
                    case 3:
                        self.items = pickersData?.alcoholFrequencyCatalog ?? []
                    case 4:
                        self.items = pickersData?.alcoholTypeCatalog ?? []
                    default:
                        print("default")
                }
            }
        }
        
        pickersTableView.register(selectPickerViewController.reusableCell, forCellReuseIdentifier: "itemPickerTableViewCell")
        pickersTableView.dataSource = self
        pickersTableView.delegate = self
    }

}
extension selectPickerViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pickersTableView.dequeueReusableCell(withIdentifier: "itemPickerTableViewCell", for: indexPath) as! itemPickerTableViewCell
        cell.nameLabel.text = items[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        self.dismiss(animated: true, completion: {
            switch self.step {
                case 1:
                    self.delegate?.selectBrand(brand: self.items[indexPath.row])
                case 2:
                    self.delegate?.selectYear(year: self.items[indexPath.row])
                case 3:
                    self.delegate?.selectModel(model: self.items[indexPath.row])
                case 4:
                    self.delegate?.selectVersion(version: self.items[indexPath.row])
                default:
                    print("default")
            }
        })
    
        print("Selected........")
        print(indexPath.row)
    }
    
}
