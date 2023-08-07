//
//  ProductDetailInfoCell.swift
//  CodeChallenge
//
//  Created by personal on 16.07.2022.
//

import UIKit

class ProductDetailInfoCell: UITableViewCell {

    var selection: () -> Void = { }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addressButton: UIButton!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var visitorsButton: UIButton!
    
    func bind(title: String?, price: ProductPrice?, address: ProductAddress?, date: Date?, visits: Int?, productID: String, selection: @escaping () -> Void) {
        self.selection = selection
        
        titleLabel.text = title
        
        if let amount = price?.amount.toPriceString() {
            let currency = price?.currency?.toCurrencySymbol() ?? ""
            priceLabel.text = "\(amount)" + currency
        } else {
            priceLabel.text = nil
        }
        
        if let address = address {
            let addressText = address.street + ", " + (address.zipCode ?? "") + " " + address.city
            addressButton.setTitle(addressText, for: .normal)
        } else {
            addressButton.setTitle("", for: .normal)
        }
        
        idLabel.text = "ID:" + productID
        
        let dateString = date?.getDateString()
        dateButton.setTitle(dateString, for: .normal)
        
        let visitsString: String? = visits != nil ? "\(visits!)" : nil
        visitorsButton.setTitle(visitsString, for: .normal)
    }
    
    @IBAction func addressSelected(_ sender: Any) {
        selection()
    }
}
