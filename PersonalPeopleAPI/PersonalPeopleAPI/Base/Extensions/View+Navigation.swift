//
//  View+Navigation.swift
//  PersonalPeopleAPI
//
//  Created by Manish Parihar on 21.10.23.
//

import SwiftUI

extension View {
    @ViewBuilder // SwiftUI doesnot know without viewbuilder
    func embedInNavigation() -> some View {
        if #available(iOS 16.0, *) { // Star denotes iOS > 16.0
            NavigationStack {
                self  // Why using self - bcoz we using embed in navigation on some kind of view
            }
        } else {
            NavigationView {
                self // For iOS < 16.0
            }
        }
    }
}
