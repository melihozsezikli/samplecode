//
//  ProductDetailRouter.swift
//  CodeChallenge
//
//  Created by personal on 16.07.2022.
//
import UIKit
import SafariServices

@objc protocol ProductDetailRoutingLogic {
    func routeToFullScreenImageVC()
    func routeToWebView()
    func routeToMap()
}

protocol ProductDetailDataPassing {
    var dataStore: ProductDetailDataStore? { get }
}

class ProductDetailRouter: NSObject, ProductDetailRoutingLogic, ProductDetailDataPassing {
    var dataStore: ProductDetailDataStore?
    weak var viewController: ProductDetailViewController?
    
    func routeToFullScreenImageVC() {
        let destinationVC = FullScreenImageViewController(nibName: "FullScreenImageViewController", bundle: nil)
        var destinationDataStore = destinationVC.router!.dataStore!
        passDataToFullScreenImageVC(source: dataStore!, destination: &destinationDataStore)
        navigateToFullScreenImageVC(source: viewController!, destination: destinationVC)
    }
    
    func navigateToFullScreenImageVC(source: ProductDetailViewController, destination: FullScreenImageViewController) {
        source.present(destination, animated: true)
    }
    
    func passDataToFullScreenImageVC(source: ProductDetailDataStore, destination: inout FullScreenImageDataStore) {
        destination.image = source.selectedImage
    }
    
    func routeToWebView() {
        guard let url = dataStore?.selectedDocument?.link else { return }
        let sfController = SFSafariViewController(url: url)
        navigateToWebview(source: viewController!, destination: sfController)
    }
    
    func navigateToWebview(source: ProductDetailViewController, destination: SFSafariViewController) {
        source.present(destination, animated: true)
    }
    
    func routeToMap() {
        guard let address = dataStore?.selectedAddress else { return }
        guard let latitude = address.latitude else { return }
        guard let longitude = address.longitude else { return }
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            if let url = URL(string: "comgooglemaps://?saddr=&daddr=\(latitude),\(longitude)") {
                UIApplication.shared.open(url, options: [:])
            }
        } else {
            if let urlDestination = URL.init(string: "https://www.google.de/maps/dir/?saddr=&daddr=\(latitude),\(longitude)") {
                UIApplication.shared.open(urlDestination)
            }
        }
        
    }
}

