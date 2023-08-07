//
//  ProductData.swift
//  CodeChallenge
//
//  Created by personal on 16.07.2022.
//

import Foundation

struct Product: Codable {
    let id: String
    let title: String?
    let price: ProductPrice?
    let visits: Int?
    let address: ProductAddress?
    let postedDateTime: Date?
    let description: String?
    let attributes: [ProductAttribute]?
    let features: [String]?
    let pictures: [String]?
    let documents: [ProductDocument]?
    
    enum CodingKeys : String, CodingKey {
        case id,
             title,
             price,
             visits,
             address,
             postedDateTime = "posted-date-time",
             description,
             attributes,
             features,
             pictures,
             documents
    }
}

struct ProductPrice: Codable {
    let currency: String?
    let amount: Int
}

struct ProductAddress: Codable {
    let street: String
    let city: String
    let zipCode: String?
    let latitude: String?
    let longitude: String?
    
    enum CodingKeys : String, CodingKey {
        case street, city, zipCode = "zip-code", latitude, longitude
    }
}

struct ProductAttribute: Codable {
    let label: String
    let value: String
    let unit: String?
}

struct ProductDocument: Codable {
    let link: URL
    let title: String
}
