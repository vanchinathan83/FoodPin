//
//  RestaurantTableViewCell.swift
//  FoodPin
//
//  Created by Vanchinathan AC on 3/24/23.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel:UILabel!
    @IBOutlet var locationLabel:UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var thumbnailViewImage: UIImageView! {
        didSet {
            thumbnailViewImage.layer.cornerRadius = 20
            thumbnailViewImage.clipsToBounds = true
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.tintColor = .systemBlue
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
