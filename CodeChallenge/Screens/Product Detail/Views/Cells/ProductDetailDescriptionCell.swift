//
//  ProductDetailDescriptionCell.swift
//  CodeChallenge
//
//  Created by personal on 19.07.2022.
//

import UIKit

class ProductDetailDescriptionCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func bind(description: String) {
        descriptionLabel.text = description
    }
}
