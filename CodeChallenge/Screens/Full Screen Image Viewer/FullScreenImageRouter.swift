//
//  FullScreenImageRouter.swift
//  CodeChallenge
//
//  Created by personal on 19.07.2022.
//

import UIKit

protocol FullScreenImageDataPassing {
    var dataStore: FullScreenImageDataStore? { get }
}

class FullScreenImageRouter: NSObject, FullScreenImageDataPassing {
    weak var viewController: FullScreenImageViewController?
    var dataStore: FullScreenImageDataStore?
}
