//
//  insuranceTableViewCell.swift
//  SuperSegurosSDKIOS
//
//  Created by Oscar Aguilar on 14/11/24.
//

import UIKit

public class emptyInsuranceTableViewCell: UITableViewCell {

    var delegate: insuranceProtocol?
    @IBOutlet weak var backGroundView: UIView!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func cotizarAction(_ sender: Any) {
        Task { @MainActor in
            
            await delegate?.newQuotation()
        }
    }
}
