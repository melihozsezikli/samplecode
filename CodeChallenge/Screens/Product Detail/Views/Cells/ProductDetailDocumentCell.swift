//
//  ProductDetailDocumentCell.swift
//  CodeChallenge
//
//  Created by personal on 19.07.2022.
//

import UIKit

class ProductDetailDocumentCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    func bind(document: ProductDocument) {
        titleLabel.text = document.title
    }
}
