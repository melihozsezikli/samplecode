//
//  FullScreenImagePresenter.swift
//  CodeChallenge
//
//  Created by personal on 19.07.2022.
//

import UIKit

protocol FullScreenImagePresentationLogic {
    func presentFullScreenImage(image: String)
}

class FullScreenImagePresenter: FullScreenImagePresentationLogic {
    weak var viewController: FullScreenImageDisplayLogic?

    func presentFullScreenImage(image: String) {
        viewController?.displayFullScreenImage(image: image)
    }
}
