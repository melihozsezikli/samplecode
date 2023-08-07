//
//  StringExtension.swift
//  CodeChallenge
//
//  Created by personal on 19.07.2022.
//

import Foundation

extension String {
    func toCurrencySymbol() -> String {
      let locale = NSLocale(localeIdentifier: self)
      return locale.displayName(forKey: NSLocale.Key.currencySymbol, value: self) ?? self
    }
}
