//
//  UITestingHelper.swift
//  PersonalPeopleAPI
//
//  Created by Manish Parihar on 20.10.23.
//

/**
 Why we use this Macros (#if DEBUG) ?
 Reason -: All the main code we writting will be in final bundled and published to the app store.
 Actually we dont want to ship our Unit , UI or Integration test to shipped in publised bundle.
 So how can we exclude this code from out app build and make only  when we are running our
 test within our app.
 So basically Micro PreProcessors that allows us to basically exclude code out if it is being run in a
 non debug environment.
 It is also help reduce the size of our applicaiton
 */
#if DEBUG
/*
 Purpose of this file -:
 To access those launch environment and arguments within our main application
 And then we can change the way our code is configured depending on what has been set.
 */

// So lets create our Skeleton for our UITesting helper
import Foundation

struct UITestingHelper {
    
    // how can i grab a value from launch Argument so we can know this is uitesting
    static var isUITesting: Bool {
        /*
         If the current mode that our app is running in is either a UITest or if its
         just like an standard app run when we are running it on the simulator or on our device.
         I personally prefer when working with UITesting Helpers to do all this stuff within an
         AppDelegate but SwiftUI doesn not have it So we need to create AppDelete
        */
        ProcessInfo.processInfo.arguments.contains("-ui-testing")
    }
    
    // Create new property for networking successful
    // Refactor and rename from isNetworkingSuccessful to isPeopleNetworkingSuccessful for UItest
    static var isPeopleNetworkingSuccessful: Bool {
        ProcessInfo.processInfo.environment["-people-networking-success"] == "1"
    }
    
    // For Detail View
    static var isDetailsNetworkingSuccessful: Bool {
        ProcessInfo.processInfo.environment["-details-networking-success"] == "1"
    }
    
    // For CreateView
    static var isCreateNetworkingSuccessful: Bool {
        ProcessInfo.processInfo.environment["-create-networking-success"] == "1"
    }
}

#endif

/**
 1. Create New folder for UITesting
 
 2. We already have many mocks within our unit test which we are going to use for
 
 3. Move all the file from Unit Test foler -> Networking -> Mocks -> Create, UserDetails, MockURLSessionProtocol and UserResponse
 to the newly created Mocks folder in Main Project Target  the reason is we dont want to repeat our mock again for our
 Unit Test and UITest 
 
 */
