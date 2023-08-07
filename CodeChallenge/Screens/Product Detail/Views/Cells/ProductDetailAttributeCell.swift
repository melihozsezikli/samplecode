//
//  ProductDetailAttributeCell.swift
//  CodeChallenge
//
//  Created by personal on 17.07.2022.
//

import UIKit

class ProductDetailAttributeCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    func bind(attribute: ProductAttribute) {
        titleLabel.text = attribute.label
        valueLabel.text = attribute.value + (attribute.unit ?? "")
    }
    
}
