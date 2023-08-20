//
//  DetailViewController.swift
//  BeerApp
//
//  Created by Joaquín Corugedo Rodríguez on 20/8/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!    
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var tipsLabel: UILabel!
    
    private var model: BeerModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let model = model else   {
            return
        }
        
        self.nameLabel.text = model.name
        self.descriptionLabel.text = model.description
        self.beerImage.setImage(urlString: model.image_url)
        
        self.taglineLabel.text = model.tagline
        self.tipsLabel.text = model.brewers_tips
    }

    func set(model: BeerModel) {
        self.model = model
    }

}
