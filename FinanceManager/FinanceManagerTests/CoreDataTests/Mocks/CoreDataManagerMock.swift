//
//  CoreDataManagerMock.swift
//  FinanceManagerTests
//
//  Created by Kirill on 5.10.21.
//

import XCTest
import CoreData

@testable import FinanceManager

class CoreDataManagerMock: CoreDataManager {
    
    override init(containerName: String) {
        super.init(containerName: containerName)
        
        let persistentStoreDescrtiptor = NSPersistentStoreDescription()
        persistentStoreDescrtiptor.type = NSInMemoryStoreType
        
        let inmemoryPersistentContainer = NSPersistentContainer(name: containerName)
        inmemoryPersistentContainer.persistentStoreDescriptions = [persistentStoreDescrtiptor]
        
        inmemoryPersistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        persistentContainer = inmemoryPersistentContainer
        managedObjectContext = inmemoryPersistentContainer.viewContext

    }
}
