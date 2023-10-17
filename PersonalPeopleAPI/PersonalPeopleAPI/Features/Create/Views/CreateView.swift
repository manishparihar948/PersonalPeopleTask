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
    @FocusState private var focusedField: Field? // to make textfield not active
    @StateObject private var vm = CreateViewModel()
    let successfulAction: () -> Void // Create closure
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section {
                    firstname
                    lastname
                    job
                } footer: {
                    if case .validation(let err) = vm.error,
                       let errorDesc = err.errorDescription {
                        Text(errorDesc)
                            .foregroundStyle(.red)
                    }
                }
                
                Section {
                    submit
                }
                
                
            }
            .disabled(vm.state == .submitting)
            .navigationTitle("Create")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    done
                }
            }
            .onChange(of: vm.state){ formState in
                if formState == .successful {
                    dismiss()
                    successfulAction()
                }
            }
            .alert(isPresented: $vm.hasError,
                   error: vm.error) { }
                .overlay {
                    if vm.state == .submitting {
                        ProgressView()
                    }
                }
        }
    }
}

extension CreateView {
    enum Field: Hashable {
        case firstName
        case lastName
        case job
    }
}

#Preview {
    CreateView {}
}

private extension CreateView {
    
    var done : some View {
        Button("Done") {
            dismiss()
        }
    }
    
    var firstname: some View {
        TextField("First Name",text: $vm.person.firstName)
            .focused($focusedField, equals: .firstName)
    }
    
    var lastname: some View {
        TextField("Last Name",text: $vm.person.lastName)
            .focused($focusedField, equals: .lastName)

    }
    
    var job: some View {
        TextField("Job",text: $vm.person.job)
            .focused($focusedField, equals: .job)

    }
    
    var submit: some View {
        Button("Submit") {
            focusedField = nil // resign textfield above create function , resolve removing in log also
            Task {
                await vm.create()

            }
        }
    }
}
