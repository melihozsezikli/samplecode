//
//  FullScreenImageViewController.swift
//  CodeChallenge
//
//  Created by personal on 19.07.2022.
//

import UIKit

protocol FullScreenImageDisplayLogic: AnyObject {
    func displayFullScreenImage(image: String)
}

class FullScreenImageViewController: UIViewController, FullScreenImageDisplayLogic {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var interactor: FullScreenImageBusinessLogic?
    var router: FullScreenImageRouter?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        let viewController = self
        let interactor = FullScreenImageInteractor()
        let router = FullScreenImageRouter()
        let presenter = FullScreenImagePresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.dataStore = interactor
        viewController.router = router
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImage()
    }

    func getImage() {
        interactor?.getImage()
    }

    func displayFullScreenImage(image: String) {
        let imageWithSize = image.replacingOccurrences(of: "{imageId}", with: "57")
        if let imageURL = URL(string: imageWithSize) {
            imageView.kf.setImage(with: imageURL)
        } else {
            imageView.image = nil
        }
    }
}
