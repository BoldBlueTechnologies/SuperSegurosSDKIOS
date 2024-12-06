//
//  itemPickerTableViewCell.swift
//  SuperSegurosSDKIOS
//
//  Created by Oscar Aguilar on 13/11/24.
//

import UIKit

public class itemPickerTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.nameLabel.font = UIFont.poppinsRegular(size: 17)
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        /*let heartImage = UIImage(systemName: "circle")*/ //empty //circle.inset.filled complete
        
        
    }
    
}
