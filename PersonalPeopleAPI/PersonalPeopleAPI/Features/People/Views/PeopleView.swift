//
//  PeopleView.swift
//  PersonalPeopleAPI
//
//  Created by Manish Parihar on 12.10.23.
//

import SwiftUI

struct PeopleView: View {
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    @StateObject private var vm = PeopleViewModel()
    @State private var shouldShowCreate = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                background
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(vm.users, id:\.id) { user in
                            NavigationLink{
                                DetailView(userId: user.id)
                            } label: {
                                PersonItemView(user: user)
                            }
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
                vm.fetchUsers()
            }
            .sheet(isPresented: $shouldShowCreate){
                CreateView()
            }
            .alert(isPresented: $vm.hasError, error: vm.error) {
                Button("Retry"){
                    vm.fetchUsers()
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
            shouldShowCreate.toggle()
        } label: {
            Symbols.plus
                .font(
                    .system(.headline, design: .rounded)
                    .bold()
                )
        }
    }
    
}
