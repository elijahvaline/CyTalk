//
//  CyTalkUITests.swift
//  CyTalkUITests
//
//  Created by Elijah Valine on 10/24/20.
//

import XCTest

class CyTalkUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_login_screen() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        let button = app.buttons["loginScreen"]
        button.tap()
     
    }
    
    func test_new_post() throws {
        
        let app = XCUIApplication()
        app.launch()
         
        let button = app.buttons["newPostButton"]
        button.tap()
        
        
    }
    func test_post_view() throws {
        let app = XCUIApplication()
        app.launch()
        let button = app.buttons["Benman"]
        button.tap()
        
    }
    
    func test_profile_view() throws {
        let app = XCUIApplication()
        app.launch()
        let button = app.buttons["@mrpit"]
        button.tap()
        
    }
    
    


    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
