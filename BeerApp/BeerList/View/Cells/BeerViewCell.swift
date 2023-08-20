//
//  BeerViewCell.swift
//  BeerApp
//
//  Created by Joaquín Corugedo Rodríguez on 17/8/23.
//

import UIKit

final class BeerViewCell: UITableViewCell {

    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var tagLineLabel: UILabel!
    
    func set(model: BeerModel) {
        self.nameLabel.text = model.name
        self.tagLineLabel.text = model.tagline
        self.beerImage.setImage(urlString: model.image_url)
    }
}
