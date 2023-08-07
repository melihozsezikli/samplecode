//
//  ApiResponse.swift
//  CodeChallenge
//
//  Created by personal on 16.07.2022.
//

import UIKit

class ApiResponse {
    var success: Bool!
    var message: String
    var data: Codable?
    
    init(success: Bool, message: String? = nil, data: Codable? = nil) {
        self.success = success
        self.message = message ?? (success ? "" : "An error occured")
        self.data = data
    }
}
