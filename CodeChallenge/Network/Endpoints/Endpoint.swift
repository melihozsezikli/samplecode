//
//  Endpoint.swift
//  CodeChallenge
//
//  Created by personal on 16.07.2022.
//

import Foundation
import Alamofire

class ApiRequest<ResponseType: Codable> {

    func webserviceUrl() -> String {
        return "https://gateway.ebay-kleinanzeigen.de/coding-challenge/"
    }

    func apiPath() -> String {
        return "api/"
    }

    func apiVersion() -> String {
        return "v1/"
    }

    func endPoint() -> String {
        return ""
    }
    
    func path() -> String {
        return ""
    }

    func requestType() -> HTTPMethod {
        return .get
    }

    func contentType() -> String {
        return "application/json"
    }
}
