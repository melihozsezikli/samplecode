//
//  Client.swift
//  CodeChallenge
//
//  Created by personal on 16.07.2022.
//

import Foundation
import Alamofire

typealias ResponseHandler = (ApiResponse) -> Void

class NetworkApiClient {
    
    func callApi<ResponseType>(request: ApiRequest<ResponseType>, responseHandler: @escaping ResponseHandler) {
        
        let dataRequest = dataRequestWith(apiRequest: request)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(NetworkApiClient.dateFormatter)
        dataRequest
            .validate()
            .authenticate(username: "candidate", password: "LnpwL7HoZjTL")
            .responseDecodable(of: ResponseType.self, decoder: decoder) { response in
                switch response.result {
                case .success(_):
                    if let data = response.value {
                        let apiResponse = ApiResponse(success: true,
                                                      message: nil,
                                                      data: data)
                        responseHandler(apiResponse)
                    }
                case .failure(_):
                    let apiResponse = ApiResponse(success: false)
                    responseHandler(apiResponse)
                }
            }
    }
    
    func dataRequestWith<ResponseType>(apiRequest: ApiRequest<ResponseType>) -> DataRequest {
        let baseURL = apiRequest.webserviceUrl() + apiRequest.apiPath() + apiRequest.apiVersion()
        let requestURL = baseURL + apiRequest.endPoint() + apiRequest.path()
        var urlRequest = URLRequest(url: URL(string: requestURL)!)
        urlRequest.httpMethod = apiRequest.requestType().rawValue
        urlRequest.setValue(apiRequest.contentType(), forHTTPHeaderField:  "Content-Type")
        let dataRequest = AF.request(urlRequest)
        return dataRequest
    }
   
    static let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            return formatter
    }()
    
}
