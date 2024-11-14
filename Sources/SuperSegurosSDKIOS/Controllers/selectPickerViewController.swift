//
//  selectPickerViewController.swift
//  SuperSegurosSDKIOS
//
//  Created by Oscar Aguilar on 13/11/24.
//

import UIKit

class selectPickerViewController: UIViewController {
    
    public static let reusableCell = UINib(nibName: "itemPickerTableViewCell", bundle: Bundle.module)

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
                self.items = pickersData?.alcoholFrequencyCatalog ?? []
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
    
    private func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) async {
    
        await self.delegate?.selectBrand(brand: items[indexPath.row])
        
        print("Selected........")
        print(indexPath.row)
    }
    
}
