//
//  PeopleView.swift
//  PersonalPeopleAPI
//
//  Created by Manish Parihar on 12.10.23.
//

import SwiftUI

struct PeopleView: View {
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    // Instead of this follow below line because we want to change what view model and dependency injection within it.
    // @StateObject private var vm = PeopleViewModel()
    @StateObject private var vm: PeopleViewModel
    @State private var shouldShowCreate = false
    @State private var shouldShowSuccess = false
    @State private var hasAppeared = false // For refresh the view
    
    /*
     Custom initializer for UITest
     */
    init() {
        #if DEBUG
        /* 
         Write UITesting logic here else write below for default to the standard
         view model, people view model with its default dependencies.
         */
        if UITestingHelper.isUITesting {
            // What mock injected in this view model and make mock as NetworkingManagerImpl to avoid error
            let mock: NetworkingManagerImpl = UITestingHelper.isPeopleNetworkingSuccessful ? NetworkingManagerUserResponseSuccessMock() : NetworkingManagerUserResponseFailureMock()
            
            _vm = StateObject(wrappedValue: PeopleViewModel(networkingManager: mock))
        } else {
            _vm = StateObject(wrappedValue: PeopleViewModel())
        }
        #else
            // we have to use by underscore, running for appstore or test flight and create state object
            _vm = StateObject(wrappedValue: PeopleViewModel())
        #endif
    }
    
    
    var body: some View {
        // Deleting NavigationStack because we have View+Navigation in Base Folder
        // NavigationStack {
            ZStack {
                background
                
                if vm.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(vm.users, id:\.id) { user in
                                NavigationLink{
                                    DetailView(userId: user.id)
                                } label: {
                                    PersonItemView(user: user)
                                        .accessibilityIdentifier("item_\(user.id)") // UITesting
                                        .task {
                                            if vm.hasReachedEnd(of: user) && !vm.isFetching {
                                                await vm.fetchNextSetOfUsers()
                                            }
                                        }
                                }
                            }
                        }
                        .padding()
                        .accessibilityIdentifier("peopleGrid") // For UITesting
                    }
                    .refreshable {
                        await vm.fetchUsers()
                    }
                    .overlay(alignment: .bottom) {
                        if vm.isFetching {
                            ProgressView()
                        }
                    }
                }
            }
            .navigationTitle("People")
            .toolbar{
                ToolbarItem(placement: .primaryAction) {
                    create
                }
                ToolbarItem(placement: .navigationBarLeading){
                    refresh
                }
            }
            .task {
                /*
                 User .task instead of OnAppear because onAppear is synchronous function and we were trying to achieve asynchronous code inside synchronous code. better use .task modifier comes with swiftui because its allows to kickoff asynchronous task when the view appears and it will automatically handle cancelling tasks for you when the view disappears as well.
                 
                 */
                if !hasAppeared {
                    await  vm.fetchUsers()
                    hasAppeared = true
                }
            }
            .sheet(isPresented: $shouldShowCreate){
                CreateView {
                    // For vibrate
                    haptic(.success)
                    // Start here animation view
                    withAnimation(.spring().delay(0.25)){
                        self.shouldShowSuccess.toggle()
                    }
                }
            }
            .alert(isPresented: $vm.hasError, error: vm.error) {
                Button("Retry"){
                    /*
                     Inside button we cannot use .task modifier because we actually saying that when someone taps on it we want to execute the asynchronous funtion so in this situation we use Task
                     */
                    Task {
                        await vm.fetchUsers()
                    }
                }
            }
            .overlay {
                if shouldShowSuccess {
                    CheckmarkPopoverView()
                        .transition(.scale.combined(with: .opacity))
                        .onAppear{
                            DispatchQueue.main.asyncAfter(deadline:.now() + 1.5){
                                withAnimation(.spring()){
                                    self.shouldShowSuccess.toggle()
                                }
                            }
                        }
                }
            }
            .embedInNavigation()
        //}
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
        .disabled(vm.isLoading)
        .accessibilityIdentifier("createBtn") // For UITesting
    }
    
    var refresh: some View {
        Button {
            Task {
                await vm.fetchUsers()
            }
        } label: {
            Symbols.refresh
        }
        .disabled(vm.isLoading) // When button disable should not load data
    }
    
}
