//
//  PeopleView.swift
//  PersonalPeopleAPI
//
//  Created by Manish Parihar on 12.10.23.
//

import SwiftUI

struct PeopleView: View {
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    @State private var users: [User] = []
    
    var body: some View {
        NavigationStack {
            ZStack {
                background
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(users, id:\.id) { item in
                            PersonItemView(user: item)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("People")
            .toolbar{
                ToolbarItem(placement: .primaryAction) {
                   create
                }
            }
            .onAppear {
                do {
                    let res = try StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self)
                    users = res.data
                } catch {
                    // TODO: Handle any error
                    print(error)
                }
            }
        }
    }
}

#Preview {
    PeopleView()
}

// Extracting View into components
private extension PeopleView {
    
    var background: some View {
        Theme.background
            .ignoresSafeArea(edges: .top)
    }
    
    var create: some View {
        Button {
            
        } label: {
            Symbols.plus
                .font(
                    .system(.headline, design: .rounded)
                    .bold()
                )
        }
    }
    
}
