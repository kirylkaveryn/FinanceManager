//
//  Transaction+CoreDataProperties.swift
//  FinanceManager
//
//  Created by Kirill on 25.09.21.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var name: String
    @NSManaged public var note: String?
    @NSManaged public var date: Date
    @NSManaged public var value: NSDecimalNumber
    @NSManaged public var wallet: Wallet

}

extension Transaction : Identifiable {

}
