//
//  DateExtension.swift
//  CodeChallenge
//
//  Created by personal on 16.07.2022.
//

import Foundation

extension Date {
    func getDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: self)
    }
}
