//
//  ProductDetailFeatureCell.swift
//  CodeChallenge
//
//  Created by personal on 19.07.2022.
//

import UIKit

class ProductDetailFeatureCell: UITableViewCell {

    @IBOutlet weak var firstFeatureView: UIView!
    @IBOutlet weak var secondFeatureView: UIView!
    @IBOutlet weak var firstFeatureLabel: UILabel!
    @IBOutlet weak var secondFeatureLabel: UILabel!
    
    func bind(features: [String]) {
        if let firstFeature = features.first {
            firstFeatureView.isHidden = false
            firstFeatureLabel.text = firstFeature
        } else {
            firstFeatureView.isHidden = true
        }
        
        if features.count > 1 {
            let secondFeature = features[1]
            secondFeatureView.isHidden = false
            secondFeatureLabel.text = secondFeature
        } else {
            secondFeatureView.isHidden = true
        }
    }
}
