//
//  CategoryTableViewCell.swift
//  Heroes
//
//  Created by Anggi Putra Gomis on 01/03/21.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.layer.cornerRadius = 8
        titleLabel.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
