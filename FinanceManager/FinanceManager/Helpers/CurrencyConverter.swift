//
//  CurrencySymbol.swift
//  FinanceManager
//
//  Created by Kirill on 23.09.21.
//

import Foundation

func currencySymbolByCode(code: String) -> String {
    let currencyCode = code
    let localeCmponents = NSLocale(localeIdentifier: currencyCode)
    return localeCmponents.displayName(forKey: .currencySymbol, value: currencyCode) ?? ""
}


func currencyNameByCode(code: String) -> String? {
    return Locale.current.localizedString(forCurrencyCode: code)
}

func currencyLabelWithSpace(currency: String) -> String {
    if NSLocale.commonISOCurrencyCodes.contains(currency) {
        return currency + " " + currencySymbolByCode(code: currency)
    } else {
        return ""
    }
}

