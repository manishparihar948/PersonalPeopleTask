//
//  SettingsView.swift
//  PersonalPeopleAPI
//
//  Created by Manish Parihar on 16.10.23.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage(UserDefaultsKeys.hapticsEnabled) private var isHapticsEnabled: Bool = true
    
    var body: some View {
       // NavigationStack {
            Form {
                haptics
            }
            .navigationTitle("Settings")
            .embedInNavigation()
        //}
    }
}

private extension SettingsView {
    var haptics: some View {
        Toggle("Enable Haptics", isOn: $isHapticsEnabled) // bind haptics key with toggle
    }
}

#Preview {
    SettingsView()
}
