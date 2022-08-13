//
//  CoreDataManager.swift
//  FinanceManager
//
//  Created by Kirill on 25.09.21.
//

import Foundation
import CoreData

protocol CoreDataManageProtocol {
    var managedObjectContext: NSManagedObjectContext { get }
    var persistentContainer: NSPersistentContainer { get }
    
    func fetchData() -> [Wallet]
    func createNewWallet(name: String, currency: String, themeIndex: Int)
    func createNewTransaction(forWallet wallet: Wallet, name: String, value: NSDecimalNumber, date: Date, note: String?)
    func deleteTransaction(fromWallet wallet: Wallet, transaction: Transaction)
    func deleteWallet(wallet: Wallet)
    func saveContext()
}

class CoreDataManager: NSObject, CoreDataManageProtocol {
    
    var managedObjectContext: NSManagedObjectContext
    var persistentContainer: NSPersistentContainer
    
    init(containerName: String) {
        persistentContainer = NSPersistentContainer(name: containerName)
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        managedObjectContext = persistentContainer.viewContext
    }

    func fetchData() -> [Wallet] {
        var walletStorage: [Wallet] = []
        do {
            walletStorage = try managedObjectContext.fetch(Wallet.fetchRequest())
            return walletStorage
        } catch {
            print("Fetch error")
        }
        return walletStorage
    }

    func createNewWallet(name: String, currency: String, themeIndex: Int) {
        let wallet = Wallet(context: self.managedObjectContext)
        wallet.name = name
        wallet.currency = currency
        wallet.themeIndex = Int16(themeIndex)
        wallet.transactions = []
        saveContext()
    }
    
    func deleteWallet(wallet: Wallet) {
        managedObjectContext.delete(wallet)
        saveContext()
    }
    
    func createNewTransaction(forWallet wallet: Wallet, name: String, value: NSDecimalNumber, date: Date, note: String?) {
        let transaction = Transaction(context: self.managedObjectContext)
        transaction.wallet = wallet
        transaction.name = name
        transaction.value = value
        transaction.date = date
        transaction.note = note
        wallet.addToTransactions(transaction)
        saveContext()
    }
    
    func deleteTransaction(fromWallet wallet: Wallet, transaction: Transaction) {
        wallet.removeFromTransactions(transaction)
        saveContext()
    }
    
    func saveContext() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
