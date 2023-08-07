//
//  ProductDetailRequest.swift
//  CodeChallenge
//
//  Created by personal on 16.07.2022.
//

import Foundation

class ProductDetailRequest: ApiRequest<Product> {
    
    var productID: String = ""
    
    required init(productID: String) {
        super.init()
        self.productID = productID
    }
    
    override func endPoint() -> String {
        return "ads"
    }

    override func path() -> String {
        return "/\(productID)"
    }

}
