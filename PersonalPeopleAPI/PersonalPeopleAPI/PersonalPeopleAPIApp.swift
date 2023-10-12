//
//  PersonalPeopleAPIApp.swift
//  PersonalPeopleAPI
//
//  Created by Manish Parihar on 11.10.23.
//

import SwiftUI

@main
struct PersonalPeopleAPIApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                PeopleView()
                    .tabItem {
                        Symbols.person
                        Text("Home")
                    }
            }
        }
    }
}
