//
//  CoreDataManagerTests.swift
//  FinanceManagerTests
//
//  Created by Kirill on 5.10.21.
//

import XCTest
import CoreData

@testable import FinanceManager

class CoreDataManagerTests: XCTestCase {
    
    var coreDataManager: CoreDataManagerMock!

    override func setUpWithError() throws {
        super.setUp()
        coreDataManager = CoreDataManagerMock(containerName: "FinanceManager")

    }

    override func tearDownWithError() throws {
        coreDataManager = nil
        super.tearDown()
    }
    
    func test_fetchData() {
        let walletList = coreDataManager.fetchData()
        XCTAssertTrue(walletList.count == 0)

    }
    
    func test_createNewWallet() {
        coreDataManager.createNewWallet(name: "testWallet",
                                        currency: "USD",
                                        themeIndex: 0)
        let walletList = coreDataManager.fetchData()
        
        XCTAssertNotNil(walletList)
        XCTAssertTrue(walletList.count == 1)
        XCTAssertEqual(walletList.first?.name, "testWallet")
        XCTAssertEqual(walletList.first?.currency, "USD")
        XCTAssertEqual(walletList.first?.themeIndex, 0)
    }
    
    func test_createNewTransactionForWallet() {
        coreDataManager.createNewWallet(name: "testWallet",
                                        currency: "USD",
                                        themeIndex: 0)
        let walletList = coreDataManager.fetchData()
        
        guard let firstWallet = walletList.first else {
            XCTFail("Wallet was not created")
            return
        }
        
        XCTAssertTrue(firstWallet.transactions?.count == 0)
        XCTAssertNil(firstWallet.transactions?.firstObject)

        coreDataManager.createNewTransaction(forWallet: firstWallet,
                                             name: "testTransaction",
                                             value: 10,
                                             date: Date(),
                                             note: nil)
        
        XCTAssertTrue(firstWallet.transactions?.count == 1)
        XCTAssertNotNil(firstWallet.transactions?.firstObject)

        let firstTransaction = firstWallet.transactions?.firstObject as? Transaction
        
        XCTAssertNotNil(firstTransaction)
        XCTAssertEqual(firstTransaction?.name, "testTransaction")
        XCTAssertEqual(firstTransaction?.value, 10)
        XCTAssertNotEqual(firstTransaction?.date, Date()) // current Dates must not be Equal

    }
    
    func test_deleteWallet() {
        coreDataManager.createNewWallet(name: "testWallet",
                                        currency: "USD",
                                        themeIndex: 0)
        var walletList = coreDataManager.fetchData()
        guard let firstWallet = walletList.first  else {
            XCTFail("Wallet was not created")
            return
        }
        
        XCTAssertNotNil(walletList)
        XCTAssertTrue(walletList.count == 1)
        
        coreDataManager.deleteWallet(wallet: firstWallet)
        walletList = coreDataManager.fetchData()
        
        XCTAssertTrue(walletList.count == 0)

    }
    
    func test_deleteTransactionFromWallet() {
        coreDataManager.createNewWallet(name: "testWallet",
                                        currency: "USD",
                                        themeIndex: 0)
        let walletList = coreDataManager.fetchData()
        
        guard let firstWallet = walletList.first else {
            XCTFail("Wallet was not created")
            return
        }
        
        XCTAssertTrue(firstWallet.transactions?.count == 0)
        XCTAssertNil(firstWallet.transactions?.firstObject)

        coreDataManager.createNewTransaction(forWallet: firstWallet,
                                             name: "testTransaction",
                                             value: 10,
                                             date: Date(),
                                             note: nil)
        
        XCTAssertTrue(firstWallet.transactions?.count == 1)
        
        guard let firstTransaction = firstWallet.transactions?.firstObject as? Transaction else {
            XCTFail("Transaction does not exist")
            return
        }
        coreDataManager.deleteTransaction(fromWallet: firstWallet, transaction: firstTransaction)
        
        XCTAssertTrue(firstWallet.transactions?.count == 0)
    }


}
