//
//  ProductDetailInteractor.swift
//  CodeChallenge
//
//  Created by personal on 16.07.2022.
//

import UIKit

protocol ProductDetailBusinessLogic {
    func getProductDetail(request: ProductDetail.ProductData.Request)
    func setSelectedImage(image: String)
    func setSelectedDocument(document: ProductDocument)
    func setSelectedAddress(address: ProductAddress?)
}

protocol ProductDetailDataStore {
    var selectedImage: String? { get set }
    var selectedDocument: ProductDocument? { get set }
    var selectedAddress: ProductAddress? { get set }
}

class ProductDetailInteractor: ProductDetailBusinessLogic, ProductDetailDataStore {
    
    var selectedImage: String?
    var selectedDocument: ProductDocument?
    var selectedAddress: ProductAddress?
    var presenter: ProductDetailPresentationLogic?
    
    func getProductDetail(request: ProductDetail.ProductData.Request) {
        NetworkApiClient().callApi(request: ProductDetailRequest(productID: request.productID)) {[weak self] apiResponse in
            if let product = apiResponse.data as? Product, apiResponse.success {
                let response = ProductDetail.ProductData.Response(product: product)
                self?.presenter?.presentProductData(response: response)
            } else {
                self?.presenter?.presentError(message: apiResponse.message)
            }
        }
    }
    
    func setSelectedImage(image: String) {
        selectedImage = image
    }
    
    func setSelectedDocument(document: ProductDocument) {
        selectedDocument = document
    }
    
    func setSelectedAddress(address: ProductAddress?) {
        selectedAddress = address
    }
}
