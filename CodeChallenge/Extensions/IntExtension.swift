//
//  IntExtension.swift
//  CodeChallenge
//
//  Created by personal on 19.07.2022.
//

import Foundation

extension Int {
    func toPriceString() -> String {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.groupingSize = 3
        formatter.maximumFractionDigits = 2
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","
        let value = Double(self) / 100.0
        return formatter.string(from: NSNumber(value: value)) ?? ""
    }
}
