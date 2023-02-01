//
//  ListingsTableViewCell.swift
//  TradeMe test
//
//  Created by Gopika Venugopal on 31/01/23.
//

import UIKit

class ListingsTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var reserveLabel: UILabel!
    
    @IBOutlet weak var buyNowLabel: UILabel!
    @IBOutlet weak var buyNowPriceLabel: UILabel!
    @IBOutlet weak var displayPriceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        productImageView.layer.cornerRadius = 10
        productImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
