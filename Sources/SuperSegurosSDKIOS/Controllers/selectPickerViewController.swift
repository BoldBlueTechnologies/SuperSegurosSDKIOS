//
//  selectPickerViewController.swift
//  SuperSegurosSDKIOS
//
//  Created by Oscar Aguilar on 13/11/24.
//

import UIKit

class selectPickerViewController: UIViewController {

    public static let reusableCell = UINib(nibName: "itemPickerTableViewCell", bundle: Bundle.module)

    var items: [String] =  ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"]

    @IBOutlet weak var itemSearchBar: UISearchBar!
    @IBOutlet weak var pickersTableView: UITableView!
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

        
        NetworkManeger.getPickersCatalog(env: "development") { success, message, pickersData in
            print("-----------------")
            print(message)
            print("-----------------")
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}
