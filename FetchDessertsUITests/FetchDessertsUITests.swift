//
//  FetchDessertsUITests.swift
//  FetchDessertsUITests
//
//  Created by Bryce Caro on 11/8/23.
//

import XCTest

final class FetchDessertsUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDessertPreviewView() throws {
        let app = XCUIApplication()
        app.launchArguments.append("Testing")
        app.launch()

        let elementsQuery = app.scrollViews.otherElements
        XCTAssert(elementsQuery.staticTexts["Portuguese Custard Tarts"].waitForExistence(timeout: 3), "[-][FetchDessertsUITests][testDessertPreviewView] Title for dessert preview element does not exist")
        XCTAssert(elementsQuery.images["dessertPreviewImage"].waitForExistence(timeout: 2), "[-][FetchDessertsUITests][testDessertPreviewView] Unable to load preview image for feed item")
    }
    
    func testDessertViewLoading() throws {
        let app = XCUIApplication()
        app.launchArguments.append("Testing")
        app.launch()

        let elementsQuery = app.scrollViews.otherElements
        
        // Enter in to Dessert View
        elementsQuery.staticTexts["Portuguese Custard Tarts"].tap()
        
        // Check whether elements have properly loaded in to view
        XCTAssert(elementsQuery.staticTexts["Portuguese Custard Tarts"].waitForExistence(timeout: 3), "[-][FetchDessertsUITests][testDessertView] Title for dessert element does not exist")
        
        let dessertImage = elementsQuery.images["dessertImage"]
        XCTAssert(dessertImage.waitForExistence(timeout: 2), "[-][FetchDessertsUITests][testDessertView] Failed loading dessert view image")
        
        // Dismiss dessert view and ensure feed is still loaded
        app/*@START_MENU_TOKEN@*/.buttons["backButton"]/*[[".buttons[\"Left\"]",".buttons[\"backButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssert(elementsQuery.staticTexts["Portuguese Custard Tarts"].waitForExistence(timeout: 3), "[-][FetchDessertsUITests][testDessertView] Title for dessert preview element does not exist")
        XCTAssert(app.scrollViews.otherElements.images["dessertPreviewImage"].waitForExistence(timeout: 2), "[-][FetchDessertsUITests][testDessertView] Unable to load preview image for feed item")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
