//
//  PersonItemView.swift
//  PersonalPeopleAPI
//
//  Created by Manish Parihar on 12.10.23.
//

import SwiftUI

struct PersonItemView: View {
    
    let user: Int
    
    var body: some View {
        VStack(spacing:.zero) {
            Rectangle()
                .fill(.blue)
                .frame(height:130)
            
            VStack {
               PillView(id: user)
                
                Text("<First name> <Last name>")
                    .foregroundStyle(Theme.text)
                    .font(
                        .system(.body, design:.rounded)
                    )
            }
            .frame(maxWidth: .infinity, 
                   alignment:.leading)
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            .background(Theme.detailBackground)
            
        }
        .clipShape(RoundedRectangle(cornerRadius: 16, 
                                    style: .continuous))
        .shadow(color: Theme.text.opacity(0.1),
                radius: 2,
                x: 0,
                y: 1)
    }
}

#Preview {
    PersonItemView(user: 0)
        .frame(width: 250)
}