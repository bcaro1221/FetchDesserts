//
//  FetchDessertsTests.swift
//  FetchDessertsTests
//
//  Created by Bryce Caro on 11/8/23.
//

import XCTest
@testable import FetchDesserts

final class FetchDessertsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    private func getDessertPreviewTestData() -> Data {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "testDessertPreviewsData", withExtension: "json") else {
            fatalError("[-][FetchDessertsTests] Failed loading Dessert Previews Test Data")
        }
        
        return try! Data(contentsOf: url)
    }
    
    private func getDessertTestData() -> Data {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "testDessertData", withExtension: "json") else {
            fatalError("[-][FetchDessertsTests] Failed loading Dessert Test Data")
        }
        
        return try! Data(contentsOf: url)
    }

    func testDessertPreviewsParsing() throws {
        let data = getDessertPreviewTestData()
        
        do {
            _ = try JSONDecoder().decode(DessertsResult<DessertPreview>.self, from: data)
        } catch {
            XCTFail("[-][FetchDessertsTests] Failed decoding data in to Dessert Previews Data: \(error)")
        }
    }
    
    func testDessertParsing() throws {
        let data = getDessertTestData()
        
        do {
            _ = try JSONDecoder().decode(DessertsResult<Dessert>.self, from: data)
        } catch {
            XCTFail("[-][FetchDessertsTests] Failed decoding data in to Dessert Data: \(error)")
        }
    }
    
    func testFetchData() async throws {
        let repository = DessertsRepository()
        
        do {
            let _ = try await repository.fetchDessertPreviews()
            let _ = try await repository.fetchDessert(for: Dessert.testDessert.id)
        } catch {
            XCTFail("[-][FetchDessertsTests] Failed fetching data from endpoint: \(error)")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
