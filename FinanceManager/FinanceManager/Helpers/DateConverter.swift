//
//  DateConverter.swift
//  FinanceManager
//
//  Created by Kirill on 24.09.21.
//

import Foundation

func dateConvertDateFromString(inputDate: String) -> String {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "YYYY-MM-dd"
    guard let date = inputFormatter.date(from: inputDate) else { return "" }
    
    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = "MMMM d, YYYY"
    
    return outputFormatter.string(from: date)
}

func dateGetCurrentDateString() -> String {
    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = "MMMM d, YYYY"
    
    return outputFormatter.string(from:  Date())
}

func dateGetFullDateString(date: Date) -> String {
    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = "MMMM d, YYYY"
    
    return outputFormatter.string(from:  date)
}

func dateGetShortDateString(date: Date) -> String {
    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = "d MMM"
    
    return outputFormatter.string(from:  date)
}




