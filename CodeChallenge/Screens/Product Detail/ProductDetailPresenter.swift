//
//  ProductDetailPresenter.swift
//  CodeChallenge
//
//  Created by personal on 16.07.2022.
//

import UIKit

protocol ProductDetailPresentationLogic {
    func presentProductData(response: ProductDetail.ProductData.Response)
    func presentError(message: String)
}

class ProductDetailPresenter: ProductDetailPresentationLogic {
    typealias SectionType = ProductDetail.SectionType
    
    weak var viewController: ProductDetailDisplayLogic?

    func presentProductData(response: ProductDetail.ProductData.Response) {
        let sections = generateSections(product: response.product)
        let viewModel = ProductDetail.ProductData.ViewModel(sections: sections)
        viewController?.displayProductDetail(viewModel: viewModel)
    }

    private func generateSections(product: Product) -> [SectionType] {
        var sections = [SectionType]()
        
        if let images = product.pictures {
            let gallerySection: SectionType = .gallery(images: images,
                                                       productID: product.id)
            sections.append(gallerySection)
        }
        
        let infoSection: SectionType = .info(title: product.title,
                                             price: product.price,
                                             address: product.address,
                                             date: product.postedDateTime,
                                             visits: product.visits,
                                             productID: product.id)
        sections.append(infoSection)
        
        if let attributes = product.attributes {
            let detailsSection: SectionType = .details(attributes: attributes)
            sections.append(detailsSection)
        }
        
        if let features = product.features {
            let featuresSection: SectionType = .features(features: features)
            sections.append(featuresSection)
        }
        
        if let documents = product.documents {
            let documentsSection: SectionType = .documents(documents: documents)
            sections.append(documentsSection)
        }
        
        if let description = product.description {
            let descriptionSection: SectionType = .description(description: description)
            sections.append(descriptionSection)
        }
        
        return sections
    }
    
    func presentError(message: String) {
        viewController?.displayError(message: message)
    }
    
}
