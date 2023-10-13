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
        TextField("First Name",text: .constant(""))
    }
    
    var lastname: some View {
        TextField("Last Name",text: .constant(""))
    }
    
    var job: some View {
        TextField("Job",text: .constant(""))
    }
    
    var submit: some View {
        Button("Submit") {
            // TODO: Handle action
        }
    }
}
