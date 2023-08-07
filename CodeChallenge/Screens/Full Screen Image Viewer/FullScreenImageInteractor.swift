//
//  FullScreenImageInteractor.swift
//  CodeChallenge
//
//  Created by personal on 19.07.2022.
//

import UIKit

protocol FullScreenImageBusinessLogic {
    func getImage()
}

protocol FullScreenImageDataStore {
    var image: String? { get set }
}

class FullScreenImageInteractor: FullScreenImageBusinessLogic, FullScreenImageDataStore {
    var presenter: FullScreenImagePresentationLogic?
    var image: String?

    func getImage() {
        presenter?.presentFullScreenImage(image: image!)
    }
}
