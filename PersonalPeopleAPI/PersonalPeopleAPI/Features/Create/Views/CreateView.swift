//
//  CreateView.swift
//  PersonalPeopleAPI
//
//  Created by Manish Parihar on 13.10.23.
//

import SwiftUI

struct CreateView: View {
    
    // Done button Dismiss
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm = CreateViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                firstname
                lastname
                job
                
                Section {
                    submit
                }
                
                
            }
            .navigationTitle("Create")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    done
                }
            }
            .onChange(of: vm.state){ formState in
                if formState == .successful {
                    dismiss()
                }
            }
            .alert(isPresented: $vm.hasError,
                   error: vm.error) { }
        }
    }
}

#Preview {
    CreateView()
}

private extension CreateView {
    
    var done : some View {
        Button("Done") {
            dismiss()
        }
    }
    
    var firstname: some View {
        TextField("First Name",text: $vm.person.firstName)
    }
    
    var lastname: some View {
        TextField("Last Name",text: $vm.person.lastName)
    }
    
    var job: some View {
        TextField("Job",text: $vm.person.job)
    }
    
    var submit: some View {
        Button("Submit") {
            // TODO: Handle action
            vm.create()
        }
    }
}
