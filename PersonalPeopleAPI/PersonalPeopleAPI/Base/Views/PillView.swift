//
//  PillView.swift
//  PersonalPeopleAPI
//
//  Created by Manish Parihar on 12.10.23.
//

import SwiftUI

struct PillView: View {
    let id: Int
    var body: some View {
        Text("#\(id)")
            .font(
                .system(.caption, design: .rounded)
                .bold()
            )
            .foregroundStyle(.white)
            .padding(.horizontal, 9)
            .padding(.vertical, 4)
            .background(Theme.pill, in: Capsule())
    }
}

#Preview {
    PillView(id: 0)
        .padding()
        .previewLayout(.sizeThatFits)
}
