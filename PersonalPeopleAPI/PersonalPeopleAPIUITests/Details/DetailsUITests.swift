//
//  DetailsUITests.swift
//  PersonalPeopleAPIUITests
//
//  Created by Manish Parihar on 21.10.23.
//

import XCTest

final class DetailsUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        /*
         Right now our launch argument here networking success is too generic so cant actually specify if we
         want the Detail screen to fail and pass or if we want the People screen to fail and pass as well.
         So we are going to Refator our UITest to allow someone to essentially choose and dictate whether
         they want People Screen and or the Detail Screen to fail so in order to do that the first one we
         are going to do in on our launch environment for PeopleUITests make -people-networking-success,
         Because we updated the launch environment here we are going to update UITesingHelper
         
         */
        app.launchEnvironment = ["-people-networking-success":"1",
                                 "-details-networking-success":"1"]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func test_user_info_is_correct_when_item_is_tapped_screen_loads() {
        let grid = app.otherElements["peopleGrid"]
        XCTAssertTrue(grid.waitForExistence(timeout: 5), "The lazygrids should exist on the screen")
        
        let predicate = NSPredicate(format: "identifier CONTAINS 'item_'")
        let gridItems = grid.buttons.containing(predicate)
        
        gridItems.firstMatch.tap()
        
        XCTAssertTrue(app.staticTexts["Details"].exists)
        XCTAssertTrue(app.staticTexts["#2"].exists)
        XCTAssertTrue(app.staticTexts["First Name"].exists)
        XCTAssertTrue(app.staticTexts["Janet"].exists)
        XCTAssertTrue(app.staticTexts["Last Name"].exists)
        XCTAssertTrue(app.staticTexts["Weaver"].exists)
        XCTAssertTrue(app.staticTexts["Email"].exists)
        XCTAssertTrue(app.staticTexts["janet.weaver@reqres.in"].exists)
        XCTAssertTrue(app.staticTexts["To keep ReqRes free, contributions towards server costs are appreciated!"].exists)
        XCTAssertTrue(app.staticTexts["https://reqres.in/#support-heading"].exists)
    }
}
