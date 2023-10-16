//
//  CheckmarkPopoverView.swift
//  PersonalPeopleAPI
//
//  Created by Manish Parihar on 16.10.23.
//

import SwiftUI

struct CheckmarkPopoverView: View {
    var body: some View {
        Symbols.checkmark
            .font(.system(.largeTitle, design: .rounded).bold())
            .background(.thinMaterial, in:RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

#Preview {
    CheckmarkPopoverView()
        .previewLayout(.sizeThatFits)
        .padding()
        .background(.blue)
}
