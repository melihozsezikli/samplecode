//
//  ProductDetailGalleryCell.swift
//  CodeChallenge
//
//  Created by personal on 16.07.2022.
//

import UIKit

class ProductDetailGalleryCell: UITableViewCell {

    var selection: (String) -> Void = {_ in }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var shakeButton: UIButton!
    @IBOutlet weak var indexLabel: UILabel!
    private var images: [String]?
    private var productID: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ProductDetailGalleryCVCell", bundle: nil),
                                forCellWithReuseIdentifier: "ProductDetailGalleryCVCell")
    }
    
    func bind(images: [String], productID: String, selection: @escaping (String) -> Void ) {
        self.selection = selection
        self.images = images
        self.productID = productID
        collectionView.reloadData()
        
        let total = "\(images.count)"
        let currentPage = currentPage(collectionView)
        indexLabel.text = "\(currentPage)" + "/"  + total
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        images = nil
        productID = nil
        collectionView.reloadData()
    }
}

extension ProductDetailGalleryCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductDetailGalleryCVCell", for: indexPath) as! ProductDetailGalleryCVCell
        if let image = images?[indexPath.item] {
            cell.bind(image: image)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let total = "\(images?.count ?? 0)"
        let currentPage = currentPage(scrollView)
        indexLabel.text = "\(currentPage)" + "/"  + total
    }
    
    private func currentPage(_ scrollView: UIScrollView) -> Int {
        let xPoint = scrollView.contentOffset.x + scrollView.frame.width / 2
        let yPoint = scrollView.frame.height / 2
        let center = CGPoint(x: xPoint, y: yPoint)
        if let ip = collectionView.indexPathForItem(at: center) {
            return ip.item + 1
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let image = images?[indexPath.item] else { return }
        selection(image)
    }
}

