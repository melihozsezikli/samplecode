//
//  ProductDetailModels.swift
//  CodeChallenge
//
//  Created by personal on 16.07.2022.
//

import UIKit

enum ProductDetail
{
    enum SectionType {
        
        case gallery(images: [String], productID: String)
        case info(title: String?, price: ProductPrice?, address: ProductAddress?, date: Date?, visits: Int?, productID: String)
        case details(attributes: [ProductAttribute])
        case features(features: [String])
        case documents(documents: [ProductDocument])
        case description(description: String)
        
        func title() -> String? {
            switch self {
            case .gallery:
                return nil
            case .info:
                return nil
            case .details:
                return "Details"
            case .features:
                return "Ausstattung"
            case .documents:
                return "Weitere Informatione"
            case .description:
                return "Beschreibung"
            }
        }
    }
    
    enum ProductData
    {
        struct Request
        {
            let productID: String
        }

        struct Response
        {
            let product: Product
        }

        struct ViewModel
        {
            let sections: [SectionType]
        }
    }
}
