//
//  ProductDetailGalleryCVCell.swift
//  CodeChallenge
//
//  Created by personal on 16.07.2022.
//

import UIKit
import Kingfisher

class ProductDetailGalleryCVCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    func bind(image: String) {
        let imageWithSize = image.replacingOccurrences(of: "{imageId}", with: "1")
        if let imageURL = URL(string: imageWithSize) {
            imageView.kf.setImage(with: imageURL)
        } else {
            imageView.image = nil
        }
    }
}
