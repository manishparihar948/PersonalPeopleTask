//
//  PersonalPeopleAPIApp.swift
//  PersonalPeopleAPI
//
//  Created by Manish Parihar on 11.10.23.
//

import SwiftUI

@main
struct PersonalPeopleAPIApp: App {
    
    // Hook the AppDelegate here
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    
    var body: some Scene {
        WindowGroup {
            TabView {
                PeopleView()
                    .tabItem {
                        Symbols.person
                        Text("Home")
                    }
                SettingsView()
                    .tabItem {
                        Symbols.gear
                        Text("Settings")
                    }
            }
        }
    }
}

/**
For UITesting Purpose -:
 
  If the current mode that our app is running in is either a UITest or if its
  just like an standard app run when we are running it on the simulator or on our device.
  I personally prefer when working with UITesting Helpers to do all this stuff within an
  AppDelegate but SwiftUI doesn not have it So we need to create AppDelete
 
 */
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // Entry point when your app is set, configure before app launches
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        #if DEBUG
        print("👷🏾‍♂️ Is UI Test Running: \(UITestingHelper.isUITesting)")
        #endif
        return true
    }
}
