//
//  ProductDetailViewController.swift
//  CodeChallenge
//
//  Created by personal on 16.07.2022.
//

import UIKit

protocol ProductDetailDisplayLogic: AnyObject
{
    func displayProductDetail(viewModel: ProductDetail.ProductData.ViewModel)
    func displayError(message: String)
}

class ProductDetailViewController: ViewController, ProductDetailDisplayLogic {
    
    typealias SectionType = ProductDetail.SectionType
    
    var interactor: ProductDetailBusinessLogic?
    var router: (NSObjectProtocol & ProductDetailRoutingLogic & ProductDetailDataPassing)?
    var sections = [SectionType]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
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
        let interactor = ProductDetailInteractor()
        let presenter = ProductDetailPresenter()
        let router = ProductDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getProductDetail()
    }
    
    func getProductDetail() {
        let request = ProductDetail.ProductData.Request(productID: "1118635128")
        interactor?.getProductDetail(request: request)
    }
    
    func displayProductDetail(viewModel: ProductDetail.ProductData.ViewModel) {
        let sections = viewModel.sections
        self.sections = sections
        tableView.reloadData()
    }
    
    func displayError(message: String) {
        showAlert(message: message)
    }
    
}

extension ProductDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureTableView() {
        tableView.register(ProductDetailSectionHeader.self,
                           forHeaderFooterViewReuseIdentifier: "ProductDetailSectionHeader")
        tableView.register(UINib(nibName: "ProductDetailGalleryCell", bundle: nil),
                           forCellReuseIdentifier: "ProductDetailGalleryCell")
        tableView.register(UINib(nibName: "ProductDetailInfoCell",
                                 bundle: nil),
                           forCellReuseIdentifier: "ProductDetailInfoCell")
        tableView.register(UINib(nibName: "ProductDetailAttributeCell",
                                 bundle: nil),
                           forCellReuseIdentifier: "ProductDetailAttributeCell")
        tableView.register(UINib(nibName: "ProductDetailFeatureCell",
                                 bundle: nil),
                           forCellReuseIdentifier: "ProductDetailFeatureCell")
        tableView.register(UINib(nibName: "ProductDetailDocumentCell",
                                 bundle: nil),
                           forCellReuseIdentifier: "ProductDetailDocumentCell")
        tableView.register(UINib(nibName: "ProductDetailDescriptionCell",
                                 bundle: nil),
                           forCellReuseIdentifier: "ProductDetailDescriptionCell")
        
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0.0,
                                                         y: 0.0,
                                                         width: 0.0,
                                                         height: .leastNormalMagnitude))
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
         case .gallery:
            return 1
        case .info:
            return 1
        case .details(attributes: let attributes):
            return attributes.count
        case .features(features: let features):
            return features.chunked(into: 2).count
        case .documents(documents: let documents):
            return documents.count
        case .description:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .gallery(images: let images, productID: let productID):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailGalleryCell",for: indexPath) as! ProductDetailGalleryCell
            cell.bind(images: images, productID: productID) { [weak self] image in
                self?.interactor?.setSelectedImage(image: image)
                self?.router?.routeToFullScreenImageVC()
            }
            return cell
        case .info(title: let title, price: let price, address: let address, date: let date, visits: let visits, productID: let productID):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailInfoCell",for: indexPath) as! ProductDetailInfoCell
            cell.bind(title: title, price: price, address: address, date: date, visits: visits, productID: productID) { [weak self] in
                self?.interactor?.setSelectedAddress(address: address)
                self?.router?.routeToMap()
            }
            return cell
        case .details(attributes: let attributes):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailAttributeCell",for: indexPath) as! ProductDetailAttributeCell
            let attribute = attributes[indexPath.row]
            cell.bind(attribute: attribute)
            return cell
        case .features(features: let features):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailFeatureCell",for: indexPath) as! ProductDetailFeatureCell
            let chunkedFeatures = features.chunked(into: 2)[indexPath.row]
            cell.bind(features: chunkedFeatures)
            cell.separatorInset.right = .greatestFiniteMagnitude
            return cell
        case .documents(documents: let documents):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailDocumentCell", for: indexPath) as! ProductDetailDocumentCell
            let document = documents[indexPath.row]
            cell.bind(document: document)
            return cell
        case .description(description: let description):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailDescriptionCell", for: indexPath) as! ProductDetailDescriptionCell
            cell.bind(description: description)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = sections[indexPath.section]
        switch section {
        case .gallery:
            return UIScreen.main.bounds.width * 0.8
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = sections[section]
        
        if let title = section.title() {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ProductDetailSectionHeader") as! ProductDetailSectionHeader
            headerView.bind(title: title)
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = sections[section]
        if section.title() != nil {
            return 50
        }
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let section = sections[section]
        switch section {
        case .gallery:
            return .leastNormalMagnitude
        default:
            return 12
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        switch section {
        case .documents(documents: let documents):
            let document = documents[indexPath.row]
            interactor?.setSelectedDocument(document: document)
            router?.routeToWebView()
        default:
            break
        }
    }
    
}
