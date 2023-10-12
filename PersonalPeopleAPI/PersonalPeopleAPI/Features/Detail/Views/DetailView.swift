//
//  DetailView.swift
//  PersonalPeopleAPI
//
//  Created by Manish Parihar on 12.10.23.
//

import SwiftUI

struct DetailView: View {
    
    var body: some View {
        ZStack {
            background
            
            ScrollView {
                VStack(alignment:.leading, spacing:18) {
                    Group {
                        general
                        
                        link
                    }
                    .padding(.horizontal,8)
                    .padding(.vertical, 18)
                    .background(Theme.detailBackground,
                                in: RoundedRectangle(cornerRadius: 16,
                                                 style: .continuous))
                }
                .padding()
            }
        }
    }
}

#Preview {
    DetailView()
}

private extension DetailView {
    var background: some View {
        Theme.background
            .ignoresSafeArea(edges:.top)
    }
    
    var link: some View {
       
        Link(destination: .init(string: "https://reqres.in/")!) {
            VStack(alignment:.leading, spacing: 8){
                Text("Support Reqres")
                    .foregroundStyle(Theme.text)
                    .font(
                        .system(.body, design: .rounded)
                        .weight(.semibold)
                    )
                Text("https://reqres.in/#supporting")
            }
            Spacer()
            
            HStack {
                Symbols
                    .link
                    .font(.system(.title3, design: .rounded))
            }
        }
    }
}


private extension DetailView {
    
    var general: some View {
        VStack(alignment:.leading, spacing:8) {
            PillView(id: 0)
            
            Group {
                firstname
                 
                lastname
                 
                email
            }
            .foregroundStyle(Theme.text)
        }
    }
    
    // ViewBuilder -  we use because complier does not know what view we are trying to return, So it allow to return one or more view to return
    @ViewBuilder
    var firstname: some View {
        Text("First Name")
            .font(
                .system(.subheadline, design: .rounded)
                .weight(.semibold)
            )
        
        Text("<First Name>")
            .font(
                .system(.subheadline, design: .rounded)
            )
        
        Divider()
    }
    
    @ViewBuilder
    var lastname: some View {
        Text("Last Name")
            .font(
                .system(.subheadline, design: .rounded)
                .weight(.semibold)
            )
        
        Text("<Last Name>")
            .font(
                .system(.subheadline, design: .rounded)
            )
        
        Divider()
    }
    
    @ViewBuilder
    var email: some View {
        Text("Email")
            .font(
                .system(.subheadline, design: .rounded)
                .weight(.semibold)
            )
        
        Text("<Email>")
            .font(
                .system(.subheadline, design: .rounded)
            )
    }
}
