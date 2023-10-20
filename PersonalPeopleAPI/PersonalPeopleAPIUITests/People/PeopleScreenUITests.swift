//
//  PeopleScreenUITests.swift
//  PersonalPeopleAPIUITests
//
//  Created by Manish Parihar on 20.10.23.
//

import XCTest

final class PeopleScreenUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        // when ur test fails then you want to stop running further
        continueAfterFailure = false
        // Create fresh app everytime
        app = XCUIApplication()
        /**
         We should not test our Real API, So basically we want to test our Mock data because if our API's goes down so our test also
         We  can  do this by using launch arguments and launch  environment -so what it will do ?
         It allows to actually pass data into our main app so when our UI tests are running we are able to actually change what is used
         between each room so in launch argument for checking to see if this is a UITest
         
         So if we see this array of string argument , ["-ui-testing"] in our main application we will know that is a UI Test that we are
         currently running its not the main application and so what we will do we will set a launch environment we can specify a key value pair that
         we want to use within our application so what so what we going to do here is networking.["-networking-success":"1"]
         */
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = ["-networking-success":"1"]
        // then launch
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func test_grid_has_correct_number_of_items_when_screen_loads() {
        let grid = app.otherElements["peopleGrid"]
        // Check and validate grid on the screen using a function called wait for existance
        XCTAssertTrue(grid.waitForExistence(timeout: 5), "The people lazygrid should be visible")
        
        // To predict some words on the screen, kind of light query to search
        let predicate = NSPredicate(format:"identifier CONTAINS 'item_'")
        let gridItems = grid.buttons.containing(predicate)
        XCTAssertEqual(gridItems.count,6, "There should be 6 items on the screen")
        
        XCTAssertTrue(gridItems.staticTexts["#1"].exists)
        XCTAssertTrue(gridItems.staticTexts["George Bluth"].exists)
        
        XCTAssertTrue(gridItems.staticTexts["#2"].exists)
        XCTAssertTrue(gridItems.staticTexts["Janet Weaver"].exists)
        
        XCTAssertTrue(gridItems.staticTexts["#3"].exists)
        XCTAssertTrue(gridItems.staticTexts["Emma Wong"].exists)
        
        XCTAssertTrue(gridItems.staticTexts["#4"].exists)
        XCTAssertTrue(gridItems.staticTexts["Eve Holt"].exists)
        
        XCTAssertTrue(gridItems.staticTexts["#5"].exists)
        XCTAssertTrue(gridItems.staticTexts["Charles Morris"].exists)
        
        XCTAssertTrue(gridItems.staticTexts["#6"].exists)
        XCTAssertTrue(gridItems.staticTexts["Tracey Ramos"].exists)
    }
    
}


/**
 Way to debug from command line
 (lldb) po grid.children(matching: .any)
 */

